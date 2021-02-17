import 'package:healthCalc/app/data/model/lectura_model.dart';

List<int> getVectOrdenadoFecha(List<LecturaModel> lecturas) {
  List<String> fechas = [];

  for (LecturaModel lect in lecturas) {
    fechas.add(lect.fecha);
  }
  fechas = torcerFechasCompletas(fechas);

  final List<String> sortedDates =
      fechas.toList(); //se crea una copia con una nueva instancia de fechas
  sortedDates.sort();

  List<int> vector = [];
  //! OJO este algoritmo esta pensado para una lista de lecturas en las que existe una sola lectura por fecha, nunca va a haber una fecha con mas de una lectura (se le impide al usuario)

  for (int i = 0; i < sortedDates.length; i++) {
    vector.add(fechas.indexOf(sortedDates[i]));
  }

  return vector;
}

List<String> torcerFechasCompletas(List<String> fechas) {
  final List<String> fechasTorcidas = [];
  fechas.map((fecha) {
    //fecha = '29/01/2021'
    final List<String> comp = fecha.split('/'); // comp = ['29','01', '2021' ];

    fechasTorcidas.add(comp[2] + '/' + comp[1] + '/' + comp[0]);
  }).toList();

  return fechasTorcidas;
}

List<LecturaModel> ordenarPorFecha(List<LecturaModel> lecturas) {
  final List<int> vectorOrdenado = getVectOrdenadoFecha(lecturas);
  List<LecturaModel> lectOrdenadas = [];

  for (int i in vectorOrdenado) {
    lectOrdenadas.add(lecturas[
        i]); //se llena la lista ordenada de Lecturas segun los valores del vector obtenido
  }
  return lectOrdenadas;
}

/// [date] es la fecha en formato DD/MM/YYYY, devuelve la fecha sin el dia: /MM/YYYY
String setToMonthYear(String date){
  return date.substring(2);
}

double getConsumoTotal(List<LecturaModel> lecturas){
    if(lecturas == null) return 0;
    final lecturasOrdenadas = ordenarPorFecha(lecturas).toList();
    final double consumoTotal = lecturasOrdenadas[lecturasOrdenadas.length - 1].lectura - lecturasOrdenadas[0].lectura;
    
    return consumoTotal;
  }

  /// para formatear numeros con espacios para cada millar ejm: para la cadena '12345' se retorna '12 345'
  String utilFormatNum(String numStr){
    String result = '';
    int d = 0;
    //se recorre la cadena del numero de atras para alante
    for(int i = numStr.length - 1; i >= 0; i--){
      d++;
      result += numStr[i];
      if( ((d.remainder(3)) == 0) && (d != numStr.length) ){
        result += ' ';
      } 
    }
    
    return utilsInvertirStr(result);
  }

  String utilsInvertirStr(String str){
    String result = '';
    for(int i = str.length - 1; i >= 0 ; i--){
      result += str[i];
    }
    return result;
  }