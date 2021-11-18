import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:xylophoneflutter/core/usecases/usecase.dart';
import 'package:xylophoneflutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:xylophoneflutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:xylophoneflutter/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

import 'get_random_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  late GetRandomNumberTrivia getRandomNumberTrivia;
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  const tNumberTrivia =
      NumberTrivia(number: 1, text: 'test', found: true, type: '');

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    getRandomNumberTrivia = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  test('should get Random Trivia Number ....', () async {
    //arrange
    when(mockNumberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((_) async => const Right(tNumberTrivia));
    // act
    // Since random number doesn't require any parameters, we pass in NoParams
    final result = await getRandomNumberTrivia(const NoParams());
    //assert
    // UseCase should simply return whatever was returned from the Repository
    expect(result, const Right(tNumberTrivia));
    // Verify that the method has been called on the Repository
    verify(mockNumberTriviaRepository.getRandomNumberTrivia());
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
