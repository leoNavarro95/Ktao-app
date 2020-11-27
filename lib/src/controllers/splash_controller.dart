import 'package:preferencias_de_usuario/src/pages/getx_page.dart';

import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';

class SplashController extends GetxController {

  @override
  void onReady() {
    Future.delayed(Duration(seconds: 2), (){

      // Get.to(GetxPage(), transition: Transition.zoom); //equivale a push navega a GetxPage pero deja aun funcionando a la pantalla Splash
      Get.off(GetxPage(), transition: Transition.zoom); // equivale a pushReplacement, que elimina a la pagina actual luego de entrar en GetxPage
    });
    super.onReady();

  }

}
