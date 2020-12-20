

import 'package:get/get.dart';
import 'package:healthCalc/app/modules/home/home_page.dart';


class SplashController extends GetxController{
  
  @override
  void onReady() {
    Future.delayed(Duration(seconds: 2), (){
      Get.off(HomePage(), transition: Transition.size);
    });
      
    super.onReady();

  }

}