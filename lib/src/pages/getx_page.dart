import 'package:flutter/material.dart';
import 'package:preferencias_de_usuario/src/widgets/menu_lateral_widget.dart';

//esta vista va a ser para aprender a usar GetX como gestor

class GetxPage extends StatelessWidget {
  static final String routeName = 'GetX';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      appBar: AppBar(
        title: Text('GetX ejemplo'),
        // backgroundColor: (prefs.colorSecundario) ? Colors.blueGrey : Colors.blue,
        
      ),
    );
  }
}