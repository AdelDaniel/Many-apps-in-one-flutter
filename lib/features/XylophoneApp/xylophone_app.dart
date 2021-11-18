import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'build_key.dart';

class XylophoneApp extends StatelessWidget {
  static const String routeName = '/xylophoneApp';
  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const XylophoneApp(),
      );
  const XylophoneApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            BuildKey(player: AudioPlayer(), color: Colors.red, number: 1),
            BuildKey(player: AudioPlayer(), color: Colors.orange, number: 2),
            BuildKey(player: AudioPlayer(), color: Colors.yellow, number: 3),
            BuildKey(player: AudioPlayer(), color: Colors.green, number: 4),
            BuildKey(player: AudioPlayer(), color: Colors.teal, number: 5),
            BuildKey(player: AudioPlayer(), color: Colors.blue, number: 6),
            BuildKey(player: AudioPlayer(), color: Colors.purple, number: 7),
          ],
        ),
      ),
    );
  }
}

// .setAsset("../assets/note1.wav")
// .setAsset("../assets/note2.wav")
// .setAsset("../assets/note3.wav")
// .setAsset("../assets/note4.wav")
// .setAsset("../assets/note5.wav")
// .setAsset("../assets/note6.wav")
// .setAsset("../assets/note7.wav")