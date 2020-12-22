

import 'package:get/get.dart';

class TarjetaController extends GetxController{

  double elevacion = 5.0;
  
  //se encarga de variar la elevacion de la tarjeta, dando la sensacion de que se unde ante el evento tap
  void presionada(String id){
    elevacion = 1.0;
    update([id]);
    Future.delayed(Duration(milliseconds: 250),(){
      elevacion = 5.0;
      update([id]);
    });
  }
  
  @override
  void onReady() {
    super.onReady();
  }

}