import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/authentication_viewmodel.dart';
import 'package:sounds_good/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationViewModel authentication = AuthenticationViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthenticationViewModel>(
      builder: (context) {
        authentication.authInit();
        return authentication;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tuned',
        initialRoute: '/',
        onGenerateRoute: Router.generateRouter,
      ),
    );
  }
}
