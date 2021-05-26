import 'package:asopedia/src/bloc/home/home_cubit.dart';
import 'package:asopedia/src/bloc/userinfo/userinfo_cubit.dart';
import 'package:asopedia/src/models/user/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asopedia/src/themes/theme_manager.dart';
import 'package:asopedia/src/widgets/login/password_field.dart';
import 'package:asopedia/src/services/login/login_service.dart';
import 'package:asopedia/src/widgets/shared/rounded_button.dart';
import 'package:asopedia/src/bloc/snackmessages/snackmessages_cubit.dart';

class PersonalInfoForm extends StatefulWidget {
  @override
  _PersonalInfoFormState createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  IconData _iconPassword1 = Icons.visibility;
  IconData _iconPassword2 = Icons.visibility;
  bool _showPassword1 = false;
  bool _showPassword2 = false;
  GlobalKey<FormState> _formKey = new GlobalKey();
  GlobalKey<FormFieldState> _passwordFieldKey = new GlobalKey();
  String _firstName = '';
  String _lastName = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final userInfoBloc = BlocProvider.of<UserinfoCubit>(context);
    final homeBloc = BlocProvider.of<HomeCubit>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text('Confirmar datos',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          SizedBox(height: 25),
          TextFormField(
            validator: (value) =>
                value.isEmpty ? 'Este campo es requerido' : null,
            decoration: InputDecoration(labelText: 'Nombre'),
            onSaved: (value) => setState(() => _firstName = value),
          ),
          SizedBox(height: 25),
          TextFormField(
            validator: (value) =>
                value.isEmpty ? 'Este campo es requerido' : null,
            decoration: InputDecoration(labelText: 'Apellido'),
            onSaved: (value) => setState(() => _lastName = value)
          ),
          SizedBox(height: 25),
          PasswordField(
            _iconPassword1, 
            _showPassword1, 
            (value) => setState(() => _password = value), 
            () => setState(() {
              if (_showPassword1) {
                _showPassword1 = false;
                _iconPassword1 = Icons.visibility;
              } else {
                _showPassword1 = true;
                _iconPassword1 = Icons.visibility_off;
              }
            }), 
            (value) => value.isEmpty ? 'Este campo es requerido' : null,
            confirmationKey: _passwordFieldKey,
          ),
          SizedBox(height: 25),
          PasswordField(
            _iconPassword2, 
            _showPassword2, 
            (value) => {}, 
            () => setState(() {
              if (_showPassword2) {
                _showPassword2 = false;
                _iconPassword2 = Icons.visibility;
              } else {
                _showPassword2 = true;
                _iconPassword2 = Icons.visibility_off;
              }
            }), 
            (value) {
              if (value.isEmpty) return 'Este campo es requerido';
              if (value != _passwordFieldKey.currentState.value) return 'Las contraseñas no coinciden';
              return null;
            }
          ),
          SizedBox(height: 75),
          RoundedButton(
            color: ThemeManager.getPrimaryColor(),
            onPressed: () {
              if (!_formKey.currentState.validate()) return;
              _formKey.currentState.save();
              LoginService.saveUser(_firstName, _lastName, _password).then((UserInfo userInfo) {
                userInfoBloc.setUser(userInfo);
                homeBloc.setUserConfirmed();
              }).catchError((err) {
                final snackBar = SnackBar(content: Text(err.toString()));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            },
            text: 'Confirmar datos',
            textStyle: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}