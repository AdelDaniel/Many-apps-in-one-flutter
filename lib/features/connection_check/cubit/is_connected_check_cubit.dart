import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'is_connected_check_state.dart';

class IsConnectedCheckCubit extends Cubit<bool> {
  IsConnectedCheckCubit() : super(false);

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
