import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class ConnectivityService with ListenableServiceMixin {
  ///check if the device is connected to the internet wifi or mobile
  ///used extension [ConnectivityResultExtensions]
  bool get isConnected => listener.value.isConnected;
  late final listener = ReactiveValue(ConnectivityResult.mobile);

  ///init connectivity service
  ///listen to connectivity changes
  ///update [listener]
  ///
  ConnectivityService() {
    listenToReactiveValues([listener]);
    Connectivity().onConnectivityChanged.listen(_update);
  }

  _update(ConnectivityResult event) {
    log('$event');
    listener.value = event;
  }
}

extension ConnectivityResultExtensions on ConnectivityResult {
  bool get isConnected => ConnectivityResult.wifi == this || ConnectivityResult.mobile == this;
}
