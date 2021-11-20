import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:xylophoneflutter/core/error/exceptions.dart';
import 'package:xylophoneflutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:xylophoneflutter/features/number_trivia/data/sources/number_trivia_local_data_source.dart';

import '../../../../fixtures/fixtures_reader.dart';
import 'number_trivia_local_data_source_test.mocks.dart';
// class MockHiveInterface extends Mock implements HiveInterface {}

// class MockBox extends Mock implements Box {}

@GenerateMocks([HiveInterface, Box])
void main() {
  final NumberTriviaModel tNumberTriviaModel =
      NumberTriviaModel.fromJson(fixture(fileType: FileType.intNumberTrivia));
  late NumberTriviaLocalDataSourceHiveImpl numberTriviaLocalDataSource;
  late MockHiveInterface mockHiveInterface;
  late MockBox mockBox;

  setUp(() {
    mockHiveInterface = MockHiveInterface();
    mockBox = MockBox();
    numberTriviaLocalDataSource =
        NumberTriviaLocalDataSourceHiveImpl(hiveInterface: mockHiveInterface);
  });

  group('Hive test ..', () {
    group('cacheNumberTrivia() ..', () {
      test(
          'should cache NumberTriviaModel locally when call cacheNumberTrivia() ...',
          () async {
        // arrange
        when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
        // act
        await numberTriviaLocalDataSource.cacheNumberTrivia(tNumberTriviaModel);
        //assert
        verify(mockHiveInterface.openBox(boxName));
        verify(mockBox.put(keyName, tNumberTriviaModel.toJson()));
      });

      test('should throw cache excption when call cacheNumberTrivia() ...', () {
        // arrange
        when(mockHiveInterface.openBox(any)).thenThrow(const CacheException());
        // act
        final call =
            numberTriviaLocalDataSource.cacheNumberTrivia(tNumberTriviaModel);
        //assert
        verify(mockHiveInterface.openBox(boxName));
        verifyNever(mockBox.put(keyName, tNumberTriviaModel.toJson()));
        expect(() => call, throwsA(const TypeMatcher<CacheException>()));
      });
    });
    group('getLastNumberTrivia() ... ', () {
      test(
          'should return NumberTriviaModel when call getLastNumberTrivia() ...',
          () async {
        // arrange
        when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
        when(mockBox.get(any))
            .thenAnswer((_) => fixture(fileType: FileType.intNumberTrivia));
        // act
        final result = await numberTriviaLocalDataSource.getLastNumberTrivia();
        //assert
        verify(mockHiveInterface.openBox(boxName));
        verify(mockBox.get(keyName));
        expect(result, tNumberTriviaModel);
      });

      test('should throw a CacheException when there is not a cached value',
          () {
        // arrange
        when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
        when(mockBox.get(any)).thenReturn(null);
        // act
        // Not calling the method here, just storing it inside a call variable
        final call = numberTriviaLocalDataSource.getLastNumberTrivia();
        // assert
        // Calling the method happens from a higher-order function passed.
        // This is needed to test if calling a method throws an exception.
        expect(() => call, throwsA(const TypeMatcher<CacheException>()));
      });

      test('should throw cacheException when call getLastNumberTrivia() ...',
          () {
        // arrange
        when(mockHiveInterface.openBox(any)).thenThrow(const CacheException());
        // act
        final Future<NumberTriviaModel> call =
            numberTriviaLocalDataSource.getLastNumberTrivia();
        //assert
        verify(mockHiveInterface.openBox(boxName));
        // verifyNever(mockBox.get(_keyName));
        expect(() => call, throwsA(const TypeMatcher<CacheException>()));
      });
    });
  });
}
