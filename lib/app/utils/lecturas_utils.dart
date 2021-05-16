import 'package:ktao/app/data/model/lectura_model.dart';
import 'package:ktao/app/data/provider/data_base_provider.dart';
import 'package:ktao/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura.dart';

List<int> getVectOrdenadoFecha(List<LecturaModel> lecturas) {
  List<String> fechas = [];

  for (LecturaModel lect in lecturas) {
    fechas.add(lect.fecha);
  }
  fechas = torcerFechasCompletas(fechas);

  final List<String> sortedDates =
      fechas.toList(); //se crea una copia con una nueva instancia de fechas
  sortedDates
      .sort((b, a) => a.compareTo(b)); //ordena en orden descendente [3,2,1]
  // sortedDates.sort(); //por defecto ordena en orden ascendente [1,2,3]

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
    //se llena la lista ordenada de Lecturas segun los valores del vector obtenido
    lectOrdenadas.add(lecturas[i]);
  }
  return lectOrdenadas;
}

/// [date] es la fecha en formato DD/MM/YYYY, devuelve la fecha sin el dia: /MM/YYYY
String setToMonthYear(String date) {
  return date.substring(2);
}

double getConsumoTotal(List<LecturaModel> lecturas) {
  if (lecturas == null) return 0;
  final lecturasOrdenadas = ordenarPorFecha(lecturas).reversed.toList();
  final double consumoTotal =
      lecturasOrdenadas[lecturasOrdenadas.length - 1].lectura -
          lecturasOrdenadas[0].lectura;

  return consumoTotal;
}

/// para formatear numeros con espacios para cada millar ejm: para la cadena '12345' se retorna '12 345'
String utilFormatNum(String numStr) {
  String result = '';
  int d = 0;
  //se recorre la cadena del numero de atras para alante
  for (int i = numStr.length - 1; i >= 0; i--) {
    d++;
    result += numStr[i];
    if (((d.remainder(3)) == 0) && (d != numStr.length)) {
      result += ' ';
    }
  }

  return utilsInvertirStr(result);
}

String utilsInvertirStr(String str) {
  String result = '';
  for (int i = str.length - 1; i >= 0; i--) {
    result += str[i];
  }
  return result;
}

/// hay que pasarle una lista de lectura model con todas las lecturas, ademas una referencia de las tarjetas, retorna las tarjetas pasadas como referencias, pero llanas con la lista de lecturasmodel y sus deltas
List<TarjetaLectura> fillCardLectura(
  List<LecturaModel> listaLecturas,
  List<TarjetaLectura> tarjetasLect, {
  cardIsDeletable = false,
  cardIsElevated = true,
  cardMostrarConsumo = true,
}) {
  if (tarjetasLect.isNotEmpty) tarjetasLect.clear();

  double _delta = 0.0, _deltaAnterior = 0.0;
  for (int i = 0; i < listaLecturas.length; i++) {
    //delta = lectura_actual - lectura_anterior
    if (i < (listaLecturas.length - 1)) {
      _delta = listaLecturas[i].lectura - listaLecturas[i + 1].lectura;
    }

    tarjetasLect.add(TarjetaLectura(
      lectura: listaLecturas[i],
      isDeletable: cardIsDeletable,
      isElevated: cardIsElevated,
      mostrarConsumo: cardMostrarConsumo,
      trending: {
        "delta": _delta,
        "deltaAnterior": _deltaAnterior,
      },
    ));

    _deltaAnterior = _delta;
    _delta = 0.0;
  }
  return tarjetasLect.toList(); // tolist para retornar otra instancia
}

/// retorna una lista con las tasas de consumo en unidades de (delta-kWh)/dia
List<double> utilGetTasasConsumo(List<LecturaModel> lecturasOrdenadas) {
  // tasaConsumo = (deltaConsumo)/(#_de_dias_entre_lecturas)
  //             = (lectura_actual - lectura_anterior)/(dif de dias entre ambas lecturas)
  List<double> tasasConsumo = [0.0];

  for (int i = 1; i < lecturasOrdenadas.length; i++) {
    //se calcula la diferencia de consumo entre dos lecturas consecutivas: deltaConsumo
    final double deltaConsumo =
        lecturasOrdenadas[i].lectura - lecturasOrdenadas[i - 1].lectura;

    // se obtienen los DateTime para cada fecha
    final DateTime fechaLectActual =
        utilgetDateTimeFromStr(lecturasOrdenadas[i].fecha);
    final DateTime fechaLectAnterior =
        utilgetDateTimeFromStr(lecturasOrdenadas[i - 1].fecha);

    //se obtiene la diferencia de dias entre las lecturas
    final Duration _difference = fechaLectActual.difference(fechaLectAnterior);
    // se obtiene cantDias con la diferencia en dias
    final int cantDias = _difference.inDays;

    // se calcula la tasa de consumo electrico
    final double tasaConsumo = deltaConsumo / cantDias;
    // se agrega al vector tasasConsumo;
    tasasConsumo.add(tasaConsumo);
  }

  return tasasConsumo;
}

/// [fecha] tiene que estar en el formato DD/MM/YYYY, retorna una instancia de DateTime para tal fecha
DateTime utilgetDateTimeFromStr(String fecha) {
  // ejm: fecha = "21/2/2021"
  List<String> componentesFecha =
      fecha.split('/'); // componentesFecha = ['21','2','2021']
  final String fechaFormat = componentesFecha[2] +
      '-' +
      componentesFecha[1] +
      '-' +
      componentesFecha[0];
  final DateTime dateTime = DateTime.parse(fechaFormat); //"2021-02-21"

  return dateTime;
}

Future<List<LecturaModel>> getLecturasOrdenadas(ContadorModel contador) async {
  final List<LecturaModel> lecturas =
      await DBProvider.db.getLecturasByContador(contador);

  return (lecturas == null) ? [] : ordenarPorFecha(lecturas).toList();
}
