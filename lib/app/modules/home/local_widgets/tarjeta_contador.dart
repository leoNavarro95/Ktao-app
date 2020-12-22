import 'package:flutter/material.dart';

class Tarjeta extends StatelessWidget {

  const Tarjeta({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Card(
      margin: EdgeInsets.all(20),

      elevation: 5.0,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(50),
        onLongPress: (){
          //TODO: ante longPress mostrar cuadro de opciones, borrar, editar, etc
        },
        onTap: (){
          print('tarjeta presionada');
        },
        child: Container(
          width: 150,
          height: 100,
          child: Text("Home page")
          ),
      ),
    );
  }
}