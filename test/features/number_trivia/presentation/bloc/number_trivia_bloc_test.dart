import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:xylophoneflutter/core/error/failure.dart';
import 'package:xylophoneflutter/core/utils/input_converter.dart';
import 'package:xylophoneflutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:xylophoneflutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:xylophoneflutter/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:xylophoneflutter/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:xylophoneflutter/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import '../../../../fixtures/fixtures_reader.dart';
import 'number_trivia_bloc_test.mocks.dart';
// class MockGetConcreteNumberTrivia extends Mock
//     implements GetConcreteNumberTrivia {}

// class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

// class MockInputConverter extends Mock implements InputConverter {}

@GenerateMocks([GetConcreteNumberTrivia, GetRandomNumberTrivia, InputConverter])
void main() {
  late NumberTriviaBloc numberTriviaBloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;
  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    numberTriviaBloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  group('NumberTriviaBloc ..', () {
    test('should initial state is [EmptyInitialState] .. ',
        () => expect(numberTriviaBloc.state, equals(EmptyInitialState())));
    group('GetConcreteNumberEvent ..', () {
      // data needed in this group ..
      // The event takes in a String
      const String tNumberString = '1';
      // This is the successful output of the InputConverter
      final tNumberParsed = int.parse(tNumberString);
      // NumberTrivia instance is needed too, of course
      final NumberTrivia tNumberTrivia = NumberTriviaModel.fromJson(
          fixture(fileType: FileType.intNumberTrivia));

      void setUpMockInputConverterSuccess() =>
          when(mockInputConverter.stringToUnsignedInteger(any))
              .thenReturn(Right(tNumberParsed));

      test(
        'should call the [InputConverter] to validate and convert the string to an unsigned integer',
        () async {
          // arrange
          setUpMockInputConverterSuccess();
          when(mockGetConcreteNumberTrivia.call(any))
              .thenAnswer((_) async => Right(tNumberTrivia));
          // act
          numberTriviaBloc
              .add(const GetConcreteNumberEvent(number: tNumberString));
          await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
          // assert
          verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
        },
      );

      test(
        'should only get data from the concrete use case',
        () async {
          // arrange
          setUpMockInputConverterSuccess();
          when(mockGetConcreteNumberTrivia(any))
              .thenAnswer((_) async => Right(tNumberTrivia));
          // act
          numberTriviaBloc
              .add(const GetConcreteNumberEvent(number: tNumberString));
          await untilCalled(mockGetConcreteNumberTrivia(any));
          // assert
          verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
        },
      );

      //!not working test
      // test(
      //     'should emits [EmptyInitialState , ErrorState] when add event [getConcreteNumberTrivia] with invaildString ',
      //     () {
      //   // arrange
      //   when(mockInputConverter.stringToUnsignedInteger(any))
      //       .thenReturn(const Left(InvalidInputFailure()));
      //   // assert later
      //   final expected = [
      //     LoadingState(),
      //     ErrorState(message: const InvalidInputFailure().message)
      //   ];
      //   expectLater(numberTriviaBloc.state, emitsInOrder(expected));
      //   // act
      //   numberTriviaBloc
      //       .add(const GetConcreteNumberEvent(number: tNumberString));
      // });

      blocTest<NumberTriviaBloc, NumberTriviaState>(
        'should emits [LoadingState, ErrorState(InputConvert failure..)] when add event [getConcreteNumberTrivia] with invaildString ',
        build: () => numberTriviaBloc,
        setUp: () => when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(const Left(InvalidInputFailure())),
        act: (bloc) =>
            bloc.add(const GetConcreteNumberEvent(number: tNumberString)),
        expect: () => [
          LoadingState(),
          ErrorState(message: const InvalidInputFailure().message)
        ],
      );

      blocTest<NumberTriviaBloc, NumberTriviaState>(
        'should emits [LoadingState , ErrorState(cache failure..)] when add event [getConcreteNumberTrivia] with Valid String ',
        build: () => numberTriviaBloc,
        setUp: () {
          setUpMockInputConverterSuccess();
          when(mockGetConcreteNumberTrivia.call(Params(number: tNumberParsed)))
              .thenAnswer((_) async => const Left(CacheFailure()));
        },
        act: (bloc) =>
            bloc.add(const GetConcreteNumberEvent(number: tNumberString)),
        verify: (bloc) {
          verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
          verify(
              mockGetConcreteNumberTrivia.call(Params(number: tNumberParsed)));
        },
        expect: () => [
          LoadingState(),
          ErrorState(message: const CacheFailure().message),
        ],
      );

      blocTest<NumberTriviaBloc, NumberTriviaState>(
        'should emits [LoadingState , ErrorState(Server failure..)] when add event [getConcreteNumberTrivia] with Valid String ',
        build: () => numberTriviaBloc,
        setUp: () {
          setUpMockInputConverterSuccess();
          when(mockGetConcreteNumberTrivia.call(Params(number: tNumberParsed)))
              .thenAnswer((_) async => const Left(ServerFailure()));
        },
        act: (bloc) =>
            bloc.add(const GetConcreteNumberEvent(number: tNumberString)),
        verify: (bloc) {
          verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
          verify(
              mockGetConcreteNumberTrivia.call(Params(number: tNumberParsed)));
        },
        expect: () => [
          LoadingState(),
          ErrorState(message: const ServerFailure().message),
        ],
      );

      blocTest<NumberTriviaBloc, NumberTriviaState>(
        'should emits [LoadingState , LoadedState(NumberTrivia)] when add event [getConcreteNumberTrivia] with Valid String ',
        build: () => numberTriviaBloc,
        setUp: () {
          setUpMockInputConverterSuccess();
          when(mockGetConcreteNumberTrivia.call(Params(number: tNumberParsed)))
              .thenAnswer((_) async => Right(tNumberTrivia));
        },
        act: (bloc) =>
            bloc.add(const GetConcreteNumberEvent(number: tNumberString)),
        verify: (bloc) {
          verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
          verify(
              mockGetConcreteNumberTrivia.call(Params(number: tNumberParsed)));
        },
        expect: () => [
          LoadingState(),
          LoadedState(numberTrivia: tNumberTrivia),
        ],
      );
    });

    group('GetRandomNumberEvent ..', () {
      final NumberTrivia tNumberTrivia = NumberTriviaModel.fromJson(
          fixture(fileType: FileType.intNumberTrivia));

      test(
        'should only get data from the Random use case',
        () async {
          // arrange
          when(mockGetRandomNumberTrivia())
              .thenAnswer((_) async => Right(tNumberTrivia));
          // act
          numberTriviaBloc.add(const GetRandomNumberEvent());
          await untilCalled(mockGetRandomNumberTrivia());
          // assert
          verify(mockGetRandomNumberTrivia());
        },
      );

      blocTest<NumberTriviaBloc, NumberTriviaState>(
        'should emits [LoadingState , ErrorState(cache failure..)] when add event [getRandomNumberTrivia] ',
        build: () => numberTriviaBloc,
        setUp: () => when(mockGetRandomNumberTrivia.call())
            .thenAnswer((_) async => const Left(CacheFailure())),
        act: (bloc) => bloc.add(const GetRandomNumberEvent()),
        verify: (bloc) => verify(mockGetRandomNumberTrivia.call()),
        expect: () => [
          LoadingState(),
          ErrorState(message: const CacheFailure().message),
        ],
      );

      blocTest<NumberTriviaBloc, NumberTriviaState>(
        'should emits [LoadingState , ErrorState(Server failure..)] when add event [getRandomNumberTrivia] ',
        build: () => numberTriviaBloc,
        setUp: () => when(mockGetRandomNumberTrivia.call())
            .thenAnswer((_) async => const Left(ServerFailure())),
        act: (bloc) => bloc.add(const GetRandomNumberEvent()),
        verify: (bloc) => verify(mockGetRandomNumberTrivia.call()),
        expect: () => [
          LoadingState(),
          ErrorState(message: const ServerFailure().message),
        ],
      );

      blocTest<NumberTriviaBloc, NumberTriviaState>(
        'should emits [LoadingState , LoadedState(NumberTrivia)] when add event [getRandomNumberTrivia] ',
        build: () => numberTriviaBloc,
        setUp: () => when(mockGetRandomNumberTrivia.call())
            .thenAnswer((_) async => Right(tNumberTrivia)),
        act: (bloc) => bloc.add(const GetRandomNumberEvent()),
        verify: (bloc) => verify(mockGetRandomNumberTrivia.call()),
        expect: () => [
          LoadingState(),
          LoadedState(numberTrivia: tNumberTrivia),
        ],
      );
    });
  });
}
