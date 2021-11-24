import 'package:hive/hive.dart';

import '../../../../core/error/exceptions.dart';
import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  const NumberTriviaLocalDataSource();

  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const String boxName = "NumberTriviaBox";
const String keyName = "LastNumberTrivia";

class NumberTriviaLocalDataSourceHiveImpl
    implements NumberTriviaLocalDataSource {
  final HiveInterface hiveInterface;
  const NumberTriviaLocalDataSourceHiveImpl({required this.hiveInterface});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    try {
      final box = await _openBox();
      return NumberTriviaModel.fromJson(await box.get(keyName) as String);
      // final jsonValue = await box.get(_keyName);
      // if (jsonValue == null) {
      //   throw const NoCachedDataException();
      // } else {
      //   return NumberTriviaModel.fromJson(jsonValue as String);
      // }
    } catch (e) {
      throw const CacheException();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaToCache) async {
    try {
      final box = await _openBox();
      await box.put(keyName, numberTriviaToCache.toJson());
    } catch (e) {
      throw const CacheException();
    }
  }

  Future<Box> _openBox() async {
    try {
      return await hiveInterface.openBox(boxName);
    } catch (e) {
      throw const CacheException();
    }
  }
}

// class NumberTriviaLocalDataSourceSharedPrefImpl
//     implements NumberTriviaLocalDataSource {
//   // final HiveInterface hiveInterface;
//   // const NumberTriviaLocalDataSourceHiveImpl({required this.hiveInterface});

//   @override
//   Future<NumberTriviaModel> getLastNumberTrivia() {
//     // TODO: implement getLastNumberTrivia
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaToCache) async {
//     // TODO: implement getLastNumberTrivia
//     throw UnimplementedError();
//   }
// }
