import 'package:flutter/material.dart';
import '/models/models.dart';
import '/screens/screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('The Route is: ${settings.name}');

    switch (settings.name) {
      case '/':
        return HomePage.route();
      case HomePage.routeName:
        return HomePage.route();
      case UserPage.routeName:
        return UserPage.route(user: settings.arguments as User);
      case OnboardingScreen.routeName:
        return OnboardingScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(appBar: AppBar(title: const Text('error'))),
      settings: const RouteSettings(name: '/error'),
    );
  }
}
