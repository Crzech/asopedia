import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final TextStyle textStyle;

  const RoundedButton({
    @required this.onPressed, 
    @required this.text, 
    @required this.color, 
    @required this.textStyle
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RawMaterialButton(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        fillColor: color,
        textStyle: textStyle,
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}