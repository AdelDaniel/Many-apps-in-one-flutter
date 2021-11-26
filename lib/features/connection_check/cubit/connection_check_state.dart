part of 'connection_check_cubit.dart';

abstract class ConnectionCheckState extends Equatable {
  const ConnectionCheckState();

  @override
  List<Object> get props => [];
}

class ConnectedState extends ConnectionCheckState {}

class NotConnectedState extends ConnectionCheckState {}
