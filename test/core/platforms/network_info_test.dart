import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:xylophoneflutter/core/platforms/network_info.dart';
import 'network_info_test.mocks.dart';

// class MockInternetConnectionChecker extends Mock
//     implements InternetConnectionChecker {}

@GenerateMocks([InternetConnectionChecker])
void main() {
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late NetWorkInfoImpl netWorkInfoImpl;
  final tTrueConnectionFuture = Future.value(true);
  final tFalseHasConnectionFuture = Future.value(false);

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    netWorkInfoImpl = NetWorkInfoImpl(mockInternetConnectionChecker);
  });
  test('should return true when there is internet connection ', () {
    // arrange
    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) => tTrueConnectionFuture);
    // act
    // NOTICE: We're NOT awaiting the result
    // we are test Future.value(true) ::: not testing true or false
    // (true or false) is a bool value :::  (Future.value(true)) is address value
    final actualResult = netWorkInfoImpl.isConnected;
    // assert
    verify(mockInternetConnectionChecker.hasConnection);
    // Utilizing Dart's default referential equality.
    // Only references to the same object are equal.
    expect(actualResult, equals(tTrueConnectionFuture));
  });

  test('should return False when No internet connection ', () {
    // arrange
    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) => tFalseHasConnectionFuture);
    // act
    final actualResult = netWorkInfoImpl.isConnected;
    // assert
    verify(mockInternetConnectionChecker.hasConnection);
    expect(actualResult, equals(tFalseHasConnectionFuture));
  });
}
