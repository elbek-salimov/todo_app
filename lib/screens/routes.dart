import 'package:flutter/material.dart';
import 'package:todo_app/screens/home/home_screen.dart';
import 'package:todo_app/screens/register/register_screen.dart';
import 'package:todo_app/screens/start/start_screen.dart';

import 'add_category/add_category_screen.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.start:
        return navigate(const StartScreen());
      case RouteNames.register:
        return navigate(const RegisterScreen());
      case RouteNames.home:
        return navigate(const HomeScreen());
      case RouteNames.addCategory:
        return navigate(
          AddCategoryScreen(
            onCategoryAdded: settings.arguments as VoidCallback?,
          ),
        );
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
  static const String start = "/";
  static const String register = "/register_route";
  static const String home = "/home_route";
  static const String addCategory = "/add_category";
}