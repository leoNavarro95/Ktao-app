

import 'package:get/get.dart';
import 'package:ktao/app/modules/calculadora/calculadora_controller.dart';

class CalculadoraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalculadoraController());
  }

}
