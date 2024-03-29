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
    return myboolDialog(titulo: '¿Desea cerrar la app?', subtitulo: ' ');
  }

  Widget _pageContent(CalculadoraController calcCtr) {
    return ListView(
      children: <Widget>[_title(), _formulario(), _calcResults(), _tabla()],
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

  Widget _formulario() {
    return Obx(() => Container(
          padding: EdgeInsets.all(10),
          color: Get.theme.cardColor,
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
            CampoTextoCalculadora(titulo: "Lectura 1"),
            CampoTextoCalculadora(titulo: "Lectura 2")
          ]
        : [CampoTextoCalculadora(titulo: "Consumo")];
  }

  Container _calcResults() {
    return Container(
      color: Get.theme.disabledColor,
      child: Obx(
        () => Text(
          "${calcCtr.consumo.value} kWh \n${calcCtr.costo.value.toStringAsFixed(2)} CUP",
          style: TemaTexto().tituloTarjeta,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _tabla() {
    return Obx(() => calcCtr.listConsumo.isNotEmpty
        ? Tabla(
            titleRow: ['Rango', 'Consumo', 'Precio', 'Importe'],
            titleColor: Get.theme.accentColor,
            primaryColor: Get.theme.primaryColor,
            secundaryColor: Get.theme.disabledColor,
            cuerpo: [
              rangos, //rango
              calcCtr.listConsumo, //consumo
              precios, //precios por rango
              calcCtr.listPrecio, //importe
            ],
          )
        : Container());
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
    return isExpanded
        ? Icon(Icons.expand_less)
        : Icon(Icons.expand_more);
  }
}
