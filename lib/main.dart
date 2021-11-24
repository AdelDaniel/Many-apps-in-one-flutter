import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/XylophoneApp/xylophone_app.dart';
import 'features/number_trivia/injection_container.dart' as di;
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'home_screen.dart';

void main() {
  Hive.initFlutter();
  di.setup();
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
    return MaterialApp(
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
          // case ProductDetailsScreen.routeName:
          //   return ProductDetailsScreen.route(settings.arguments as Product);
          // case WishListScreen.routeName:
          //   return WishListScreen.route();
          // case CartScreen.routeName:
          //   return CartScreen.route();
          // case SettingsScreen.routeName:
          //   return SettingsScreen.route();

          default:
            return _errorRoute();
        }
      },
      home: const HomeScreen(),
    );
  }
}
