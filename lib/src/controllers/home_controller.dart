

import 'package:get/get.dart';

//este archivo va a contener las variables y funciones de la aplicacion que van a ser reactivas
class HomeController extends GetxController{

  //este metodo se ejecuta una sola vez cuando el widget ha sido cargado en memoria (OJO aun no es renderizado)
  @override
  onInit(){
    super.onInit();
    print('Es lo mismo que el initState()!!!!');
    
  }


  //se ejecuta cuando se acaba de renderizar el widget
  @override
  onReady(){
    super.onReady();
    print('Widget renderizado!');
  }

  

  int _counter = 0;

  int get counter => _counter;

  increment(){
    this._counter++;
    update(); //refresca la vista para actualizar los nuevos datos
  }
}