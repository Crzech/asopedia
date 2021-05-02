import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:asopedia/src/pages/login.dart';
import 'package:asopedia/src/pages/home_page.dart';

class RouteManager {
  static Map<String, WidgetBuilder> _getApplicationRoutes() {
    return {
      'login': (BuildContext context) => LoginPage(),
      'home': (BuildContext context) => HomePage()
    };
  }

  static Route<CupertinoPageRoute> handleRoute(RouteSettings settings) {
    final routes = _getApplicationRoutes();
    return CupertinoPageRoute(
      builder: routes[settings.name],
      settings: settings
    );
  }
}