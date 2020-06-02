import 'package:cttgfahrer/screens/home/home_screen.dart';
import 'package:cttgfahrer/screens/login/login_screen.dart';
import 'package:cttgfahrer/screens/register/register_screen.dart';
import 'package:flutter/material.dart';

class RouterGenerator {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginStateLess());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginStateLess());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterStateLess());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeStateLess());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text('Oooppss!! Fatal error'),
        ),
      );
    });
  }
}
