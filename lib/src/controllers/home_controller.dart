

import 'package:get/state_manager.dart';

//este archivo va a contener las variables y funciones de la aplicacion que van a ser reactivas
class HomeController extends GetxController{

  int _counter = 0;

  int get counter => _counter;

  increment(){
    this._counter++;
    update(); //refresca la vista para actualizar los nuevos datos
  }
}