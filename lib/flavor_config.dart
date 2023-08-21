import 'package:flutter/foundation.dart';

late final Flavor flavor;

/// The [Flavor] class is used to configure the app for different environments.
/// socket will be connected on channel 20 for dev and 40 for prod
/// can be provided different tokens for dev and prod environments
enum Flavor {
  dev(channel: 20, token: "e2b8fdef4b89afdd8f7249d7343fcdaa"),
  prod(channel: 40, token: "e2b8fdef4b89afdd8f7249d7343fcdaa", isRelease: kReleaseMode);

  final String socketUrl;
  final bool isRelease;
  final int channel;
  final String token;

  const Flavor({required this.channel, required this.token, this.isRelease = false})
      : socketUrl = "wss://socketsbay.com/wss/v2/$channel/$token/";
}
