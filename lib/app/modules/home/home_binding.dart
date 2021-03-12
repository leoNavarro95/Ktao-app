import 'package:get/get.dart';
import 'package:ktao/app/global_widgets/ktao_graph/ktao_graph_controller.dart';
import 'package:ktao/app/modules/detalles/detalles_controller.dart';
import 'package:ktao/app/modules/lectura/lectura_controller.dart';

import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<LecturaController>(() => LecturaController(), fenix: true);
    //! OJO con create se permite que cada vez que se llame a Get.find se obtenga una nueva instanci del controlador, en este caso eso me permite tener multiples instancias del widget KtaoGraph cada una con un controlador diferente
    Get.create(() => KtaoGraphController());
  }
}

