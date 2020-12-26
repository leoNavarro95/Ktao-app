///Esta clase abstrae todo lo referente a los datos 
///de los contadores que va a gestionar la app

import 'dart:convert';


ContadorModel contadorModelFromJson(String str) => ContadorModel.fromJson(json.decode(str));
String contadorModelToJson( ContadorModel data ) => json.encode(data.toJson());

class ContadorModel {

  String nombre;
  int consumo;
  double costoMesActual;
  String ultimaLectura; ///! Buscar como manejar el tiempo (alguna clase para ello???)

  ContadorModel({
    this.nombre,
    this.consumo,
    this.costoMesActual,
    this.ultimaLectura
  });

  factory ContadorModel.fromJson(Map<String, dynamic> json) => ContadorModel(
    nombre         : json["nombre"],
    consumo        : json["consumo"],
    costoMesActual : json["costoMesActual"],
    ultimaLectura  : json["ultimaLectura"],
  );

  Map<String, dynamic> toJson() => {
    "nombre"         : nombre,
    "consumo"        : consumo,
    "costoMesActual" : costoMesActual,
    "ultimaLectuara" : ultimaLectura
  };

}