import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import 'package:healthCalc/api/users_api.dart';
import 'package:healthCalc/models/user_model.dart';
import 'package:healthCalc/src/pages/profile_page.dart';

//este archivo va a contener las variables y funciones de la aplicacion que van a ser reactivas
class HomeController extends GetxController {
  List<User> _users = [];

  List<User> get users => _users;

  int _counter = 0;
  int get counter => _counter;

// loading define cuando se está esperando por datos de la api rest
  bool _loading = true;
  bool get loading => _loading;

  //este metodo se ejecuta una sola vez cuando el widget ha sido cargado en memoria (OJO aun no es renderizado)
  @override
  onInit() {
    super.onInit();
    // print('Es lo mismo que el initState()!!!!');
  }

  //se ejecuta cuando se acaba de renderizar el widget
  @override
  onReady() {
    super.onReady();
    print('Widget renderizado!');
    loadUsers();
  }

  Future<void> loadUsers() async {
    final data = await UserAPI.instance.getUsers(1);
    if (!(data.isNull)) {
      this._loading = false; //terminó de hacer la carga
      this._users = data;
      update(['users']); //se actualizaran las vistas con id's users
    }
  }

  increment() {
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


  Future<void> showUserProfile(User user) async {
    //OJO: de esta forma en result se va a esperar que de la pagina ProfilePage se retorne un string, para luego ser usada
    final result = await Get.to<String>(
      ProfilePage(),
      arguments: user,   //arguments son argumentos que se pueden pasar entre paginas usando getx
    );

    if ( result != null ) {
      print('Datos devueltos: $result');
    }
  }
}
