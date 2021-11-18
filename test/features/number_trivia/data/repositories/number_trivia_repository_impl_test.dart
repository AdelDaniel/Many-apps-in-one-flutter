import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:xylophoneflutter/core/error/exceptions.dart';
import 'package:xylophoneflutter/core/error/failure.dart';
import 'package:xylophoneflutter/core/platforms/network_info.dart';
import 'package:xylophoneflutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:xylophoneflutter/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:xylophoneflutter/features/number_trivia/data/sources/number_trivia_local_data_source.dart';
import 'package:xylophoneflutter/features/number_trivia/data/sources/number_trivia_remote_data_source.dart';
import 'package:xylophoneflutter/features/number_trivia/domain/entities/number_trivia.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

// class MockNetworkInfo extends Mock implements NetworkInfo {}

// class MockNumberTriviaLocalDataSource extends Mock
//     implements NumberTriviaLocalDataSource {}

// class MockNumberTriviaRemoteDataSource extends Mock
//     implements NumberTriviaRemoteDataSource {}

@GenerateMocks(
    [NumberTriviaRemoteDataSource, NumberTriviaLocalDataSource, NetworkInfo])
void main() {
  late NumberTriviaRepositoryImpl numberTriviaRepositoryImpl;
  late MockNumberTriviaLocalDataSource mockLocalDataSource;
  late MockNumberTriviaRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  const int tNumber = 1;
  const NumberTriviaModel tNumberTriviaModel = NumberTriviaModel(
      found: true, number: 1, text: "test text", type: "trivia");
  const NumberTrivia tNumberTrivia = tNumberTriviaModel;

  setUp(() {
    mockLocalDataSource = MockNumberTriviaLocalDataSource();
    mockRemoteDataSource = MockNumberTriviaRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    numberTriviaRepositoryImpl = NumberTriviaRepositoryImpl(
        localDataSource: mockLocalDataSource,
        remoteDataSource: mockRemoteDataSource,
        networkInfo: mockNetworkInfo);

    print('setUp Before Each: \n ');
  });

// getConcreteNumberTrivia &&  getRandomNumberTrivia
// online && offline

  void _runTestsOnline({required Function allTests}) {
    group('Device is online ... ', () {
      setUp(() =>
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true));
      test('should check if the device is online...', () {
        // act
        numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
        // assertions
        verify(mockNetworkInfo.isConnected);
      });

      allTests();
    });
  }

  void _runTestsOffline({required Function allTests}) {
    group('Device is offline  ... ', () {
      setUp(() =>
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false));

      test('Check the Device is offline', () {
        // act
        numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
        // assertion
        verify(mockNetworkInfo.isConnected);
      });

      allTests();
    });
  }

  /// all [getConcreteNumberTrivia] tests
  group('getConcreteNumberTrivia() ...', () {
    _runTestsOnline(allTests: () {
      test(
          'should return Right(tNumberTrivia) && Save it to cahce when call getConcreteNumberTrivia() ',
          () async {
        // arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
            .thenAnswer((_) async => tNumberTriviaModel);

        // act
        final actualResult =
            await numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
        // assertions
        expect(actualResult, const Right(tNumberTrivia));
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });
      test(
          'should return Left(ServerFailure) when call getConcreteNumberTrivia() -- cause there is a problem in API...',
          () async {
        // arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
            .thenThrow(const ServerException());

        // act
        final actualResult =
            await numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
        // assertions
        expect(actualResult, equals(const Left(ServerFailure())));
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verifyNever(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });

      test(
          'should return Left(CacheFailure()) when call getConcreteNumberTrivia() -- cause there is a problem in cahching the new value...',
          () async {
        // arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
            .thenAnswer((_) async => tNumberTriviaModel);
        when(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel))
            .thenThrow(const CacheException());

        // act
        final actualResult =
            await numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
        // assertions
        expect(actualResult, const Left(CacheFailure()));
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });
    });

    _runTestsOffline(allTests: () {
      test(
          'should return Right(NumberTriviaModel) when call getConcerteNumberTrivia ... ',
          () async {
        // arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        // act
        final actualResult =
            await numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
        // assertion
        expect(actualResult, const Right(tNumberTrivia));
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
      });

      test(
          'should return Left(CahedFailute) when call getConcerteNumberTrivia cause problem while loading data from the cache... ',
          () async {
        // arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(const CacheException());
        // act
        final actualResult =
            await numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
        // assertion
        expect(actualResult, const Left(CacheFailure()));
        verify(mockLocalDataSource.getLastNumberTrivia());
        verifyZeroInteractions(mockRemoteDataSource);
      });
    });
  });

  /// all [getRandomNumberTrivia] tests
  group('getRandomNumberTrivia() ...', () {
    group('Device is Online ... ', () {
      setUp(() =>
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true));
      test('Check the Device is online ', () {
        // act
        numberTriviaRepositoryImpl.getRandomNumberTrivia();
        // assertion
        verify(mockNetworkInfo.isConnected);
      });

      test(
          'should return Right(NumberTriviaModel) when call getRandomNumberTrivia from remoteDataSource .. ',
          () async {
        // arrang
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        when(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel))
            .thenAnswer((_) async => Void);
        // act
        final actualResult =
            await numberTriviaRepositoryImpl.getRandomNumberTrivia();
        // assertion

        expect(actualResult, const Right(tNumberTrivia));
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });
    });

    group('Device is offline ... ', () {
      setUp(() =>
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false));
      test('Check the Device is offline ', () {
        // act
        numberTriviaRepositoryImpl.getRandomNumberTrivia();
        // assertion
        verify(mockNetworkInfo.isConnected);
      });

      test(
          'should return Right(NumberTriviaModel) when call getRandomTriviaModel ... ',
          () async {
        // arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        // act
        final actualResult =
            await numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
        // assertion
        expect(actualResult, const Right(tNumberTrivia));
        verify(mockLocalDataSource.getLastNumberTrivia());
      });

      test(
          'should return Left(CahedFailute) when call getRandomTriviaModel cause problem while loading data from the cache... ',
          () async {
        // arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(const CacheException());
        // act
        final actualResult =
            await numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
        // assertion
        expect(actualResult, const Left(CacheFailure()));
        verify(mockLocalDataSource.getLastNumberTrivia());
      });
    });
  });
}
