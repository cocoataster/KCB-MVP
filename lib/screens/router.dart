import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sounds_good/screens/views/bottom_navigation_bar.dart';
import 'package:sounds_good/screens/views/profile_view.dart';
import 'package:sounds_good/screens/views/access_forms/signin_view.dart';
import 'package:sounds_good/screens/views/access_forms/login_view.dart';
import 'package:sounds_good/screens/views/tab_bar_view.dart';

const String initialRoute = 'login';

class Router {
  static Route<dynamic> generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginView());
      case 'login':
        return MaterialPageRoute(builder: (context) => LoginView());
      case 'bottomTabBar':
        return MaterialPageRoute(builder: (context) => BottomTabBar());
      case 'cupertinoTabBar':
        return MaterialPageRoute(builder: (context) => AppTabBar());
      case 'signin':
        return MaterialPageRoute(builder: (context) => SigninView());
      case 'profile':
        return MaterialPageRoute(builder: (context) => ProfileView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
