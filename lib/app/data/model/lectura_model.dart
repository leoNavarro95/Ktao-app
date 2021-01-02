

class LecturaModel{
  int id, lectura, idContador;
  String fecha; //la fecha se va a tomar junto a la lectura de EditTexts

  LecturaModel(
    {
      this.id,
      this.lectura,
      this.idContador,
      this.fecha
    }
  );

  factory LecturaModel.fromJson(Map<String, dynamic> json) => new LecturaModel(
    id         : json["id"],
    lectura    : json["lectura"],
    idContador : json["id_contador"],
    fecha      : json["fecha"]
  );

  Map<String, dynamic> toJson() =>{
    "id"          : id,
    "lectura"     : lectura,
    "id_contador" : idContador,
    "fecha"       : fecha
  };
  
}