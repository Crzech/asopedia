import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final IconData iconPassword;
  final bool showPassword;
  final Function(String) onSaved;
  final Function onTapEye;
  final Function(String) validator;
  final GlobalKey<FormFieldState> confirmationKey;

  PasswordField(this.iconPassword, this.showPassword, this.onSaved, this.onTapEye, this.validator, { this.confirmationKey });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: confirmationKey,
      obscureText: !showPassword,
      validator: this.validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        suffixIcon: GestureDetector(
          onTap: onTapEye,
          child: Icon(iconPassword),
        )
      ),
    );
  }
}