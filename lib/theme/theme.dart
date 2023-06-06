import 'package:flutter/material.dart';
import 'package:myapp/theme/text_theme.dart';

class TAppTheme {
  TAppTheme._(); //make const private
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: 'firaMono',
    textTheme: TTextTheme.lightTextTheme,
    colorSchemeSeed: Colors.blue,
  );
  static ThemeData darkThme = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.blue,
    useMaterial3: true,
    fontFamily: 'firaMono',
    textTheme: TTextTheme.darkTextTheme,
  );
}
