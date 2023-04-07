import 'package:delivery_project_app/pages/login_signup_page.dart';
import 'package:delivery_project_app/pages/starting_page.dart';
import 'package:delivery_project_app/pages/verification_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case StartingPage.id:
        return MaterialPageRoute(builder: (context) => const StartingPage());
      case LogInSignUpPage.id:
        return MaterialPageRoute(builder: (context) => const LogInSignUpPage());
      case VerificationPage.id:
        return MaterialPageRoute(
            builder: (context) => const VerificationPage());
      default:
        return null;
    }
  }
}
