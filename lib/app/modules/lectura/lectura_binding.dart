

import 'package:get/get.dart';

import 'lectura_controller.dart';

class LecturaBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut< LecturaController>(() => LecturaController());
  }
}