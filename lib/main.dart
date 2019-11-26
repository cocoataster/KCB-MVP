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
      theme: ThemeData(
        accentColor: Colors.red[400],
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: Colors.black87),
          display1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black87),
          display2: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          button: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      initialRoute: 'profile',
      onGenerateRoute: Router.generateRouter,
    );
  }
}