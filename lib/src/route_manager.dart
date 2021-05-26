import 'package:asopedia/src/bloc/home/home_cubit.dart';
import 'package:asopedia/src/bloc/userinfo/userinfo_cubit.dart';
import 'package:asopedia/src/pages/about_us_page.dart';
import 'package:asopedia/src/pages/list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:asopedia/src/pages/login.dart';
import 'package:asopedia/src/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteManager {
  static Map<String, WidgetBuilder> _getApplicationRoutes() {
    return {
      'login': (BuildContext context) => LoginPage(),
      'home': (BuildContext context) => BlocProvider(
        create: (_) => HomeCubit(),
        child: BlocProvider.value(value: BlocProvider.of<UserinfoCubit>(context), child: HomePage())
      ),
      'list': (BuildContext context) => ListPage(),
      'about': (BuildContext context) => AboutUsPage()
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