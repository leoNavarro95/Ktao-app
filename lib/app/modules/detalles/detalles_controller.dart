import 'package:get/get.dart';
import 'package:ktao/app/data/model/contador_model.dart';
import 'package:ktao/app/data/model/lectura_model.dart';
import 'package:ktao/app/data/provider/data_base_provider.dart';
import 'package:ktao/app/modules/detalles/local_widgets/tarjeta_mes.dart';
import 'package:ktao/app/modules/lectura/lectura_controller.dart';
import 'package:ktao/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura.dart';
import 'package:ktao/app/utils/lecturas_utils.dart';
import 'package:meta/meta.dart';

class DetallesController extends GetxController {
  final ContadorModel contador;
  DetallesController({@required this.contador}) : assert(contador != null);

  final lecturaCtr = Get.find<LecturaController>();

  @override
  void onInit() async {
    super.onInit();
    await updateVisualFromDB();
  }

  ///lista que contiene las tarjetas de los meses
  List<TarjetaMes> _tarjetasMes = [];
  List<TarjetaMes> get tarjetasMes => _tarjetasMes;

  ///para ser usada en la grafica, va a tener un string por cada mes de lecturas y una lista de las lectuars para el mismo
  Map<String, List<double>> lecturasXmes = {};

  Future<List<TarjetaMes>> updateVisualFromDB() async {
    _tarjetasMes.clear();
    List<String> monthYear = await _getMonthYears();
    monthYear = monthYear.reversed.toList();

    Map<String, List<TarjetaLectura>> tarjetasXmes = {};

    for (int i = 0; i < monthYear.length; i++) {
      List<TarjetaLectura> tarjetasXMes =
          getTarjetaLectByDate(lecturaCtr.tarjetasLect, monthYear[i]);
      Map<String, List<double>> fechaAndLecturas =
          getFechaAndLecturas(monthYear[i], tarjetasXMes);
      lecturasXmes.addAll(fechaAndLecturas);
      tarjetasXmes.addAll({fechaLiteral(monthYear[i]): tarjetasXMes});
    }

    Map<String, double> consumoXmeses = calcularConsumoXmes(lecturasXmes);

    await _llenarTarjetasMes(tarjetasXmes, consumoXmeses);

    return _tarjetasMes;
  }

  List<TarjetaLectura> getTarjetaLectByDate(
      List<TarjetaLectura> tarjetasLectura, String monthYearDate) {
    List<TarjetaLectura> tarjetaLectXMes = [];

    tarjetasLectura.forEach((tarLect) {
      //se buscan las tarjetas de lecturas que sean de la fecha dada
      if (tarLect.lectura.fecha.contains(monthYearDate)) {
        final tarjetaLect = TarjetaLectura(
          lectura: tarLect.lectura,
          trending: tarLect.trending,
          isDeletable: false,
          isElevated: true,
        );
        tarjetaLectXMes.add(tarjetaLect);
      }
    });
    return tarjetaLectXMes;
  }

  
  Future<void> _llenarTarjetasMes(
      Map<String, List<TarjetaLectura>> tarjetasXmes,
      Map<String, double> consumoMeses,
      ) async {
    
    for(int i = 0; i < tarjetasXmes.length; i++){
      String fecha = tarjetasXmes.keys.toList()[i];
      double consumoMes = consumoMeses[fecha];
      List<TarjetaLectura> tarjetasLect = tarjetasXmes[fecha];
      final bool _isClosed =
          await DBProvider.db.isMonthClosedDB(this.contador, fecha);
      _tarjetasMes.add(
        TarjetaMes(
          consumoMes: consumoMes,
          isClosed: _isClosed,
          fecha: fecha,
          lecturasMes: tarjetasLect
              .toList(), //* toList() crea una nueva lista y evita pasar directamente la referencia de tarjetasLect. Si se pasa directamente la referencia luego cuando se limpie se borra tambien de aqui
        ),
      );
    }
  
  }

  Map<String, List<double>> getFechaAndLecturas(
      String fecha, List<TarjetaLectura> tarjetasLect) {
    final List<double> lecturas = [];
    for (TarjetaLectura lect in tarjetasLect) {
      lecturas.add(lect.lectura.lectura);
    }

    return {fechaLiteral(fecha): lecturas};
  }

  /// obtiene la lista de monthYears (organizado) sin repetir de las lecturas para el contador dado.
  /// monthYear es en el formato /mes/año (/MM/YY)
  Future<List<String>> _getMonthYears() async {
    final List<LecturaModel> lecturas =
        await DBProvider.db.getLecturasByContador(contador);
    if (lecturas == null) {
      return [];
    }
    final List<String> monthYears =
        lecturas.map((e) => descomponerFecha(e.fecha)).toList();
    List<String> fechasNoRepeat = [];

    if (monthYears == null) {
      return [];
    } else {
      for (int i = 0; i < monthYears.length; i++) {
        // si en la lista no existe esa fechaAcotada se agrega a la misma
        if (!(fechasNoRepeat.contains(monthYears[i]))) {
          // asi solo se agregan nuevas fechas a la lista y no se repiten
          fechasNoRepeat.add(monthYears[i]);
        }
      }
    }
    //Organizando por años la lista de fechas(mes-año) sin repetir
    fechasNoRepeat = _ordenar(fechasNoRepeat);

    return fechasNoRepeat;
  }

  /// retorna un String con el mes y el anho. Por ejempo si se le pasa
  /// '/01/2021', retorna "enero del 2021". mes tiene que estar entre 1 y 12
  /// [fecha] tiene que tener el formato /MM/YYYY
  String fechaLiteral(String fecha) {
    List<String> meses = [
      '',
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre',
    ];
    List<String> parametros = fecha.split('/');
    final int mes = int.parse(parametros[1]);
    final int anho = int.parse(parametros[2]);

    if ((mes <= 0) | (mes > 12) | (mes == null)) {
      return 'mes incorrecto';
    }
    if (anho == null) return 'año incorrecto';

    return '${meses[mes]} del ${anho.toString()}';
  }

  List<String> _ordenar(List<String> fechas) {
    List<String> sortedDate = [];
    //para ordenar la lista de fechas, hay que primero cambiar el formato (torcerlo) de /MM/YYYY a YYYY/MM/
    sortedDate = _torcerFecha(fechas);
    //ya en este punto está en la forma YYYY/MM/ por lo que se le puede aplicar el sort directamente
    sortedDate.sort();
    //ahora hay que volver a torcerla fecha para enderesarla
    sortedDate = _torcerFecha(sortedDate);
    return sortedDate;
  }

  ///cambia el formato de cada elemento de la lista fechas de /MM/YYYY a YYYY/MM/ y viceversa
  List<String> _torcerFecha(List<String> fechas) {
    final List<String> fechaTorcidas = [];
    fechas.map((fecha) {
      //fecha = '/01/2021'
      final comp = fecha.split('/'); // comp = ['','01', '2021' ];

      if (fecha[0] == '/') //es porque está en el formato /MM/YYYY
        fechaTorcidas.add(comp[2] + '/' + comp[1] + '/');
      else //es porque está en el formato YYYY/MM/
        fechaTorcidas.add('/' + comp[1] + '/' + comp[0]);
    }).toList();

    return fechaTorcidas;
  }

  // el formato de la fecha es XX/XX/XXXX ex: 08/01/2021
  String descomponerFecha(String fecha) {
    List<String> splitFecha = fecha.split('/'); // salida ex: ['08','01','2021']
    return '/' + splitFecha[1] + '/' + splitFecha[2]; //retorna '/01/2021'
  }
}
