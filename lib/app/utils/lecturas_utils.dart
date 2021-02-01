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
