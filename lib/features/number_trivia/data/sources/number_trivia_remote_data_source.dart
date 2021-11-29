import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  const NumberTriviaRemoteDataSource();

  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;
  const NumberTriviaRemoteDataSourceImpl({required this.client});

// http://numbersapi.com/42
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      _getConcreteNumberTrivia(stringURL: 'http://numbersapi.com/$number');

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getConcreteNumberTrivia(stringURL: 'http://numbersapi.com/random');

  Future<NumberTriviaModel> _getConcreteNumberTrivia(
      {required String stringURL}) async {
    try {
      final url = Uri.parse(stringURL);
      final response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials":
              "true", // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "GET, HEAD",
        },
      );
      if (response.statusCode != 200) {
        throw const ServerException();
      }
      return NumberTriviaModel.fromJson(response.body);
    } catch (e) {
      print(e);
      throw const ServerException();
    }
  }
}
