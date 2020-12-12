

import 'package:get/get.dart';
import 'package:preferencias_de_usuario/api/users_api.dart';
import 'package:preferencias_de_usuario/models/user_model.dart';

//este archivo va a contener las variables y funciones de la aplicacion que van a ser reactivas
class HomeController extends GetxController{
  
  List<User> _users = [];

  List<User> get users => _users;

  int _counter = 0;
  int get counter => _counter;

// loading define cuando se está esperando por datos de la api rest
  bool _loading = true;
  bool get loading => _loading;


  //este metodo se ejecuta una sola vez cuando el widget ha sido cargado en memoria (OJO aun no es renderizado)
  @override
  onInit(){
    super.onInit();
    // print('Es lo mismo que el initState()!!!!');
    
  }

  //se ejecuta cuando se acaba de renderizar el widget
  @override
  onReady(){
    super.onReady();
    print('Widget renderizado!');
    loadUsers();
  }

  Future<void> loadUsers() async {
    
    final data = await UserAPI.instance.getUsers(1);
    //TODO: data puede contener null en caso de que no existan datos
    if(!(data.isNull)){
      this._loading = false; //terminó de hacer la carga
      this._users = data;
      update(['users']); //se actualizaran las vistas con id's users
    }

  } 

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