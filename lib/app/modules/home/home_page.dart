import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:healthCalc/app/global_widgets/menu_lateral.dart';

import 'package:healthCalc/app/modules/home/home_controller.dart';

import 'local_widgets/tarjeta/tarjeta_contador.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeController>(builder: (_){
      return Scaffold(
        drawer: MenuLateral(),
        appBar: buildAppBar(context),
        body: Table(
          children: [
            TableRow(
              children: [
                TarjetaContador(titulo: 'Titulo1',),
                TarjetaContador(titulo: 'Titulo4',)
              ]
            ),
            TableRow(
              children: [
                TarjetaContador(titulo: 'Titulo3',),
                TarjetaContador(titulo: 'Titulo2',)
              ]
            ),
          ],
        ),
        );
    });
  }

  AppBar buildAppBar(BuildContext ctx) {
    return AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: (){
              _mostrarAlert(ctx);
            }
            )
          ],
        title: Text('Inicio'),
        centerTitle: true,);
  }

  void _mostrarAlert(BuildContext context) {
    //este constructor crea una ventana de dialogo
    showDialog(
      context: context,
      barrierDismissible:
          true, //si se habilita permite cerrar el dialogo dando click fuera de este
      //el builder es el que crea el Widget a mostrar como dialogo, toma el contexto de la pagina y devuelve el Widget a mostrar
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.lightBlue[50],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Este es el Titulo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Este es el contenido de la alerta lanzada...'),
              FlutterLogo(
                size: 100.0,
                style: FlutterLogoStyle.stacked,
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {Navigator.of(context).pop();},  //se puede retornar o llamar
              child: Text('OK')
              ),
              FlatButton(
              onPressed: () => Navigator.of(context).pop(),  //se puede retornar o llamar
              child: Text('CANCEL')
              ),
          ],
        );
      },
    );
  }

}

