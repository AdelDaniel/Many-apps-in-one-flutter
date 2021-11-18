import 'package:dartz/dartz.dart';
import 'package:xylophoneflutter/core/error/exceptions.dart';
import 'package:xylophoneflutter/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/platforms/network_info.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_trivia_repository.dart';
import '../sources/number_trivia_local_data_source.dart';
import '../sources/number_trivia_remote_data_source.dart';

typedef ConcreteOrRandomChooser = Future<NumberTriviaModel> Function();

/// the repo fucntions [getConcreteNumberTrivia] and [getRandomNumberTrivia]
/// both must return Entity Number Instead of Model N
class NumberTriviaRepositoryImpl extends NumberTriviaRepository {
  final NumberTriviaLocalDataSource localDataSource;
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  const NumberTriviaRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return _getTheNumber(
        () => remoteDataSource.getConcreteNumberTrivia(number));
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return _getTheNumber(() => remoteDataSource.getRandomNumberTrivia());
  }

  Future<Either<Failure, NumberTrivia>> _getTheNumber(
      ConcreteOrRandomChooser functionToCall) async {
    //  networkInfo.isConnected;
    if (await networkInfo.isConnected) {
      try {
        final NumberTriviaModel result = await functionToCall();
        //caching the last result
        localDataSource.cacheNumberTrivia(result);
        return Right(result);
      } on ServerException catch (e) {
        print(e.massege);
        return const Left(ServerFailure());
      } on CacheException catch (e) {
        print(e.massege);
        return const Left(CacheFailure());
      }
    } else {
      try {
        final NumberTriviaModel result =
            await localDataSource.getLastNumberTrivia();
        return Right(result);
      } on CacheException catch (e) {
        print(e.massege);
        return const Left(CacheFailure());
      }
    }
  }
}
