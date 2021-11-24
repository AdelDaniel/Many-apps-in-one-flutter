import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(EmptyInitialState()) {
    on<GetConcreteNumberEvent>(_onGetConcreteNumberEvent);
    on<GetRandomNumberEvent>(_onGetRandomNumberEvent);
  }

  NumberTriviaState get initialState => EmptyInitialState();

  Future<void> _onGetConcreteNumberEvent(
      GetConcreteNumberEvent event, emit) async {
    emit(LoadingState());
    final inputEither = inputConverter.stringToUnsignedInteger(event.number);
    await inputEither.fold((failure) {
      emit(ErrorState(message: failure.message));
    }, (intNumber) async {
      final Either<Failure, NumberTrivia> getConcereteNumberEither =
          await getConcreteNumberTrivia.call(Params(number: intNumber));
      getConcereteNumberEither.fold(
          (failure) => emit(ErrorState(message: failure.message)),
          (numberTrivia) => emit(LoadedState(numberTrivia: numberTrivia)));
    });
  }

  Future<void> _onGetRandomNumberEvent(GetRandomNumberEvent event, emit) async {
    emit(LoadingState());
    final getRandomNumberEither = await getRandomNumberTrivia.call();
    getRandomNumberEither.fold(
        (failure) => emit(ErrorState(message: failure.message)),
        (numberTrivia) => emit(LoadedState(numberTrivia: numberTrivia)));
  }
}


/* //!not used code
String _mapFailureToMessage(Failure failure) {
  // Instead of a regular 'if (failure is ServerFailure)...'
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected Error';
  }
*/ 