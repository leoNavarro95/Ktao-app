import 'package:flutter/material.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    //primary
    primaryColor: Colors.blue,
    //secundary = blue
    accentColor: Colors.blue,
    toggleableActiveColor: Colors.blue,
    indicatorColor: Colors.blue[700],
    hintColor: Colors.blue[800],
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.blue[200]),    // canvasColor: Colors.brown,

    splashColor: Colors.blue[200],

    cardColor: Colors.white,

    textTheme: TextTheme(

      headline5: TextStyle(
        color: Colors.grey[500],
        fontFamily: 'Montserrat-Italic',
        fontStyle: FontStyle.normal
      ),

      headline6: TextStyle(
        color: Colors.grey[500],
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
      ),
      subtitle2:TextStyle(
        color: Colors.grey[500],
        fontFamily: 'Montserrat-Italic',
        fontStyle: FontStyle.italic,
      ),
      overline: TextStyle(
        color: Colors.grey[500],
        fontFamily: 'Montserrat-Italic',
        fontStyle: FontStyle.italic,
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
    //primary = blueGrey[800]
    primaryColor: Colors.blueGrey[800],
    //secundary = cyan
    accentColor: Colors.cyan,
    toggleableActiveColor: Colors.cyan,
    indicatorColor: Colors.cyan[200],
    hintColor: Colors.cyan[800],
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.cyan[200]),
    
    splashColor: Colors.grey[300],

    
    textTheme: TextTheme(

      headline5: TextStyle(
        color: Colors.grey[300],
        fontFamily: 'Montserrat-Italic',
        fontStyle: FontStyle.normal
      ),
      
      headline6: TextStyle(
        color: Colors.grey[300],
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
      ),

      subtitle2:TextStyle(
        color: Colors.grey[300],
        fontFamily: 'Montserrat-Italic',
        fontStyle: FontStyle.italic,
      ),

      overline: TextStyle(
        color: Colors.grey[300],
        fontFamily: 'Montserrat-Italic',
        fontStyle: FontStyle.italic,
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
