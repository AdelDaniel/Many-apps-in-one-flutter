import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widgets/number_trivai_body.dart';

class NumberTriviaPage extends StatelessWidget {
  static const String routeName = "/Number-Trivia-Game";
  static Route route() => MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const NumberTriviaPage());

  const NumberTriviaPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Number Trivia')),
      body: BlocProvider<NumberTriviaBloc>(
        create: (_) => sl<NumberTriviaBloc>(),
        child: const NumberTriviaBody(),
      ),
    );
  }
}
