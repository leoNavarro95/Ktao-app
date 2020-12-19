

import 'package:get/get.dart';
import 'package:healthCalc/app/modules/splash/splash_controller.dart';

//* Los bindigs son usados para la inyeccion de dependencias
class SplashBinding extends Bindings{
  @override
  void dependencies() {
    
    //* Hace que no sea necesario tener que usar init en la pagina padre
    Get.lazyPut(() => SplashController());

  }

}