

import 'package:get/get.dart';

class ReactiveController extends GetxController{

  //? con .obs se hace que sea observable la variable. Esto permite que la parte visual responda segun cambie el valor de esta variable
  RxInt counter = 0.obs; 
  RxString date = '--:--'.obs;


  increment(){
    counter.value++;
  }

  getDate(){
    date.value = DateTime.now().toString();
  }

}