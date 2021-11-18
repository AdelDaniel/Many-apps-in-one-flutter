import 'package:flutter_test/flutter_test.dart';
import 'package:xylophoneflutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:xylophoneflutter/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  const NumberTriviaModel tIntNumberTriviaModel = NumberTriviaModel(
    text: "Test Text",
    number: 1,
    found: true,
    type: "trivia",
  );

  test('should be a sub class of class NumberTrivia Enitiy...', () async {
    // assert
    expect(tIntNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test(
        'should return a NumberTriviaModel when call fromJson and the JSON number is integer',
        () async {
      // act
      final NumberTriviaModel result =
          NumberTriviaModel.fromJson(fixture('number_trivia_int.json'));
      // assert
      expect(result, tIntNumberTriviaModel);
    });

    test(
        'should return a NumberTriviaModel when call fromJson and the JSON number is double',
        () async {
      // act
      final NumberTriviaModel result =
          NumberTriviaModel.fromJson(fixture('number_trivia_double.json'));
      // assert
      expect(result, tIntNumberTriviaModel);
    });
  });

  group('ToJson', () {
    test(
        'should return a Json String when call ToJson and NumberTriviaModel.number is integer',
        () async {
      // act
      final String actualResult = tIntNumberTriviaModel.toJson();
      final expected = fixture('number_trivia_int.json');
      final actualResultObject = NumberTriviaModel.fromJson(actualResult);
      final expectedObject = NumberTriviaModel.fromJson(expected);
      // assert
      expect(actualResultObject, expectedObject);
    });
  });
}
