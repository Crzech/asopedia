import 'dart:convert';
import 'package:asopedia/src/bloc/userinfo/userinfo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asopedia/src/util/user_preferences.dart';
import 'package:asopedia/src/widgets/home/home_view.dart';
import 'package:asopedia/src/widgets/personal_info/personal_info_view.dart';
import 'package:asopedia/src/bloc/home/home_cubit.dart';
import 'package:asopedia/src/services/login/login_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _prefs = UserPreferences();

  @override
  void initState() {
    super.initState();
    final homeBloc = BlocProvider.of<HomeCubit>(context);
    final userInfoBloc = BlocProvider.of<UserinfoCubit>(context);
    var payload = jsonDecode(ascii.decode(base64.decode(base64.normalize(_prefs.token.split('.')[1]))));
    final String userId = payload['data']['user']['id'];
    LoginService.getUserInfo(userId).then((value) {
      if (LoginService.isUserConfirmed(value)) {
        userInfoBloc.setUser(value);
        homeBloc.setUserConfirmed();
      } else {
        homeBloc.setUserNotConfirmed();
      }
    }).catchError((err) {
      final snackBar = SnackBar(content: Text('Ha ocurrido un error desconocido.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        switch (state.runtimeType) {
          case HomeUserNotConfirmed:
            return PersonalInfoView();
            break;
          case HomeUserConfirmed:
            return HomeView();
            break;
          default: 
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      }
    );
  }
}