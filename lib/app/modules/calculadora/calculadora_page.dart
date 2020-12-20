import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healthCalc/app/global_widgets/menu_lateral.dart';
import 'package:healthCalc/app/modules/calculadora/calculadora_binding.dart';
import 'package:healthCalc/app/modules/calculadora/calculadora_controller.dart';


class CalculadoraPage extends StatelessWidget {

  final _textCtrLectura1 = new TextEditingController();
  final _textCtrLectura2 = new TextEditingController();
  
  final calcCtr = new CalculadoraController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalculadoraController>(
      builder: (_){
        return Scaffold(
          appBar: AppBar(title: Text('Calculadora'),),
          drawer: MenuLateral(),
          
          body: Center(
          child: _principal()
    ),
    );
      }
      );
  }

  Widget _principal() {
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        Text(
          'Calcula el consumo en kWh',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        Divider(),
        _creaFormulario(),
        _crearBotonIMC(),
        Divider(),
        Obx(()=>Text("lect1: ${calcCtr.lectura1.value}  lect2: ${calcCtr.lectura2.value}  consumo: ${calcCtr.consumo.value}"),),
        
      ],
    );
  }

  Widget _creaFormulario() {
    return Column(
      children: [
        _campoTexto(
            textController: _textCtrLectura1,
            titulo: 'Lectura 1',
            subTitulo: 'Introduzca la primera lectura',
            ),
        _campoTexto(
            textController: _textCtrLectura2,
            titulo: 'Lectura 2',
            subTitulo: 'Introduzca la segunda lectura',
            ),
      ],
    );
  }

  Widget _campoTexto(
      {
        TextEditingController textController,
        String titulo,
        String subTitulo,
      }) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[ ,-]')),],
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          controller: textController,
          decoration: InputDecoration(labelText: titulo, helperText: subTitulo),
          onChanged: (val) {
            // prefs.nombreUser = val;
            // double valor = double.parse(val).toDouble();
            int valor = int.parse(val).toInt();

            if( titulo == "Lectura 1"){
              //TODO: guardar Lectura 1
              calcCtr.lectura1.value = valor;
              calcCtr.calcular();
              print("lectura1 = ${calcCtr.lectura1.value.toString()} ");
            }
            else if( titulo == "Lectura 2"){
              //TODO: guardar lectura2
              calcCtr.lectura2.value = valor;
              calcCtr.calcular();
              print("lectura2 = ${calcCtr.lectura2.value.toString()} ");
            }
          },
        ),
        );   
  }

  Widget _crearBotonIMC() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.0),
      child: ElevatedButton.icon(
        // style: ButtonStyle(),
        icon: Icon(Icons.calculate),
        label: Text('Calcular'),
        onPressed: () {
          calcCtr.calcular();
        },
      ),
    );
  }



}