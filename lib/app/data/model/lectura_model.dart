

class LecturaModel{
  double lectura;
  int id;
  int  idContador;
  String fecha; //la fecha se va a tomar junto a la lectura de EditTexts
  int isRecibo; //OJO SQLite no permite datos bool, en su defecto se usan valores de 0 para false y 1 para true

  LecturaModel(
    {
      this.id,
      this.lectura,
      this.idContador,
      this.fecha,
      this.isRecibo = 0, //se pone como valor por defecto false 0(cero)
    }
  );

  factory LecturaModel.fromJson(Map<String, dynamic> json) => new LecturaModel(
    id         : json["id"],
    lectura    : json["lectura"],
    idContador : json["id_contador"],
    fecha      : json["fecha"],
    isRecibo   : json["is_recibo"]
  );

  Map<String, dynamic> toJson() =>{
    "id"          : id,
    "lectura"     : lectura,
    "id_contador" : idContador,
    "fecha"       : fecha,
    "is_recibo"   : isRecibo
  };
  
}