import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'views/login_view.dart';

const String initialRoute = 'login';

class Router {
  static Route<dynamic> generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => LoginView());
      case 'login':
        return MaterialPageRoute(builder: (context) => LoginView());
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
