

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
    //OJO: si a update se le pasa una lista de Strings (que serían los ids), solo se 
    //actualizaran las vistas cuyos id coincidan con los de tal lista. Esto permite refrescar 
    //lugares específicos de la aplicacion sin estar redibujando la pantalla completa
    //update(['id1','id2'], condicion) , el segundo parámetro de update() es la condición 
    //para que se renderice, mientras condicion no se cumpla, pues no va a renderizar el 
    //Widget construido por GetBuilder<MyController> por ejemplo: 
    // update(['texto'], _counter >= 5); solo renderizará el Widget con id 'texto' si el 
    // contador es mayor o igual a 5
    update(['texto']); //refresca la vista para actualizar los nuevos datos
  }
}