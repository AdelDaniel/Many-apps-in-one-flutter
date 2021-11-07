import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() => runApp(const XylophoneApp());

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              BuildKey(color: Colors.red, number: 1),
              BuildKey(color: Colors.orange, number: 2),
              BuildKey(color: Colors.yellow, number: 3),
              BuildKey(color: Colors.green, number: 4),
              BuildKey(color: Colors.teal, number: 5),
              BuildKey(color: Colors.blue, number: 6),
              BuildKey(color: Colors.purple, number: 7),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildKey extends StatelessWidget {
  final Color color;
  final int number;

  const BuildKey({
    Key? key,
    required this.color,
    required this.number,
  }) : super(key: key);

  void playAudio() {
    final AudioPlayer player = AudioPlayer();
    player.setAsset("../assets/note$number.wav");
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: playAudio,
        child: Container(color: color),
      ),
    );
  }
}
