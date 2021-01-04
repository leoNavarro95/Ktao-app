
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healthCalc/app/data/model/lectura_model.dart';
import 'package:healthCalc/app/data/provider/data_base_provider.dart';
import 'package:healthCalc/app/modules/lectura/lectura_controller.dart';
import 'package:healthCalc/app/theme/text_theme.dart';

class LecturaForm extends StatelessWidget {
  final GlobalKey<FormState> formKey; // = GlobalKey<FormState>();
  final ContadorModel contador;
  final double height;
  final double width;
  final LecturaController controller;
  LecturaForm({
    this.formKey,
    this.height,
    this.contador,
    this.width,
    this.controller
  });
  @override
  Widget build(BuildContext context) {
    int _lectura = 0;

    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(5),
      color: Colors.blue[100],
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(8),
            child: Text('Introduzca una nueva lectura', style:TemaTexto().bottomSheetBody,)
            ),
          Container(
            width: 0.5*Get.width,
            child: Form(
              key: formKey,
              child: Container(
                height: 50,
                child: TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[ .,-]')),],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Lectura',
                    labelStyle: TemaTexto().infoTarjeta,
                    border: OutlineInputBorder()
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Campo vacio';
                    }
                    _lectura = int.parse(value);
                    return null;
                  },
                ),
              ),
            ),
          ),
          FlatButton(
            shape: StadiumBorder(),
            color: Colors.lightBlue,
            child: Icon(Icons.add, color: Colors.white),
            onPressed: ()async{
              //validate() devuelve true si el formulario es valido
                if(formKey.currentState.validate()){
                 final lectura = LecturaModel(lectura: _lectura, idContador: contador.id);
                await DBProvider.db.insertarLectura(lectura);
                await controller.updateVisualFromDB();
                }
            },
          ),
        ],
     ),
    );
  }
}