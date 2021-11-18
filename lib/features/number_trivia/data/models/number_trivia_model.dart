import 'dart:convert';

import '../../domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    required String text,
    required int number,
    required bool found,
    required String type,
  }) : super(
          text: text,
          number: number,
          found: found,
          type: type,
        );

  factory NumberTriviaModel.fromJson(String str) =>
      NumberTriviaModel.fromMap(json.decode(str) as Map<String, dynamic>);
  String toJson() => json.encode(toMap());

  factory NumberTriviaModel.fromMap(Map<String, dynamic> json) =>
      NumberTriviaModel(
        text: (json["text"] ?? "Not Exist!") as String,
        number: ((json["number"] ?? 0) as num).toInt(),
        found: (json["found"] ?? false) as bool,
        type: (json["type"] ?? "Not Exist!") as String,
      );

  Map<String, dynamic> toMap() => {
        "text": text,
        "number": number,
        "found": found,
        "type": type,
      };

  @override
  List<Object?> get props => [text, number];
}
