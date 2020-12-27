///Esta clase abstrae todo lo referente a los datos 
///de los contadores que va a gestionar la app

import 'dart:convert';


ContadorModel contadorModelFromJson(String str) => ContadorModel.fromJson(json.decode(str));
String contadorModelToJson( ContadorModel data ) => json.encode(data.toJson());

class ContadorModel {

  int id;
  String nombre;
  int consumo;
  num costoMesActual;   //* para manejar puntos flotantes en la base de datos sqlite
  String ultimaLectura; ///! Buscar como manejar el tiempo (alguna clase para ello???)

  ContadorModel({
    this.id,
    this.nombre,
    this.consumo,
    this.costoMesActual,
    this.ultimaLectura
  });

  factory ContadorModel.fromJson(Map<String, dynamic> json) => new ContadorModel(
    id             : json["id"],
    nombre         : json["nombre"],
    consumo        : json["consumo"],
    costoMesActual : json["costoMesActual"],
    ultimaLectura  : json["ultimaLectura"],
  );

  Map<String, dynamic> toJson() => {
    "id"             : id,
    "nombre"         : nombre,
    "consumo"        : consumo,
    "costoMesActual" : costoMesActual,
    "ultimaLectuara" : ultimaLectura
  };

}