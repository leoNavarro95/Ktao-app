import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthCalc/app/data/model/contador_model.dart';
import 'package:healthCalc/app/data/provider/data_base_provider.dart';
import 'package:healthCalc/app/global_widgets/dialogos.dart';
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
    const int cantidad_columnas = 2;

    //calculando el numero de filas necesario
    if(contadores.length % 2 == 0){ //si es par
      cantidadFilas = (contadores.length) ~/ 2;
    } else{
      cantidadFilas = (contadores.length ~/ 2) + 1;
    }

    int index = 0;

    for (int i = 0; i < cantidadFilas ; i++){
      for(int j = 0; j < cantidad_columnas; j++){
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
  }

  AppBar buildAppBar(HomeController _) {
    return AppBar(
        title: Text('Inicio'),
        centerTitle: true,
      
        actions: [
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: ()async{
              String nombre = await addContadorDialog( _formKey );

              if(nombre != null){
                
                final contador = ContadorModel( nombre: nombre, consumo: 0, costoMesActual: 0.0, ultimaLectura: 'Hoy');
                int id = await DBProvider.db.nuevoContador(contador);
                Get.snackbar('Exito', 'Nuevo contador en la base de datos');
                //!OJO hay que hacer depender el front-end de la base de datos, para mostrar datos guardados en la misma
                await _.updateVisualFromDB();
              } else{
                Get.snackbar('No se efectuo ningun cambio', 'Se mantienen los datos anteriores');
              }
            }
            ),

            IconButton(
              icon: Icon(Icons.delete), 
              onPressed: ()async{
                bool aceptas = await borraTodoDialog();

                if( aceptas ){
                  final cantidad = await DBProvider.db.deleteallContadores();
                  Get.snackbar('Se eliminaron los contadores', '$cantidad contadores eliminados.');
                } else {
                  Get.snackbar('Ningun contador eliminado.', 'Se mantienen los datos');
                }
              },
              )
          ],
    );
  }

  
  
}

