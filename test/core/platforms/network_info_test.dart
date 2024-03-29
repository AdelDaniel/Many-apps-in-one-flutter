import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:xylophoneflutter/core/platforms/network_info.dart';
import 'package:xylophoneflutter/features/connection_check/cubit/connection_check_cubit.dart';
import 'package:xylophoneflutter/features/connection_check/cubit/is_connected_check_cubit.dart';
// import 'network_info_test.mocks.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

class MockConnectionCheckCubit extends Mock implements ConnectionCheckCubit {}

class MockIsConnectedCheckCubit extends Mock implements IsConnectedCheckCubit {}

@GenerateMocks(
    [InternetConnectionChecker, ConnectionCheckCubit, IsConnectedCheckCubit])
void main() {
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late NetWorkInfoImpl netWorkInfoImpl;
  late MockConnectionCheckCubit mockConnectionCheckCubit;
  late MockIsConnectedCheckCubit isConnectedCheckCubit;
  final tTrueConnectionFuture = Future.value(true);
  final tFalseHasConnectionFuture = Future.value(false);

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    mockConnectionCheckCubit = MockConnectionCheckCubit();
    isConnectedCheckCubit = MockIsConnectedCheckCubit();
    netWorkInfoImpl = NetWorkInfoImpl(
        connectionCheckCubit: mockConnectionCheckCubit,
        internetConnectionChecker: mockInternetConnectionChecker,
        isConnectedCheckCubit: isConnectedCheckCubit);
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
