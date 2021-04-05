import 'package:flutter/material.dart';

  const Color primaryBlue = Color(0xFF007EA7);
  const Color carolinaBlue = Color(0xFF00A8E8);
class Themes {

  ThemeData lightTheme = ThemeData.light().copyWith(
    //primary
    primaryColor: primaryBlue, //Colors.blue,
    //secundary = blue
    accentColor: carolinaBlue,
    toggleableActiveColor: carolinaBlue,
    indicatorColor: carolinaBlue,
    hintColor: Color(0xFF003459), //prusianBlue
    disabledColor: Color(0xFF2D677C),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.blue[200]), // canvasColor: Colors.brown,

    splashColor: Colors.blue[200],

    cardColor: Colors.grey[200],

    textTheme: TextTheme(
      
      headline4: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontFamily: 'Montserrat-Light',
        fontStyle: FontStyle.normal,
      ),

      headline5: TextStyle(
          color: Colors.grey[500],
          fontFamily: 'Montserrat-Italic',
          fontStyle: FontStyle.normal),
      
      headline6: TextStyle(
        color: Colors.grey[500],
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
      ),
      
      subtitle2: TextStyle(
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
      caption: TextStyle(
        fontSize: 20,
        color: Colors.grey[500],
        fontFamily: 'Montserrat-Light',
        fontStyle: FontStyle.normal,
      ),
      
    ),

    appBarTheme: AppBarTheme(brightness: Brightness.light),
    iconTheme: IconThemeData(color: Colors.grey[500]),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryBlue, foregroundColor: Colors.white),
  );

  //*#################DARK THEME#########################################
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
      headline4: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontFamily: 'Montserrat-Light',
        fontStyle: FontStyle.normal,
      ),
      
      headline5: TextStyle(
          color: Colors.grey[300],
          fontFamily: 'Montserrat-Italic',
          fontStyle: FontStyle.normal),
      headline6: TextStyle(
        color: Colors.grey[300],
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
      ),
      subtitle2: TextStyle(
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
      caption: TextStyle(
        fontSize: 20,
        color: Colors.grey[300],
        fontFamily: 'Montserrat-Light',
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
