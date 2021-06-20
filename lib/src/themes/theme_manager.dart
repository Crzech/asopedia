import 'package:flutter/material.dart';

final _primaryColor = Color(0xff155682);
final _accentColor = Color(0xff228976);

class ThemeManager {
  static ThemeData getLightTheme() => ThemeData(
    primaryColor: _primaryColor,
    accentColor: _accentColor,
  );

  static Color getPrimaryColor() => _primaryColor;
  static Color getAccentColor() => _accentColor;
}