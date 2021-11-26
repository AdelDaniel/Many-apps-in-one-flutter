import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/number_trivia_bloc.dart';

import 'widgets.dart';

class TopHalf extends StatelessWidget {
  const TopHalf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
      builder: (context, state) {
        if (state is EmptyInitialState) {
          return const MessageDisplay(message: 'Start searching!');
        } else if (state is ErrorState) {
          return MessageDisplay(message: state.message);
        } else if (state is LoadingState) {
          return const LoadingWidget();
        } else if (state is LoadedState) {
          return TriviaDisplay(numberTrivia: state.numberTrivia);
        }
        return const MessageDisplay(message: "Oops! Something went wrong.");
      },
    );
  }
}
