import 'package:flutter/material.dart';
import 'package:paz/core/di/locator.dart';
import 'package:paz/core/theme/theme.dart';
import 'package:paz/core/theme/util.dart';
import 'package:paz/ui/screens/login/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightess = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, 'Noto Music', 'Cardo');

    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: brightess == Brightness.light ? theme.light() : theme.dark(),
      home: const LoginScreen(),
    );
  }
}
