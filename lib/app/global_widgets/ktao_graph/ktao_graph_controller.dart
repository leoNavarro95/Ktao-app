import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KtaoGraphController extends GetxController {
  /// mapa con llave fecha y valores lecturas para esa fecha
  final Map<String, List<double>> lectXmes;

  KtaoGraphController({
    this.lectXmes,
  }) : assert(lectXmes != null);
  List<String> mesesShort;
  List<int> vectorXaxis;

  @override
  void onInit() {
    super.onInit();
    // final lectCtr = Get.find<LecturaController>();
    // print(lectCtr.lectOrdenadas);
    mesesShort =
        this._getMesesShort(this.extractMesesRaw(this.lectXmes)).toList();
    vectorXaxis = this.getvectorXaxis(this.lectXmes);
  }

  //* ###########Tratamiento de los datos para graficarlos#################

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
  int divisionesYaxis = 4; //cantidad de divisiones a mostrar en la escala de Y
  num _minY = 0;
  num _maxY = 0;
  int stepYaxis = 0; 
  List<int> vectorYaxis = [0];

  void setYTitlesExtremes(num minY, num maxY) {
    _minY = minY;
    _maxY = maxY;
    // distancia entre cada division
    stepYaxis = ((_maxY - _minY) / divisionesYaxis).round();
    fillVectorYaxis( stepYaxis, divisionesYaxis );
  }

  void fillVectorYaxis(int stepYaxis, int divisionesYaxis) {
    // if (vectorYaxis.isNotEmpty) vectorYaxis.clear();

    int currentValue = 0;
    for (int i = 0; i < divisionesYaxis; i++) {
      currentValue += stepYaxis;
      vectorYaxis.add(currentValue);
    }
  }

  String leftRenderTitles(double axisValues) {
    
    return axisValues.toStringAsFixed(0);
    
    // int axisInt = axisValues.toInt();
    // if (vectorYaxis.contains(axisInt)) {
    //   return axisInt.toString();
    // }
    // return '';
  }

  String bottomRenderTitles(double axisValues) {
    int axisInt = axisValues.toInt();
    if (vectorXaxis.contains(axisInt)) {
      return mesesShort[vectorXaxis.indexOf(axisInt)];
    }
    return '';
  }

  List<FlSpot> getGraphSpots(List<double> tasasConsumo) {
    List<FlSpot> spots = [];
    int index = 0;
    for (double tasas in tasasConsumo) {
      final spot = FlSpot(index.toDouble(), tasas.toPrecision(2));
      spots.add(spot);
      index++;
    }
    return spots;
  }
}
