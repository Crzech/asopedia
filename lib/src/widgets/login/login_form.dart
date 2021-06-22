import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asopedia/src/services/login/login_service.dart';
import 'package:asopedia/src/bloc/snackmessages/snackmessages_cubit.dart';
import 'package:asopedia/src/util/user_preferences.dart';
import 'package:asopedia/src/util/login_exception.dart';
import 'package:asopedia/src/models/user/user.dart';
import 'package:asopedia/src/themes/theme_manager.dart';
import 'package:asopedia/src/widgets/login/password_field.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginForm extends StatefulWidget {
  @override
  __LoginFormState createState() => __LoginFormState();
}

class __LoginFormState extends State<LoginForm> {
  final _loginFormKey = new GlobalKey<FormState>();
  final _submitBtnController = RoundedLoadingButtonController();
  final _prefs = UserPreferences();

  String _userName = '';
  String _password = '';
  bool _showPassword = false;
  IconData _iconPassword = Icons.visibility;
  @override
  Widget build(BuildContext context) {
    final snackMessagesBloc = BlocProvider.of<SnackmessagesCubit>(context);
    return BlocListener<SnackmessagesCubit, SnackmessagesState>(
      listener: (context, state) {
        if (state is SnackmessagesNewMessage) {
          final snackBar = SnackBar(content: Text(state.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Container(
        child: Form(
          key: _loginFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
            child: Column(
              children: [
                Text('ASOPEDIA', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                SizedBox(height: 25),
                TextFormField(
                  validator: (value) =>
                      value.isEmpty ? 'Este campo es requerido' : null,
                  onSaved: (value) => this.setState(() {
                    _userName = value;
                  }),
                  decoration:
                      InputDecoration(labelText: 'Ingresa tu e-mail o usuario'),
                ),
                SizedBox(height: 25),
                PasswordField(
                  _iconPassword, 
                  _showPassword, 
                  (value) => setState(() { _password = value; }), 
                  () {
                    setState(() {
                      if (_showPassword) {
                        _showPassword = false;
                        _iconPassword = Icons.visibility;
                      } else {
                        _showPassword = true;
                        _iconPassword = Icons.visibility_off;
                      }
                    });
                  }, 
                  (value) => value.isEmpty ? 'Este campo es requerido' : null
                ),
                SizedBox(height: 25),
                RoundedLoadingButton(
                  controller: _submitBtnController,
                  color: ThemeManager.getAccentColor(),
                  errorColor: Color(0xffff5252),
                  onPressed: () {
                    if (!_loginFormKey.currentState.validate()) {
                      _submitBtnController.reset();
                      return;
                    } 
                    _loginFormKey.currentState.save();
                    LoginService.authUser(_userName, _password).then((User user) {
                      _prefs.token = user.token;
                      _submitBtnController.success();
                      Future.delayed(Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, 'home'));
                    }).catchError((error) {
                      _submitBtnController.error();
                      if (error is LoginException) {
                        snackMessagesBloc.addNewMessage(error.toString());
                      } else {
                        snackMessagesBloc.addNewMessage('Lo sentimos, ocurrió un error desconocido');
                      }
                      Future.delayed(Duration(seconds: 2), () => _submitBtnController.reset());
                    });
                  },
                  child: Text('Iniciar sesión', style: TextStyle(color: Colors.white))
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
