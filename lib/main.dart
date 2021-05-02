
import 'package:asopedia/src/themes/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';

import 'package:asopedia/src/bloc/snackmessages/snackmessages_cubit.dart';
import 'package:asopedia/src/route_manager.dart';
import 'package:asopedia/src/util/user_preferences.dart';
 
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize user preferences
  final prefs = new UserPreferences();
  await prefs.initPrefs();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SnackmessagesCubit())
      ], 
      child: MyApp()
    )
  );
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new UserPreferences();
    String initialRoute = 'login';

    if (prefs.token.length >= 1) {
      // check if stored token is expired
      var jwt = prefs.token.split(".");
      var payload = jsonDecode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));
      if(DateTime.fromMillisecondsSinceEpoch(payload["exp"]*1000).isAfter(DateTime.now())) {
        initialRoute = 'home';
      } else {
        initialRoute = 'login';
      }
    } else {
      initialRoute = 'login';
    }

    return MaterialApp(
      title: 'Material App',
      initialRoute: initialRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.getLightTheme(),
      onGenerateRoute: (RouteSettings settings) => RouteManager.handleRoute(settings),
    );
  }
}