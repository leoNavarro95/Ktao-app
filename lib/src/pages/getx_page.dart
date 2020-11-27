import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:preferencias_de_usuario/src/controllers/home_controller.dart';
import 'package:preferencias_de_usuario/src/widgets/menu_lateral_widget.dart';

//esta vista va a ser para aprender a usar GetX como gestor

class GetxPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return GetBuilder <HomeController>(
      init: HomeController(), //la clase donde está definido el controlador de estado
      builder: (_) => Scaffold(
        drawer: MenuLateral(),
        appBar: AppBar(
          title: Text('GetX ejemplo'),
          // backgroundColor: (prefs.colorSecundario) ? Colors.blueGrey : Colors.blue,
        ),
        body: Center(child: Text(_.counter.toString()),),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.plus_one),
          onPressed: (){
            _.increment();
          },
        ),
      ),
    );
  }
}
