import 'dart:convert';
import 'package:asopedia/src/widgets/home_view.dart';
import 'package:asopedia/src/widgets/personal_info_view.dart';
import 'package:flutter/material.dart';

import 'package:asopedia/src/util/user_preferences.dart';
import 'package:asopedia/src/services/login_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _prefs = UserPreferences();
  bool isUserConfirmed = false;

  @override
  void initState() {
    super.initState();
    isUserConfirmed = true;
  }

  @override
  Widget build(BuildContext context) {
    var payload = jsonDecode(ascii.decode(base64.decode(base64.normalize(_prefs.token.split('.')[1]))));
    final String userId = payload['data']['user']['id'];
    print(userId);
    // final isUserConfirmed = LoginService.isUserConfirmed2(userId);
    return isUserConfirmed ? HomeView() : PersonalInfoView();
  }
}