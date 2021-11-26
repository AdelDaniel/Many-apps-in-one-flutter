import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:xylophoneflutter/features/connection_check/cubit/is_connected_check_cubit.dart';

import '../../features/connection_check/cubit/connection_check_cubit.dart';

abstract class NetworkInfo {
  const NetworkInfo();
  Future<bool> get isConnected;
  void checkConnectionStream();
}

class NetWorkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;
  final ConnectionCheckCubit connectionCheckCubit;
  final IsConnectedCheckCubit isConnectedCheckCubit;
  const NetWorkInfoImpl(
      {required this.internetConnectionChecker,
      required this.connectionCheckCubit,
      required this.isConnectedCheckCubit});

  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;

  @override
  void checkConnectionStream() {
    // actively listen for status updates
    internetConnectionChecker.onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            connectionCheckCubit.connected();
            isConnectedCheckCubit.connected();
            // ignore: avoid_print
            print('Data connection is available.');
            break;
          case InternetConnectionStatus.disconnected:
            connectionCheckCubit.notConnected();
            isConnectedCheckCubit.notConnected();
            // ignore: avoid_print
            print('You are disconnected from the internet.');
            break;
        }
      },
    );
  }
}

// class ConnectivityPlusNetworkInfoImpl implements NetworkInfo {
//   final Connectivity connectivity;
//   final ConnectionCheckCubit connectionCheckCubit;
//   const ConnectivityPlusNetworkInfoImpl(
//       {required this.connectivity, required this.connectionCheckCubit});

//   @override
//   Future<bool> get isConnected async {
//     final connectivityResult = await connectivity.checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       return false;
//     }
//     return true;
//   }

//   @override
//   void checkConnectionStream() {
//     connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
//       if (result == ConnectivityResult.none) {
//         connectionCheckCubit.notConnected();
//         print('\n\n\n adel \n\n\n');
//       } else {
//         connectionCheckCubit.connected();
//       }
//     });
//   }
// }
