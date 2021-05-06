import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final IconData iconPassword;
  final bool showPassword;
  final Function(String) onSaved;
  final Function onTapEye;
  final Function(String) validator;
  GlobalKey<FormFieldState> confirmationKey = new GlobalKey();

  PasswordField(this.iconPassword, this.showPassword, this.onSaved, this.onTapEye, this.validator, { this.confirmationKey });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: confirmationKey,
      obscureText: !showPassword,
      validator: this.validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        labelText: 'Ingresa tu contraseña',
        suffixIcon: GestureDetector(
          onTap: onTapEye,
          child: Icon(iconPassword),
        )
      ),
    );
  }
}