import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:xylophoneflutter/core/error/exceptions.dart';
import 'package:xylophoneflutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:xylophoneflutter/features/number_trivia/data/sources/number_trivia_remote_data_source.dart';

import '../../../../fixtures/fixtures_reader.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

// class MockClient extends Mock implements http.Client {}

@GenerateMocks([http.Client])
void main() {
  late NumberTriviaRemoteDataSourceImpl remoteDataSource;
  late MockClient mockClient;

  const int tIntNumber = 1;
  final tIntNumberTrivia =
      NumberTriviaModel.fromJson(fixture(fileType: FileType.intNumberTrivia));

  setUp(() {
    mockClient = MockClient();
    remoteDataSource = NumberTriviaRemoteDataSourceImpl(client: mockClient);
  });

  void setMockClientSuccessGetRequest200() =>
      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async =>
              http.Response(fixture(fileType: FileType.intNumberTrivia), 200));

  void setMockClientFailsGetRequestNot200() =>
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response("Oops Error! ", 400));
  group('getConcreteNumberTrivia() .. ', () {
    test(
      'should preform a GET request on a URL with number being the endpoint and with application/json header',
      () {
        //arrange
        setMockClientSuccessGetRequest200();
        // act
        final url = Uri.parse('http://numbersapi.com/$tIntNumber');
        remoteDataSource.getConcreteNumberTrivia(tIntNumber);
        // assert
        verify(mockClient.get(
          url,
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );
    test(
        'should return NumberTriviaModel when call getConcreteNumberTrivia() statusCode = 200 ..',
        () async {
      // Arrange,
      setMockClientSuccessGetRequest200();
      // act
      final actualResult =
          await remoteDataSource.getConcreteNumberTrivia(tIntNumber);
      // assertion
      expect(actualResult, tIntNumberTrivia);
    });

    test(
        'should Throw ServerException() when call getConcreteNumberTrivia() statusCode = Not 200 ..',
        () async {
      // Arrange,
      setMockClientFailsGetRequestNot200();
      // act
      final actualResult = remoteDataSource.getConcreteNumberTrivia;
      // assertion
      expect(() => actualResult(tIntNumber),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getRandomNumberTrivia() .. ', () {
    test(
      'should preform a GET request on a URL with number being the endpoint and with application/json header',
      () {
        //arrange
        setMockClientSuccessGetRequest200();
        // act
        final url = Uri.parse('http://numbersapi.com/random');
        remoteDataSource.getRandomNumberTrivia();
        // assert
        verify(mockClient.get(
          url,
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );
    test(
        'should return NumberTriviaModel when call getRandomNumberTrivia() statusCode = 200 ..',
        () async {
      // Arrange,
      setMockClientSuccessGetRequest200();
      // act
      final actualResult = await remoteDataSource.getRandomNumberTrivia();
      // assertion
      expect(actualResult, tIntNumberTrivia);
    });

    test(
        'should Throw ServerException() when call getRandomNumberTrivia() statusCode = Not 200 ..',
        () async {
      // Arrange,
      setMockClientFailsGetRequestNot200();
      // act
      final actualResult = remoteDataSource.getRandomNumberTrivia;
      // assertion
      expect(
          () => actualResult(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
