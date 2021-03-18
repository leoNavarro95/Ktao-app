import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ktao/app/modules/calculadora/calculadora_controller.dart';

class CampoTextoCalculadora extends StatelessWidget {
  
  final CalculadoraController calcCtr;
  final TextEditingController textController;
  final String titulo;

  const CampoTextoCalculadora(
    {
      @required this.textController, 
      @required this.titulo,
      @required this.calcCtr,
    }
    );

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.blue[100],
        // padding: EdgeInsets.symmetric(horizontal: 30.0),
        width: 150,
        
        child: TextField(
          
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[ .,-]')),],
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          controller: textController,
          decoration: InputDecoration(
            icon: Icon(Icons.flash_on),
            labelText: titulo,
            ),
          onChanged: (val) {
            int valor = 0;
            if(val.length == 0){
              valor = 0;
            } else{
              valor = int.parse(val).toInt();
            }

            if( (titulo == "Lectura 1") || (titulo == "Consumo")){
              //TODO: Implementar uso de user_preferences para guardar Lecturas
              calcCtr.lectura1.value = valor;
              calcCtr.calcular();
            }
            else if( titulo == "Lectura 2"){
              
              calcCtr.lectura2.value = valor;
              calcCtr.calcular();
            }
          },
        ),
        );
  }
}