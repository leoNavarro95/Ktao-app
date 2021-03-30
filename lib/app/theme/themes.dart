import 'package:flutter/material.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
    accentColor: Colors.green,

    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.grey[500],
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
      ),
      bodyText1: TextStyle(
        color: Colors.grey[500],
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
      ),
      bodyText2: TextStyle(
        color: Colors.grey[500],
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
      ),
    ),
    
    appBarTheme: AppBarTheme(brightness: Brightness.light),
    iconTheme: IconThemeData(color: Colors.grey[500]),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.blue, foregroundColor: Colors.white),
  );

  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.blueGrey[800],
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.grey[300],
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
      ),
      bodyText2: TextStyle(
        color: Colors.grey[300],
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
      ),
    ),
    appBarTheme: AppBarTheme(brightness: Brightness.dark),
    iconTheme: IconThemeData(color: Colors.grey[100]),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.grey[100],
        splashColor: Colors.grey[200]),
  );
}
