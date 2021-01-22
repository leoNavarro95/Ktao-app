import 'package:get/get.dart';
import 'package:healthCalc/app/data/model/contador_model.dart';
import 'package:healthCalc/app/modules/calculadora/calculadora_controller.dart';
import 'package:healthCalc/app/modules/historial/historial_controller.dart';
import 'package:healthCalc/app/modules/home/home_controller.dart';
import 'package:healthCalc/app/modules/lectura/lectura_controller.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura_controller.dart';
import 'package:healthCalc/app/modules/splash/splash_controller.dart';

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
