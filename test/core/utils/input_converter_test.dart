import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xylophoneflutter/core/utils/input_converter.dart';

void main() {
  late InputConverter inputConverter;
  const String tIntAsString = "1";
  const String tNotValidNumberAsString = "Da";
  const String tNegativeNumberAsString = "-1";
  const String tDoubleAsString = "1.0";

  const int tInt = 1;

  setUp(() {
    inputConverter = const InputConverter();
  });

  test('should return Right(int) when convert the (int number as string) .. ',
      () {
    // act
    final actualResult = inputConverter.stringToUnsignedInteger(tIntAsString);
    // assertion
    expect(actualResult, const Right(tInt));
  });

  test(
      'should return Left(InvalidInputFailure) when convert the (double number as string) .. ',
      () {
    // act
    final actualResult =
        inputConverter.stringToUnsignedInteger(tDoubleAsString);
    // assertion
    expect(actualResult, const Left(InvalidInputFailure()));
  });

  test(
      'should return Left(InvalidInputFailure) when convert the (not valid number as string) .. ',
      () {
    // act
    final actualResult =
        inputConverter.stringToUnsignedInteger(tNotValidNumberAsString);
    // assertion
    expect(actualResult, const Left(InvalidInputFailure()));
  });

  test(
      'should return Left(InvalidInputFailure) when convert the (negative number as string) .. ',
      () {
    // act
    final actualResult =
        inputConverter.stringToUnsignedInteger(tNegativeNumberAsString);
    // assertion
    expect(actualResult, const Left(InvalidInputFailure()));
  });
}
