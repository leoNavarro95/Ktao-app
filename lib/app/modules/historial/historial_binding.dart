import 'package:get/get.dart';

import 'historial_controller.dart';

class HistorialBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut< HistorialController>(() => HistorialController());
  }
}