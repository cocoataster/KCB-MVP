import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/authentication_viewmodel.dart';
import 'package:sounds_good/router.dart';

import 'core/viewmodels/available_instruments_viewmodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationViewModel authentication = AuthenticationViewModel();

  
  final AvailableInstrumentsViewModel instrumentsViewModel =
      AvailableInstrumentsViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthenticationViewModel>(
      builder: (context) {
        authentication.authInit();
        return authentication;
        },
      child: ChangeNotifierProvider<AvailableInstrumentsViewModel>(
      builder: (context) => instrumentsViewModel,
      child: MaterialApp(
        
        title: 'Tuned',
        initialRoute: '/',
        onGenerateRoute: Router.generateRouter,
      ),),
    );
  }
}
