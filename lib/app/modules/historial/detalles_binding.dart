import 'package:get/get.dart';
import 'package:healthCalc/app/data/model/contador_model.dart';

import 'detalles_controller.dart';

class DetallesBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut< DetallesController>(() => DetallesController(contador: ContadorModel()), fenix: true);
  }
}