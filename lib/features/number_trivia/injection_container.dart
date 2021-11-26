import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../core/platforms/network_info.dart';
import '../../core/utils/input_converter.dart';
import 'data/repositories/number_trivia_repository_impl.dart';
import 'data/sources/number_trivia_local_data_source.dart';
import 'data/sources/number_trivia_remote_data_source.dart';
import 'domain/repositories/number_trivia_repository.dart';
import 'domain/usecases/get_concrete_number_trivia.dart';
import 'domain/usecases/get_random_number_trivia.dart';
import 'presentation/bloc/number_trivia_bloc.dart';

// getIt
// https://resocoder.com/2019/10/21/flutter-tdd-clean-architecture-course-13-dependency-injection-user-interface/

final sl = GetIt.instance;
Future<void> setup() async {
//! Features - Number Trivia
//Bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
      inputConverter: sl(),
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
    ),
  );

// useCases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

// Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

// Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceHiveImpl(hiveInterface: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => const InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetWorkInfoImpl(
      connectionCheckCubit: sl(),
      internetConnectionChecker: sl(),
      isConnectedCheckCubit: sl()));

  //! External -- packages
  // final appDocDir = await getApplicationDocumentsDirectory();
  //   print('The application directory is: ${appDocDir.path}');
  // final hive = await Hive.initFlutter();

  sl.registerLazySingleton<HiveInterface>(() => Hive);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
