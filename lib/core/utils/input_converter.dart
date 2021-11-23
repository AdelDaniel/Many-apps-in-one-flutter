// It will have a single method called stringToUnsignedInteger. That's because in addition to just parsing strings, it will also make sure that the inputted number isn't negative.

// To make testing easier, let's create an empty method together with the Failure which will be returned if the number is invalid.

import 'package:dartz/dartz.dart';
import 'package:xylophoneflutter/core/error/failure.dart';

class InputConverter {
  const InputConverter();
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final int result = int.parse(str);
      if (result < 0) throw const FormatException();
      return Right(result);
    } on FormatException {
      return const Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  static const String _message =
      'Invalid Input - The number must be a positive integer or zero.';
  const InvalidInputFailure();
  @override
  String get message => _message;
}
