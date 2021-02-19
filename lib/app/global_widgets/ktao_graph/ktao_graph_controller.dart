import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KtaoGraphController extends GetxController {
  /// mapa con llave fecha y valores lecturas para esa fecha
  final Map<String, List<double>> lectXmes;

  KtaoGraphController({this.lectXmes}) : assert(lectXmes != null);

  @override
  void onInit() {
    super.onInit();
    print('  datos   :  ${this.lectXmes}');
    print('  lecturas:  ${this.extractLectRaw(this.lectXmes)}');
    print('  meses   :  ${this.extractMesesRaw(this.lectXmes)}');

    this.maxXvalue = this.extractLectRaw(this.lectXmes).length.toDouble() + 5;
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

    switch (axisValues.toInt()) {
      case 2:
        return 'MAR';
      case 5:
        return 'JUN';
      case 8:
        return 'SEP';
    }
    return '';
  }
}
