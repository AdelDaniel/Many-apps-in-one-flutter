import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';

import '../../core/platforms/network_info.dart';
import 'cubit/connection_check_cubit.dart';
import 'cubit/is_connected_check_cubit.dart';

final sl = GetIt.I;
Future<void> setup() async {
//! Features - Connection Check
//ConnectionCheckCubit
  sl.registerFactory<ConnectionCheckCubit>(() => ConnectionCheckCubit());
  sl.registerFactory<IsConnectedCheckCubit>(() => IsConnectedCheckCubit());
  //! core
  // sl.registerLazySingleton<NetworkInfo>(() => ConnectivityPlusNetworkInfoImpl(
  //     connectionCheckCubit: sl(), connectivity: sl()));

  //! External -- packages
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  //! start connection stream
  // sl<ConnectivityPlusNetworkInfoImpl>().checkConnectionStream();
  sl<NetworkInfo>().checkConnectionStream();
}
