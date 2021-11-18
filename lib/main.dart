import 'package:flutter/material.dart';
import 'features/XylophoneApp/xylophone_app.dart';
import 'home_screen.dart';

void main() => runApp(const App());

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
          // case CatalogScreen.routeName:
          //   return CatalogScreen.route();
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
