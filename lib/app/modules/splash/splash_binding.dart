import 'package:get/get.dart';

import 'package:ktao/app/modules/calculadora/calculadora_controller.dart';
import 'package:ktao/app/modules/home/home_controller.dart';
import 'package:ktao/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura_controller.dart';
import 'package:ktao/app/modules/splash/splash_controller.dart';

//* Los bindigs son usados para la inyeccion de dependencias
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    //* Hace que no sea necesario tener que usar init en la pagina padre
    Get.lazyPut(() => SplashController());
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<CalculadoraController>(() => CalculadoraController());
    Get.lazyPut<TarjetaLectController>(() => TarjetaLectController());

    // Get.lazyPut<HistorialController>(
    //   () => HistorialController(
    //     contador: Get.find<LecturaController>().contador,
    //   ),
    //   fenix: true,
    // );
  }
}
