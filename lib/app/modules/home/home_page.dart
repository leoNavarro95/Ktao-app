import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthCalc/app/global_widgets/menu_lateral.dart';

import 'package:healthCalc/app/modules/home/home_controller.dart';

import 'local_widgets/tarjeta/tarjeta_contador.dart';

class HomePage extends StatelessWidget {

  //? Para hacer validacion del campo de texto
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return GetBuilder<HomeController>(
      
      init: HomeController(), //TODO: No se porque no me deja usar los datos observables del controller si no pongo esto, no se entiende que con el binding se resueelva esto

      builder: (_){
      return Scaffold(
        drawer: MenuLateral(),
        appBar: buildAppBar(_),
        body: ListView(
          children: <Widget>[
            Column(
              children: [
                Obx(()=>buildTableContadores(contadores: _.tarjetas),),
                // Obx(()=>Text('Texto: ${_.resultado.value}')),
            ],
          ),
          ]),
          );
    });
  }

  Table buildTableContadores({List<TarjetaContador> contadores}) {
    List<TableRow> _lista = [];
    List<Widget> _fila = [];
    int cantidadFilas = 0;
    int cantidadColumnas = 2;

    //calculando el numero de filas necesario
    if(contadores.length % 2 == 0){ //si es par
      cantidadFilas = (contadores.length) ~/ 2;
    } else{
      cantidadFilas = (contadores.length ~/ 2) + 1;
    }

    int index = 0;

    for (int i = 0; i < cantidadFilas ; i++){
      for(int j = 0; j < cantidadColumnas; j++){
        if(index >= contadores.length){
          _fila.add(Container());  
        } else {
          _fila.add(contadores[index]);
        }
        index++;
        
      }
      _lista.add(TableRow(children: _fila.toList()));
      _fila.clear();
    }


    return Table(children: _lista);
      
      
    // return Table(
    //           children: [
    //             TableRow(
    //               children: [
    //                 TarjetaContador(titulo: 'Titulo1',),
    //                 TarjetaContador(titulo: 'Titulo4',)
    //               ]
    //             ),
    //             TableRow(
    //               children: [
    //                 TarjetaContador(titulo: 'Titulo3',),
    //                 TarjetaContador(titulo: 'Titulo2',)
    //               ]
    //             ),
    //           ],
    //         );
  }

  AppBar buildAppBar(HomeController _) {
    return AppBar(
        title: Text('Inicio'),
        centerTitle: true,
      
        actions: [
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: ()async{
              String nombre = await _adicionarContador();
              if(nombre != null){
                _.adicionarTarjeta(TarjetaContador(titulo: nombre,));
              }
            }
            )
          ],
    );
  }

  Future<String> _adicionarContador() async{
    String _valorInput = '';

    return await Get.dialog(
      AlertDialog(
        
          backgroundColor: Colors.lightBlue[50],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Adicionar contador'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      
                      decoration: InputDecoration(
                        labelText: 'Nombre contador',
                        icon: Icon(Icons.add_box),
                      ),

                      validator: (value){
                        if(value.isEmpty){
                          return 'Introduzca un nombre';
                        }
                        _valorInput = value;
                        return null;
                      },
                    ),
                  ],
                  ),
                ),
              
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                //validate() devuelve true si el formulario es valido
                if(_formKey.currentState.validate()){
                 Get.back( result: _valorInput); 
                }
              },
              ),
              FlatButton(
              child: Text('CANCEL'),
              onPressed: () => Get.back(), //! va a retornar null, manejarlo del otro lado
              ),
          ],
        ),
      barrierDismissible: false,
    );
    
  }

}

