part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetConcreteNumberEvent extends NumberTriviaEvent {
  final String number;
  const GetConcreteNumberEvent({required this.number});

  @override
  List<Object> get props => [number];
}

class GetRandomNumberEvent extends NumberTriviaEvent {
  const GetRandomNumberEvent();
}
