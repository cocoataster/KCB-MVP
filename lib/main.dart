import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/authentication_viewmodel.dart';
import 'package:sounds_good/screens/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationViewModel authentication = AuthenticationViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthenticationViewModel>(
      builder: (context) => authentication,
      child: MaterialApp(
        title: 'Sounds Good',
        theme: ThemeData(
          accentColor: Colors.red[400],
          textTheme: TextTheme(
            headline: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: Colors.black87),
            display1: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
            title: TextStyle(fontSize: 18.0),
            button: TextStyle(fontSize: 16.0),
          ),
        ),
        initialRoute: 'login',
        onGenerateRoute: Router.generateRouter,
      ),
    );
  }
}
