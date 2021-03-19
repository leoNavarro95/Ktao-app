import 'package:flutter/material.dart';

class Themes {

  final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blueGrey[300],
    appBarTheme: AppBarTheme(brightness: Brightness.light)
  );
  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.blueGrey[800],
    appBarTheme: AppBarTheme(brightness: Brightness.dark)
  );

}