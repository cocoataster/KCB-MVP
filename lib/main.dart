import 'package:flutter/material.dart';
import 'package:sounds_good/locator.dart';
import 'package:sounds_good/screens/router.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sounds Good',
      theme: ThemeData(),
      initialRoute: 'login',
      onGenerateRoute: Router.generateRouter,
    );
  }
}
