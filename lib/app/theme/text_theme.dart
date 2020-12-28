

import 'package:flutter/material.dart';

class TemaTexto {
  
  final TextStyle _titulo = TextStyle(
    fontSize: 20,
    fontFamily: 'Montserrat-Regular',
    // fontWeight: FontWeight.bold
    );
  TextStyle get titulo => this._titulo;

  //______________________________________________
  
  final TextStyle _tituloTarjeta = TextStyle(
    fontSize: 20,
    color: Colors.white, 
    fontFamily: 'Montserrat-Light',
    fontStyle: FontStyle.normal
    // fontWeight: FontWeight.w400
    );
  TextStyle get tituloTarjeta => this._tituloTarjeta;
  //______________________________________________

   final TextStyle _cuerpoTarjeta = TextStyle(
    fontSize: 15,
    color: Colors.blue,
    fontFamily: 'Montserrat-Regular',
    fontWeight: FontWeight.w600
    );
  TextStyle get cuerpoTarjeta => this._cuerpoTarjeta;
  //______________________________________________

   final TextStyle _infoTarjeta = TextStyle(
    fontSize: 15,
    color: Colors.blue,
    fontFamily: 'Montserrat-Italic',
    fontStyle: FontStyle.italic
    // fontWeight: FontWeight.w600
    );
  TextStyle get infoTarjeta => this._infoTarjeta;
  //______________________________________________

  final TextStyle _bottomSheet = TextStyle(
    fontSize: 15,
    color: Colors.grey,
    fontFamily: 'Montserrat-Italic',
    fontStyle: FontStyle.italic
    // fontWeight: FontWeight.w600
    );
  TextStyle get bottomSheetBody => this._bottomSheet;
  //______________________________________________

  final TextStyle _bottomSheetTitulo = TextStyle(
    fontSize: 20,
    color: Colors.blueGrey,
    fontFamily: 'Montserrat-Italic',
    fontStyle: FontStyle.normal
    // fontWeight: FontWeight.w600
    );
  TextStyle get bottomSheetTitulo => this._bottomSheetTitulo;
  //______________________________________________

}