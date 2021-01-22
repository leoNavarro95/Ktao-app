import 'package:get/get.dart';
import 'package:healthCalc/app/data/model/contador_model.dart';

import 'historial_controller.dart';

class HistorialBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut< HistorialController>(() => HistorialController(contador: ContadorModel()), fenix: true);
  }
}