import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ktao/app/global_widgets/menu_lateral.dart';
import 'package:ktao/app/global_widgets/widgets.dart';
import 'package:ktao/app/modules/calculadora/calculadora_controller.dart';
import 'package:ktao/app/modules/calculadora/local_widgets/campo_texto.dart';
import 'package:ktao/app/modules/calculadora/local_widgets/tabla_widget.dart';
import 'package:ktao/app/theme/text_theme.dart';
import 'package:ktao/app/utils/math_util.dart';

class CalculadoraPage extends StatelessWidget {
  final calcCtr = Get.find<CalculadoraController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Calculadora'),
        ),
        drawer: MenuLateral(),
        body: _pageContent(calcCtr),
      ),
    );
  }

  /// onWillPop es un callBack que se ejecuta cuando se desea cerrar la pantalla
  Future<bool> onWillPop() {
    return myboolDialog(
      titulo: '¿Desea cerrar la app?',
      subtitulo: ' '
    );
  }

  Widget _pageContent(CalculadoraController calcCtr) {
    return ListView(
      children: <Widget>[
        _title(),
        _formulario(),
        _calcResults(),
        Obx(() => (calcCtr.lectura1.value != null) ? _tabla() : Container()),
      ],
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text('Calcula el costo en CUP',
              textAlign: TextAlign.center, style: TemaTexto().titulo),
          Divider(),
        ],
      ),
    );
  }

  //! TODO: BUG: solo actualiza la tabla los cambios en el campo lectura 1, campo lectura 2 cuando es editado no hace que cambie la tabla
  Widget _formulario() {
    return Obx(() => Container(
          padding: EdgeInsets.all(10),
          color: Colors.blue[100],
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: getCampoTexto(calcCtr.expanded.value),
              ),
              _buttonExpandLecturas()
            ],
          ),
        ));
  }

  List<CampoTextoCalculadora> getCampoTexto(bool isExpanded) {
    return isExpanded
        ? [
            CampoTextoCalculadora(
                textController: calcCtr.textCtrLectura1,
                titulo: "Lectura 1",
                calcCtr: calcCtr),
            CampoTextoCalculadora(
                textController: calcCtr.textCtrLectura2,
                titulo: "Lectura 2",
                calcCtr: calcCtr),
          ]
        : [
            CampoTextoCalculadora(
                textController: calcCtr.textCtrLectura1,
                titulo: "Consumo",
                calcCtr: calcCtr),
          ];
  }

  Container _calcResults() {
    return Container(
      color: Color.fromRGBO(10, 100, 180, 0.4),
      child: Obx(
        () => Text(
          "${calcCtr.consumo.value} kWh \n${calcCtr.costo.value.toStringAsFixed(2)} CUP",
          style: TemaTexto().tituloTarjeta,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Tabla _tabla() {
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

  Widget _buttonExpandLecturas() {
    return Obx(() => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: IconButton(
                icon: getExpandIcon(calcCtr.expanded.value),
                iconSize: 40,
                onPressed: calcCtr.expand,
              ),
            ),
          ],
        ));
  }

  Icon getExpandIcon(bool isExpanded) {
    const iconColor = Colors.black38;
    return isExpanded
        ? Icon(Icons.expand_less, color: iconColor)
        : Icon(Icons.expand_more, color: iconColor);
  }
}
