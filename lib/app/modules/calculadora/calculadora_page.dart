import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthCalc/app/global_widgets/menu_lateral.dart';
import 'package:healthCalc/app/modules/calculadora/calculadora_controller.dart';
import 'package:healthCalc/app/modules/calculadora/local_widgets/campo_texto.dart';
import 'package:healthCalc/app/modules/calculadora/local_widgets/tabla_widget.dart';
import 'package:healthCalc/app/theme/text_theme.dart';


class CalculadoraPage extends StatelessWidget {

  final _textCtrLectura1 = new TextEditingController();
  final _textCtrLectura2 = new TextEditingController();
  
  // final calcCtr = new CalculadoraController();

  // final temaTexto = new TemaTexto();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalculadoraController>(
      builder: (_){
        return Scaffold(
          appBar: AppBar(title: Text('Calculadora'),),
          drawer: MenuLateral(),
          
          body: Center(
          child: _principal(_)
    ),
    );
      }
      );
  }

  Widget _principal(CalculadoraController _) {
    return ListView(
      children: <Widget>[
        Text(
          'Calcula el consumo en kWh',
          textAlign: TextAlign.center,
          style: TemaTexto().titulo,
          ),
        Divider(),
        _creaFormulario(_),
        Divider(),
        Obx(()=>Text("consumo: ${_.consumo.value} kWh"),),
        Obx(()=>Text("costo: ${_.costo.value.toStringAsFixed(2)} Pesos"),),
        
        Obx(()=>Tabla(
          titleRow: ['Rango','Consumo', 'Precio', 'Importe'],
          titleColor: Color.fromRGBO(120,200,220,1),
          primaryColor: Color.fromRGBO(0,180,210,0.7),
          secundaryColor: Color.fromRGBO(10,100,180,0.3),

          cuerpo: [
            ['0 a 100','101 a 150','151 a 200','201 a 250','251 a 300','301 a 350','351 a 500','501 a 1000','1001 a 5000', '+ 5000'],  //rango
            _.listConsumo,                                           //consumo
            [0.4,1.3,1.75,3.0,4.0,7.50,9.0,10.0,15.0,25.0], //precios por rango
            _.listPrecio,                                            //importe
            ],
          ),),
        
      ],
    );
  }

  Widget _creaFormulario( CalculadoraController _) {
    return Container(
      // alignment: Alignment.center,
      
      padding: EdgeInsets.all(10),
      color: Colors.blue[100],
      child: Column(
        children: [
          CampoTextoCalculadora(
            textController: _textCtrLectura1, 
            titulo: "Lectura 1", 
            calcCtr: _
            ),
            SizedBox(height: 10),
            CampoTextoCalculadora(
            textController: _textCtrLectura2, 
            titulo: "Lectura 2", 
            calcCtr: _
            ),
          SizedBox(height: 10),
        ],
      ),
    );
  }



}