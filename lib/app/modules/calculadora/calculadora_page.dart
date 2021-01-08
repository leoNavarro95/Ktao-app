import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthCalc/app/global_widgets/menu_lateral.dart';
import 'package:healthCalc/app/modules/calculadora/calculadora_controller.dart';
import 'package:healthCalc/app/modules/calculadora/local_widgets/campo_texto.dart';
import 'package:healthCalc/app/modules/calculadora/local_widgets/tabla_widget.dart';
import 'package:healthCalc/app/theme/text_theme.dart';
import 'package:healthCalc/app/utils/math_util.dart';


class CalculadoraPage extends StatelessWidget {

  final _textCtrLectura1 = new TextEditingController();
  final _textCtrLectura2 = new TextEditingController();
  
  

  @override
  Widget build(BuildContext context) {
    
    final calcCtr = Get.find<CalculadoraController>();

    return GetBuilder<CalculadoraController>(
      builder: (_){
        return Scaffold(
          appBar: AppBar(title: Text('Calculadora'),),
          drawer: MenuLateral(),
          
          body: Center(
          child: _principal( calcCtr )
    ),
    );
      }
      );
  }

  Widget _principal(CalculadoraController calcCtr) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          'Calcula el consumo en kWh',
          textAlign: TextAlign.center,
          style: TemaTexto().titulo,
          ),
        Divider(),
        _creaFormulario( calcCtr ),
        Divider(),
        Obx(()=>Text("consumo: ${calcCtr.consumo.value} kWh"),),
        Obx(()=>Text("costo: ${calcCtr.costo.value.toStringAsFixed(2)} Pesos"),),
        
        Obx((){
          if(calcCtr.lectura1.value != null){
            return Tabla(
          titleRow: ['Rango','Consumo', 'Precio', 'Importe'],
          titleColor: Color.fromRGBO(120,200,220,1),
          primaryColor: Color.fromRGBO(0,180,210,0.7),
          secundaryColor: Color.fromRGBO(10,100,180,0.3),

          cuerpo: [
            rangos,  //rango
            calcCtr.listConsumo,  //consumo
            precios,        //precios por rango
            calcCtr.listPrecio,    //importe
            ],
          );
          }
          return Container();
        }),
        
      ],
    );
  }

  Widget _creaFormulario( CalculadoraController calcCtr ) {
    return Container(
      // alignment: Alignment.center,
      
      padding: EdgeInsets.all(10),
      color: Colors.blue[100],
      child: Column(
        children: [
          CampoTextoCalculadora(
            textController: _textCtrLectura1, 
            titulo: "Lectura 1", 
            calcCtr: calcCtr
            ),
            SizedBox(height: 10),
            CampoTextoCalculadora(
            textController: _textCtrLectura2, 
            titulo: "Lectura 2", 
            calcCtr: calcCtr
            ),
          SizedBox(height: 10),
        ],
      ),
    );
  }



}