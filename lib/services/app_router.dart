import 'package:delivery_project_app/pages/cart_list_page.dart';
import 'package:delivery_project_app/pages/change_profile_page.dart';
import 'package:delivery_project_app/pages/check_email_page.dart';
import 'package:delivery_project_app/pages/first_loading_page.dart';
import 'package:delivery_project_app/pages/forgot_password.dart';
import 'package:delivery_project_app/pages/home_page.dart';
import 'package:delivery_project_app/pages/location_page.dart';
import 'package:delivery_project_app/pages/login_signup_page.dart';
import 'package:delivery_project_app/pages/menu_page.dart';
import 'package:delivery_project_app/pages/otp_page.dart';
import 'package:delivery_project_app/pages/profile_page.dart';
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
      case HomePage.id:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case ForgotPassword.id:
        return MaterialPageRoute(builder: (context) => const ForgotPassword());
      case OtpPage.id:
        return MaterialPageRoute(builder: (context) => const OtpPage());
      case ProfilePage.id:
        return MaterialPageRoute(builder: (context) => const ProfilePage());
      case ChangeProfilePage.id:
        return MaterialPageRoute(
            builder: (context) => const ChangeProfilePage());
      case FirstLoadingPage.id:
        return MaterialPageRoute(
            builder: (context) => const FirstLoadingPage());
      case CheckEmailPage.id:
        return MaterialPageRoute(builder: (context) => const CheckEmailPage());
      case LocationPage.id:
        return MaterialPageRoute(builder: (context) => const LocationPage());
      case MenuPage.id:
        return MaterialPageRoute(builder: (context) => const MenuPage());
      case CartListPage.id:
        return MaterialPageRoute(builder: (context) => const CartListPage());
      default:
        return null;
    }
  }
}
