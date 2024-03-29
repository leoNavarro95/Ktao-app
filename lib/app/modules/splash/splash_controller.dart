

import 'package:get/get.dart';
import 'package:ktao/app/modules/home/home_binding.dart';
import 'package:ktao/app/modules/home/home_controller.dart';
import 'package:ktao/app/modules/home/home_page.dart';


class SplashController extends GetxController{
  
  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration(seconds: 1), (){
      Get.off(() => HomePage(), transition: Transition.size, binding: HomeBinding());
    });
      
  }

  @override
  void onInit() {
    super.onInit();
    ///! esto de por si solo crea una instancia de HomeController y por lo tanto
    ///! ejecuta el onInit de esa clase
    Get.find<HomeController>(); 
  }

}