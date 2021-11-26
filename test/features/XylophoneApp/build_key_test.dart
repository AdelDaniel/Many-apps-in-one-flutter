import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mockito/annotations.dart';
import 'package:xylophoneflutter/features/XylophoneApp/build_key.dart';

import 'build_key_test.mocks.dart';

@GenerateMocks([AudioPlayer])
void main() {
  const Color tColor = Colors.green;
  const int tNumber = 1;
  late MockAudioPlayer mockAudioPlayer;

  setUp(() {
    mockAudioPlayer = MockAudioPlayer();
  });

  testWidgets('build key ...', (WidgetTester tester) async {
    // Build the widget using the WidgetTester tester
    await tester.pumpWidget(BuildKey(
      color: tColor,
      number: tNumber,
      player: mockAudioPlayer,
    ));

    // Search for our widget using a Finder [Container , inkwell],
    // containing[ Container(color: color)] and  InkWell(onTap: playAudio, child: Container(color: color),), inside 'BuildKey'
    final container = find.byWidget(Container(color: tColor));

    // assertion
    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    // expect(container, findsOneWidget);
  });
}
