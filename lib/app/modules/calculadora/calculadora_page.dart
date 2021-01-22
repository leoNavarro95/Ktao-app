import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthCalc/app/global_widgets/menu_lateral.dart';
import 'package:healthCalc/app/modules/calculadora/calculadora_controller.dart';
import 'package:healthCalc/app/modules/calculadora/local_widgets/campo_texto.dart';
import 'package:healthCalc/app/modules/calculadora/local_widgets/tabla_widget.dart';
import 'package:healthCalc/app/theme/text_theme.dart';
import 'package:healthCalc/app/utils/math_util.dart';

class CalculadoraPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final calcCtr = Get.find<CalculadoraController>();

    return GetBuilder<CalculadoraController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora'),
        ),
        drawer: MenuLateral(),
        body: Center(child: _principal(calcCtr)),
      );
    });
  }

  Widget _principal(CalculadoraController calcCtr) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          'Calcula el costo en CUP',
          textAlign: TextAlign.center,
          style: TemaTexto().titulo,
        ),
        Divider(),
        _creaFormulario(calcCtr),
        Container(
          color: Color.fromRGBO(10, 100, 180, 0.4),
          child: Obx(
            () => Text(
              "${calcCtr.consumo.value} kWh \n${calcCtr.costo.value.toStringAsFixed(2)} CUP",
              style: TemaTexto().tituloTarjeta,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Obx(() {
          if (calcCtr.lectura1.value != null) {
            return Tabla(
              titleRow: ['Rango', 'Consumo', 'Precio', 'Importe'],
              titleColor: Color.fromRGBO(120, 200, 220, 1),
              primaryColor: Color.fromRGBO(0, 180, 210, 0.7),
              secundaryColor: Color.fromRGBO(10, 100, 180, 0.3),
              cuerpo: [
                rangos, //rango
                calcCtr.listConsumo, //consumo
                precios, //precios por rango
                calcCtr.listPrecio, //importe
              ],
            );
          }
          return Container();
        }),
      ],
    );
  }

  Widget _creaFormulario(CalculadoraController calcCtr) {
    List<Widget> campoTexto = [];
    return Obx(() {
      if (calcCtr.expanded.value) {
        campoTexto = [
          CampoTextoCalculadora(
              textController: calcCtr.textCtrLectura1,
              titulo: "Lectura 1",
              calcCtr: calcCtr),
          SizedBox(height: 10),
          CampoTextoCalculadora(
              textController: calcCtr.textCtrLectura2,
              titulo: "Lectura 2",
              calcCtr: calcCtr),
          
        ];
      } else {
        campoTexto = [
          CampoTextoCalculadora(
              textController: calcCtr.textCtrLectura1,
              titulo: "Consumo",
              calcCtr: calcCtr),
          
        ];
      }

      return Container(
        padding: EdgeInsets.all(10),
        color: Colors.blue[100],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: campoTexto,
            ),
            _changeMultiLectura(calcCtr),
          ],
        ),
      );
    });
  }

  Widget _changeMultiLectura(CalculadoraController calcCtr) {
    IconData myIcon = Icons.expand_more;
    return Obx(() {
      if (calcCtr.expanded.value) {
        myIcon = Icons.expand_less;
      } else {
        myIcon = Icons.expand_more;
      }

      return Column(
        children: [
          SizedBox(height: 15),
          IconButton(
            icon: Icon(
              myIcon,
              color: Colors.black38,
            ),
            iconSize: 40,
            onPressed: () {
              calcCtr.expand();
            },
          ),
        ],
      );
    });
  }
}
