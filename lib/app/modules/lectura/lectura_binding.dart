

import 'package:get/get.dart';
import 'package:ktao/app/modules/detalles/detalles_controller.dart';

import 'lectura_controller.dart';

class LecturaBinding implements Bindings {
@override
void dependencies() {
  // Get.lazyPut< LecturaController>(() => LecturaController());
  Get.put<DetallesController>(
        DetallesController(contador: Get.find<LecturaController>().contador));
  }
}