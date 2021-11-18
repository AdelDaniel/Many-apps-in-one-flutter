import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';

class BuildKey extends StatelessWidget {
  final Color color;
  final int number;
  final AudioPlayer player;

  const BuildKey({
    Key? key,
    required this.color,
    required this.number,
    required this.player,
  }) : super(key: key);

  Future<void> playAudio() async {
    player
      ..setAsset("../assets/note$number.wav")
      ..play();
  }

  @override
  Widget build(BuildContext context) {
    // player.setAsset("../assets/note$number.wav");
    return Expanded(
      child: InkWell(
        onTap: playAudio,
        child: Container(color: color),
      ),
    );
  }
}
