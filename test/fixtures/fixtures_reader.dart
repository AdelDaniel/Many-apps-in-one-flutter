import 'dart:io';

enum FileType { intNumberTrivia, doubleNumberTrivia }
String fixture({required FileType fileType}) =>
    fileType == FileType.intNumberTrivia
        ? File('test/fixtures/number_trivia_int.json').readAsStringSync()
        : File('test/fixtures/number_trivia_double.json').readAsStringSync();
