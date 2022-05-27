import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel_more/view/screens/main/main_screen.dart';
import 'package:travel_more/view/theme/app_theme.dart';
import 'dependencies.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.data,
      home: Builder(
        builder: (context) => DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyText1!,
          child: const MainScreen(),
        ),
      ),
    );
  }
}
