
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthCalc/app/data/model/contador_model.dart';


Future<bool> borraTodoDialog() async{

    return await Get.dialog(
      AlertDialog(
          backgroundColor: Colors.lightBlue[50],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Desea eliminar todos los contadores?'),
          content: Text("Se perderan los registros de la base de datos"),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                 Get.back( result: true); 
              },
              ),
              FlatButton(
              child: Text('CANCELAR'),
              onPressed: () => Get.back( result: false),
              ),
          ],
        ),
      barrierDismissible: false,
    );
  }


  Future<bool> borraContadorDialog( ContadorModel contador ) async{

    return await Get.dialog(
      AlertDialog(
          backgroundColor: Colors.lightBlue[50],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Desea eliminar el contador?'),
          content: Text("El contador ${contador.nombre} sera eliminado completamente de la base de datos"),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                 Get.back( result: true); 
              },
              ),
              FlatButton(
              child: Text('CANCELAR'),
              onPressed: () => Get.back( result: false),
              ),
          ],
        ),
      barrierDismissible: false,
    );
  }


  Future<String> addContadorDialog( GlobalKey<FormState> formKey ) async{
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
                key: formKey,
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
                if(formKey.currentState.validate()){
                 Get.back( result: _valorInput ); 
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
