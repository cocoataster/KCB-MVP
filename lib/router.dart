import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sounds_good/views/authentication/authentication_view.dart';
import 'package:sounds_good/views/profile/profile_view.dart';
import 'package:sounds_good/views/search/search_view.dart';
import 'package:sounds_good/views/navigation/tab_bar_view.dart';

const String initialRoute = 'login';

class Router {
  static Route<dynamic> generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AuthFormView());
      case 'search':
        return MaterialPageRoute(builder: (context) => SearchView());
      case 'cupertinoTabBar':
        return MaterialPageRoute(builder: (context) => AppTabBar());
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
