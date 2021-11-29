import 'package:flutter/material.dart';

import 'features/XylophoneApp/xylophone_app.dart';
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'features/responsive_impl_app/courses_page.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/homeScreen';
  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const HomeScreen(),
      );
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("word")),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.all(10),
            crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
            children: <Widget>[
              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, XylophoneApp.routeName),
                child: const Text(XylophoneApp.routeName),
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, NumberTriviaPage.routeName),
                child: const Text(NumberTriviaPage.routeName),
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, CoursesPage.routeName),
                child: const Text(CoursesPage.routeName),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                label: const Text('Maintainence Out',
                    style: TextStyle(fontSize: 15.0)),
                icon: const Icon(Icons.vertical_align_top),
              ),
              ElevatedButton.icon(
                onPressed: null,
                label: const Text('Move', style: TextStyle(fontSize: 15.0)),
                icon: const Icon(Icons.open_with),
              ),
            ],
          );
        },
      ),
    );
  }
}
