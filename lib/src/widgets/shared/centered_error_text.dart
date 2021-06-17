import 'package:flutter/material.dart';

class CenteredErrorText extends StatelessWidget {
  const CenteredErrorText() : super();

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Ha ocurrido un error inesperado, por favor comunicarse a soporte técnico'));
  }
}