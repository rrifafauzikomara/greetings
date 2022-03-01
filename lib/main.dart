import 'package:flutter/material.dart';
import 'package:greetings/core/config/config.dart';
import 'package:greetings/view/provider/greetings_provider.dart';
import 'package:greetings/view/ui/home_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const env = String.fromEnvironment('ENV', defaultValue: 'dev');
  final config = await Config.parse(env);

  runApp(
    ChangeNotifierProvider(
      create: (context) => GreetingsProvider(config),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData.dark(),
    home: const HomePage(),
  );
}