import 'package:flutter/material.dart';
import 'package:todo_app/screens/home/home_screen.dart';
import 'package:todo_app/screens/register/register_screen.dart';
import 'package:todo_app/screens/start/start_screen.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.start:
        return navigate(const StartScreen());
      case RouteNames.register:
        return navigate(const RegisterScreen());
      case RouteNames.home:
        return navigate(const HomeScreen());
      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text("This kind of rout does not exist!"),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}

class RouteNames {
  static const String start = "/start_route";
  static const String register = "/register_route";
  static const String home = "/home_route";
}