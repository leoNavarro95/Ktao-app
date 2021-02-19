import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KtaoGraphController extends GetxController {
  /// mapa con llave fecha y valores lecturas para esa fecha
  final Map<String, List<double>> lectXmes;

  KtaoGraphController({this.lectXmes}) : assert(lectXmes != null);
  List<String> mesesShort;
  List<int> vectorXaxis;

  @override
  void onInit() {
    super.onInit();

    print('  datos      :  ${this.lectXmes}');
    print('  lecturas   :  ${this.extractLectRaw(this.lectXmes)}');
    print('  meses      :  ${this.extractMesesRaw(this.lectXmes)}');
    print(
        '  mesesShort :  ${this._getMesesShort(this.extractMesesRaw(this.lectXmes))}');
    print(' vectorAxis  : ${this.getvectorXaxis(this.lectXmes)}');

    mesesShort =
        this._getMesesShort(this.extractMesesRaw(this.lectXmes)).toList();
    vectorXaxis = this.getvectorXaxis(this.lectXmes);
    this.maxXvalue = this.extractLectRaw(this.lectXmes).length.toDouble() + 1;
  }

  //* ###########Tratamiento de los datos para graficarlos#################

  /// retorna una lista con todas las lecturas en bruto, como vienen desde detalles page, ojo ya vienen ordenadas segun fecha
  List<double> extractLectRaw(Map<String, List<double>> _lectXmes) {
    List<double> lectRaw = [];
    _lectXmes.values.map((lectParaMes) {
      for (double lect in lectParaMes) {
        lectRaw.add(lect);
      }
    }).toList();

    return lectRaw;
  }

  /// retorna una lista con todas los meses en raw (como vienen desde detalles page)
  List<String> extractMesesRaw(Map<String, List<double>> _lectXmes) {
    return _lectXmes.keys.toList();
  }

  String _convertRaw2ShortMonth(String mesRaw, {int numOfChars = 3}) {
    String shortMonth = '';
    for (int i = 0; i < numOfChars; i++) {
      shortMonth += mesRaw[i];
    }
    return shortMonth.toUpperCase();
  }

  ///retorna una lista con los meses, pero solo con tres caracteres en uppercase, ejm: para febrero: FEB
  List<String> _getMesesShort(List<String> mesesRaw) {
    List<String> mesesUpperCase = [];
    mesesRaw.map((mes) {
      mesesUpperCase.add(_convertRaw2ShortMonth(mes));
    }).toList();
    return mesesUpperCase;
  }

  /// obtiene el vector de los meses para el eje X
  /// si la entrada fuera {diciembre del 2020: [2222.5], enero del 2021: [10000.0, 10001.0, 10010.0], febrero del 2021: [20000.0, 20005.0, 20010.0]}
  /// la salida seria: [1, 2, 5]
  List<int> getvectorXaxis(Map<String, List<double>> lecturasXmes) {
    //! OJO este vector siempre va a empezar por 0, es el primer mes para la primera lectura
    List<int> vector = [0];
    List<int> lect4mes =
        []; // [1, 3, 3]  cantidad de lecturas para cada mes segun orden en el map

    for (final val in lecturasXmes.values) {
      lect4mes.add(val.length);
    }

    for (int i = 0; i < (lect4mes.length - 1); i++) {
      vector.add(lect4mes[i] + vector[i]);
    }
    return vector;
  }

  //* ###################Algoritmos para graficar##########################
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  /// valores maximos de los ejes coordenados
  double maxXvalue = 5;
  double maxYvalue = 10;

  String leftRenderTitles(double axisValues) {
    // Hay que tomar todos los valores de las lecturas de lectXmes y poner el minimo como case 1 y
    switch (axisValues.toInt()) {
      case 1:
        return '10k';

      case 3:
        return '30k';
      case 5:
        return '50k';
      case 10:
        return '100k';
    }
    return '';
  }

  String bottomRenderTitles(double axisValues) {
    // Hay que tomar todos los valores de las lecturas de lectXmes y poner el minimo como case 1
    // switch (axisValues.toInt()) {
    //   case 1:
    //     return 'MAR';
    //   case 5:
    //     return 'JUN';
    //   case 8:
    //     return 'SEP';
    // }
    // return '';
    int axisInt = axisValues.toInt();
    if (vectorXaxis.contains(axisInt)) {
      return mesesShort[vectorXaxis.indexOf(axisInt)];
    }
    return '';
  }
}
