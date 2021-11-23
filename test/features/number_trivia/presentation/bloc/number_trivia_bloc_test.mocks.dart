// Mocks generated by Mockito 5.0.16 from annotations
// in xylophoneflutter/test/features/number_trivia/presentation/bloc/number_trivia_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:xylophoneflutter/core/error/failure.dart' as _i6;
import 'package:xylophoneflutter/core/usecases/usecase.dart' as _i9;
import 'package:xylophoneflutter/core/utils/input_converter.dart' as _i10;
import 'package:xylophoneflutter/features/number_trivia/domain/entities/number_trivia.dart'
    as _i7;
import 'package:xylophoneflutter/features/number_trivia/domain/repositories/number_trivia_repository.dart'
    as _i2;
import 'package:xylophoneflutter/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart'
    as _i4;
import 'package:xylophoneflutter/features/number_trivia/domain/usecases/get_random_number_trivia.dart'
    as _i8;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeNumberTriviaRepository_0 extends _i1.Fake
    implements _i2.NumberTriviaRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetConcreteNumberTrivia].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetConcreteNumberTrivia extends _i1.Mock
    implements _i4.GetConcreteNumberTrivia {
  MockGetConcreteNumberTrivia() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.NumberTriviaRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
              returnValue: _FakeNumberTriviaRepository_0())
          as _i2.NumberTriviaRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.NumberTrivia>> call(
          _i4.Params? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
          returnValue: Future<_i3.Either<_i6.Failure, _i7.NumberTrivia>>.value(
              _FakeEither_1<_i6.Failure, _i7.NumberTrivia>()),
          returnValueForMissingStub:
              Future<_i3.Either<_i6.Failure, _i7.NumberTrivia>>.value(
                  _FakeEither_1<_i6.Failure, _i7.NumberTrivia>())) as _i5
          .Future<_i3.Either<_i6.Failure, _i7.NumberTrivia>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetRandomNumberTrivia].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetRandomNumberTrivia extends _i1.Mock
    implements _i8.GetRandomNumberTrivia {
  MockGetRandomNumberTrivia() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.NumberTriviaRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
              returnValue: _FakeNumberTriviaRepository_0())
          as _i2.NumberTriviaRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.NumberTrivia>> call(
          [_i9.NoParams? noparams = const _i9.NoParams()]) =>
      (super.noSuchMethod(Invocation.method(#call, [noparams]),
          returnValue: Future<_i3.Either<_i6.Failure, _i7.NumberTrivia>>.value(
              _FakeEither_1<_i6.Failure, _i7.NumberTrivia>())) as _i5
          .Future<_i3.Either<_i6.Failure, _i7.NumberTrivia>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [InputConverter].
///
/// See the documentation for Mockito's code generation for more information.
class MockInputConverter extends _i1.Mock implements _i10.InputConverter {
  MockInputConverter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Either<_i6.Failure, int> stringToUnsignedInteger(String? str) =>
      (super.noSuchMethod(Invocation.method(#stringToUnsignedInteger, [str]),
              returnValue: _FakeEither_1<_i6.Failure, int>())
          as _i3.Either<_i6.Failure, int>);
  @override
  String toString() => super.toString();
}
