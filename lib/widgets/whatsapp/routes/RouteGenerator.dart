import 'package:flutter/material.dart';
import 'package:tutorial_app/widgets/screens/SignUp.dart';
import 'package:tutorial_app/widgets/whatsapp/screens/Home.dart';
import 'package:tutorial_app/widgets/whatsapp/screens/LoginWhatsApp.dart';
import 'package:tutorial_app/widgets/whatsapp/screens/MessagesScreen.dart';
import 'package:tutorial_app/widgets/whatsapp/screens/Settings.dart';

class RouteGenerator {

  static const String HOME_ROUTE = "/home_whats";
  static const String LOGIN_ROUTE = "/login_whats";
  static const String SIGNUP_ROUTE = "/signup_whats";
  static const String SETTINGS_ROUTE = "/settings_whats";
  static const String MESSAGES_ROUTE = "/messages_whats";

  static Route<dynamic> generateRoute(RouteSettings settings) {

    final args = settings.arguments;

    switch(settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => LoginWhatsApp()
        );
      case LOGIN_ROUTE:
        return MaterialPageRoute(
            builder: (_) => LoginWhatsApp()
        );
      case SIGNUP_ROUTE:
        return MaterialPageRoute(
            builder: (_) => SignUp()
        );
      case HOME_ROUTE:
        return MaterialPageRoute(
            builder: (_) => Home()
        );
      case SETTINGS_ROUTE:
        return MaterialPageRoute(
            builder: (_) => Settings()
        );
      case MESSAGES_ROUTE:
        return MaterialPageRoute(
            builder: (_) => MessagesScreen(args)
        );
      default:
        _routeError();
    }
  }

  static Route<dynamic> _routeError() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text("Screen Not Found!"),),
          body: Center(
            child: Text("Screen Not Found!"),
          ),
        );
      }
    );
  }
}