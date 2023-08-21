// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:retry/retry.dart';
import 'package:stacked/stacked.dart';
import 'package:web_socket_channel/io.dart';

import '../data/socket_commands.dart';
import '../flavor_config.dart';
import '../locator.dart';
import '../resources/strings/tr.dart';
import 'chat_service.dart';
import 'connectivity_service.dart';

const int _minRetryAttempts = 5;
const Duration _minDelay = Duration(milliseconds: 200);
const Duration _maxDelay = Duration(seconds: 5);

@lazySingleton
class SocketService {
  late final _connectivity = sl<ConnectivityService>(), status = ReactiveValue(SocketConnectionStatus.disconnected);

  IOWebSocketChannel? _channel;
  StreamSubscription? _channelSubscription; // listen to the socket
  bool _reconnectWhenOnline = false; // used to reconnecting when the internet is back online

  /// The number of attempts to reconnect to the socket
  int get _attempts {
    var tolerance = const Duration(seconds: 10);
    log('Socket Tolerance: $tolerance');
    int attempt = _minRetryAttempts;
    var delay = _minDelay;
    bool canUpdateDelay = true;

    // calculate the number of attempts to reconnect
    while (tolerance >= Duration.zero) {
      attempt++;
      if (canUpdateDelay) delay *= 2;
      if (delay < _maxDelay) {
        tolerance -= delay;
      } else {
        tolerance -= _maxDelay;
        canUpdateDelay = false;
      }
    }
    log('Socket Retry attempts: $attempt');
    return attempt;
  }


  /// listen internet status and reconnect when the internet is back online
  SocketService() {
    _connectivity.listener.listen((ConnectivityResult connectivity) {
      final connected = connectivity.isConnected;
      if (!connected) {
        disconnect();
      } else if (_reconnectWhenOnline) {
        _reconnect(ReconnectType.internet);
      }
      _reconnectWhenOnline = !connected;
    });
  }

  Future connect() async => await _tryConnect().then(_onConnected, onError: _fail);

  ///disconnect from socket, sets values to the default
  disconnect() {
    status.value = SocketConnectionStatus.disconnected;
    _channelSubscription?.cancel();
    _channelSubscription = null;
    _channel?.sink.close();
    _channel = null;
  }

  /// all the socket events are handled here
  _newEvent(event) {
    log('Socket Event: $event');
    late final IncomingSocketCommand command;
    try {
      command = IncomingSocketCommand.fromJson(jsonDecode(event.trim()));
    } catch (e) {
      if (event is String) {
        return navigator.dialog(title: Tr.popupTitleError(), description: "unhandled socket event \n $event");
      }
    }
    return switch (command) {
      IncomingChatCommand() => sl<ChatService>().onNewMessage(command),
      _ => log('Unhandled Socket Event: $event')
    };
  }


  ///tries to connect to the socket
  ///if the connection fails, it will retry to connect
  ///if the connection fails after the max attempts, it will show an error popup
  ///to achieve this, we use the [retry] package
  Future _tryConnect() => retry(maxAttempts: _attempts, delayFactor: _minDelay, maxDelay: _maxDelay, () async {
    if (_channel != null && _channel!.closeCode == null) {
      log('Socket already connected');
    } else {
      status.value = SocketConnectionStatus.connecting;
      WebSocket socket = await WebSocket.connect(flavor.socketUrl);
      _channel = IOWebSocketChannel(socket);
      if (_channelSubscription != null) _channelSubscription?.cancel();
      _channelSubscription = _channel?.stream.listen(
        _newEvent,
        onDone: _done,
        onError: (e, s) => log('Socket Error $e $s'),
      );
    }
    status.value = SocketConnectionStatus.connected;
  });

  ///on socket connected successfully
  _onConnected(_) async {
    log('Socket Connect Success');
  }

  ///on socket connection failed
  _fail(e, s) async {
    log('Socket Reconnect Error $e, $s');
    navigator.dialog(title: Tr.popupTitleError(), description: Tr.errorSocketConnection());
  }

  ///on socket connection is closed
  _done() {
    disconnect();
    _reconnectWhenOnline = !_connectivity.isConnected;
    if (!_reconnectWhenOnline) _reconnect(ReconnectType.normal);
  }

  _reconnect(ReconnectType type) => _tryConnect().then(_onReconnected, onError: _fail);

  ///on socket re-connected successfully
  _onReconnected(_) async {
    log('Socket Reconnect Success');
  }

  ///send a command to the socket
  send(OutGoingSocketCommand action) {
    log('Socket Send: $action $_channel');
    if (_channel == null) return;
    final json = action.toJson();
    log('Socket Send: $json');
    _channel?.sink.add(jsonEncode(json));
  }
}

enum ReconnectType { normal, internet }

enum SocketConnectionStatus { disconnected, connecting, connected }
