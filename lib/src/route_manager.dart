import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asopedia/src/pages/list_page2.dart';
import 'package:asopedia/src/pages/story_page.dart';
import 'package:asopedia/src/pages/login.dart';
import 'package:asopedia/src/pages/home_page.dart';
import 'package:asopedia/src/bloc/home/home_cubit.dart';
import 'package:asopedia/src/bloc/list/list_cubit.dart';
import 'package:asopedia/src/bloc/userinfo/userinfo_cubit.dart';
import 'package:asopedia/src/pages/about_us_page.dart';
import 'package:asopedia/src/pages/post_page.dart';
import 'package:asopedia/src/pages/favorites_page.dart';
import 'package:asopedia/src/pages/vaccine_schedule.dart';
import 'package:asopedia/src/bloc/favorites/favorites_cubit.dart';

class RouteManager {
  static Map<String, WidgetBuilder> _getApplicationRoutes() {
    return {
      'login': (BuildContext context) => LoginPage(),
      'home': (BuildContext context) => BlocProvider(
        create: (_) => HomeCubit(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: BlocProvider.of<UserinfoCubit>(context)),
            BlocProvider.value(value: BlocProvider.of<ListCubit>(context))
          ], 
          child: HomePage()
        )
      ),
      'list': (BuildContext context) => BlocProvider.value(
        value: BlocProvider.of<ListCubit>(context),
        // child: ListPage(),
      ),
      'list2': (BuildContext context) => BlocProvider.value(
        value: BlocProvider.of<ListCubit>(context),
        child: ListPage2(),
      ),
      'post': (BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: BlocProvider.of<ListCubit>(context)),
          BlocProvider.value(value: BlocProvider.of<FavoritesCubit>(context)),
        ], 
        child: PostPage()
      ),
      'vaccine_schedule': (BuildContext context) => VaccineSchedulePage(),
      'favorites': (BuildContext context) => BlocProvider.value(value: BlocProvider.of<FavoritesCubit>(context), child: FavoritesPage()),
      'about': (BuildContext context) => AboutUsPage(),
      'story': (BuildContext context) => StoryPage()
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