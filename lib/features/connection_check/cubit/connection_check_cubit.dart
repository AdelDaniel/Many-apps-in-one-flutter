import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'connection_check_state.dart';

class ConnectionCheckCubit extends Cubit<bool> {
  ConnectionCheckCubit() : super(true);

  void connected() {
    print('emit(ConnectedState());');
    emit(true);
  }

  void notConnected() {
    print('emit(NotConnectedState());');
    emit(false);
  }

  @override
  void onChange(Change<bool> change) {
    print('change:      $change');
    super.onChange(change);
  }
}
