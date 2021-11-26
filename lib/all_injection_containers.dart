import 'features/connection_check/injection_container.dart'
    as connection_check_di;
import 'features/number_trivia/injection_container.dart' as number_trivia_di;

Future<void> setup() async {
  await number_trivia_di.setup();
  await connection_check_di.setup();
}
