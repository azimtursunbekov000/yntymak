import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      // Define other light theme properties here
      // like buttonTheme, textTheme, etc.
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.grey,
      // Define other dark theme properties here
      // like buttonTheme, textTheme, etc.
    );
  }
}
