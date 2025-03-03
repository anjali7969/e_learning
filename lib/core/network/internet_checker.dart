import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class InternetChecker {
  Future<bool> get isConnected;
  Stream<bool> get connectionStream;
}

class InternetCheckerImpl implements InternetChecker {
  final InternetConnection connectionChecker;

  InternetCheckerImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasInternetAccess;

  @override
  Stream<bool> get connectionStream => connectionChecker.onStatusChange
      .map((status) => status == InternetStatus.connected);
}
