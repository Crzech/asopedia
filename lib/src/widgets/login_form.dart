import 'package:asopedia/src/models/user.dart';
import 'package:asopedia/src/themes/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asopedia/src/services/login_service.dart';
import 'package:asopedia/src/bloc/snackmessages/snackmessages_cubit.dart';
import 'package:asopedia/src/util/user_preferences.dart';
import 'package:asopedia/src/util/login_exception.dart';

class LoginForm extends StatefulWidget {
  @override
  __LoginFormState createState() => __LoginFormState();
}

class __LoginFormState extends State<LoginForm> {
  final _loginFormKey = new GlobalKey<FormState>();
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
                TextFormField(
                  obscureText: !_showPassword,
                  validator: (value) =>
                      value.isEmpty ? 'Este campo es requerido' : null,
                  onSaved: (value) => this.setState(() {
                    _password = value;
                  }),
                  decoration: InputDecoration(
                      labelText: 'Ingresa tu contraseña',
                      suffixIcon: GestureDetector(
                        onTap: () {
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
                        child: Icon(_iconPassword),
                      )),
                ),
                SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: RawMaterialButton(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    fillColor: ThemeManager.getPrimaryColor(),
                    textStyle: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                    onPressed: () {
                      if (!_loginFormKey.currentState.validate()) return;
                      _loginFormKey.currentState.save();
                      LoginService.authUser(_userName, _password).then((User user) {
                        _prefs.token = user.token;
                        Navigator.pushReplacementNamed(context, 'home');
                      }).catchError((error) {
                        if (error is LoginException) {
                          snackMessagesBloc.addNewMessage(error.toString());
                        } else {
                          snackMessagesBloc.addNewMessage('Lo sentimos, ocurrió un error desconocido');
                        }
                      });
                    },
                    child: Text('Iniciar sesión'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
