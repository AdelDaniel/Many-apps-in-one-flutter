import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/number_trivia_bloc.dart';

class BottomHalf extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  BottomHalf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onSubmitted: (_) => _getConcreteNumberTrivia(context),
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: TextButton(
                onPressed: () => _getConcreteNumberTrivia(context),
                child: const Text('Search'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _getRandomNumberTrivia(context),
                child: const Text('Get random trivia'),
              ),
            ),
          ],
        )
      ],
    );
  }

  void _getConcreteNumberTrivia(BuildContext context) {
    // Clearing the TextField to prepare it for the next inputted number
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetConcreteNumberEvent(number: controller.text));
  }

  void _getRandomNumberTrivia(BuildContext context) {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(const GetRandomNumberEvent());
  }
}
