import 'package:flutter/material.dart';

import 'features/XylophoneApp/xylophone_app.dart';

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
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            children: <Widget>[
              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, XylophoneApp.routeName),
                child: const Text('Xylophone App',
                    style: TextStyle(fontSize: 15.0)),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                label: const Text('Park Out', style: TextStyle(fontSize: 15.0)),
                icon: const Icon(Icons.eject),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                label: const Text('Maintainence In',
                    style: TextStyle(fontSize: 15.0)),
                icon: const Icon(Icons.vertical_align_bottom),
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
