
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GraphWidgetController extends GetxController {

// MyController({@required this.repository}) : assert(repository != null);

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool _showAvg = false;

  bool get showAvg => _showAvg;
  set showAvg(bool showAvg) {
    _showAvg = showAvg;
  }

}