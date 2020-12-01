import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:preferencias_de_usuario/src/controllers/home_controller.dart';
import 'package:preferencias_de_usuario/src/pages/getx_widgets/text_home.dart';
import 'package:preferencias_de_usuario/src/widgets/menu_lateral_widget.dart';

//esta vista va a ser para aprender a usar GetX como gestor

class GetxPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return GetBuilder <HomeController>(
      init: HomeController(), //la clase donde está definido el controlador de estado
      builder: (_) {

        print('renderizado home');
        return Scaffold(
        drawer: MenuLateral(),
        appBar: AppBar(
          title: Text('GetX ejemplo'),
          // backgroundColor: (prefs.colorSecundario) ? Colors.blueGrey : Colors.blue,
        ),
        body: Center(

          //OJO: de esta forma haciendo uso del parámetro id: se logra solo renderizar el 
          //objeto que se desee al lanzar desde el controller el método update(['nombre id'])
          //, esto hace que donde se implemente el GetBuilder con tal id, es donde único se 
          //va a renderizar la vista. Como esta vez el getbuilder es un hijo de otro, no es necesario usar el parámetro init: con su respectivo conrolador
          child: TextHome(),
          ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.plus_one),
          onPressed: (){
            _.increment();
          },
        ),
      );
      } 
    );
  }
}
