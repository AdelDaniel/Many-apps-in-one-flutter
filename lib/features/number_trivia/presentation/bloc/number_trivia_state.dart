part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  final List<Object> properties;
  const NumberTriviaState([this.properties = const []]);

  @override
  List<Object> get props => properties;
}

//  Empty, Loading, Loaded and Error
class EmptyInitialState extends NumberTriviaState {}

class LoadingState extends NumberTriviaState {}

class LoadedState extends NumberTriviaState {
  final NumberTrivia numberTrivia;
  const LoadedState({required this.numberTrivia});
  @override
  List<Object> get props => [numberTrivia];
}

class ErrorState extends NumberTriviaState {
  final String message;

  ErrorState({required this.message}) : super([message]);
}
