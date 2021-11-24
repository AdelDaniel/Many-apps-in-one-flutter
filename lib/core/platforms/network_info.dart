import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  const NetworkInfo();
  Future<bool> get isConnected;
}

class NetWorkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;
  const NetWorkInfoImpl(this.internetConnectionChecker);

  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
