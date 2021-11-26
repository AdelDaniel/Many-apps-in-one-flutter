import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:xylophoneflutter/features/connection_check/cubit/is_connected_check_cubit.dart';

import 'all_injection_containers.dart' as di;
import 'features/XylophoneApp/xylophone_app.dart';
import 'features/connection_check/cubit/connection_check_cubit.dart';
import 'features/connection_check/injection_container.dart';
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'home_screen.dart';

// ignore: avoid_void_async
void main() async {
  Hive.initFlutter();
  await di.setup();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: "/error"),
      builder: (_) => Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: const Center(
            child: Text(
              "Oops! \n SomeThing went Wrong",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectionCheckCubit>(
            create: (_) => sl<ConnectionCheckCubit>()),
        BlocProvider<IsConnectedCheckCubit>(
            create: (_) => sl<IsConnectedCheckCubit>())
      ],
      child: MaterialApp(
        onGenerateRoute: (settings) {
          print({'this is a ${settings.name}'});
          switch (settings.name) {
            case '/':
            case HomeScreen.routeName:
              return HomeScreen.route();
            case XylophoneApp.routeName:
              return XylophoneApp.route();
            case NumberTriviaPage.routeName:
              return NumberTriviaPage.route();
            default:
              return _errorRoute();
          }
        },
        home: const HomeScreen(),
      ),
    );
  }
}
