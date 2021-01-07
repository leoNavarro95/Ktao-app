import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

import 'package:healthCalc/app/data/provider/data_base_provider.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/lecturas_form_widget.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura.dart';
import 'package:healthCalc/app/theme/text_theme.dart';

import 'lectura_controller.dart';

class LecturaPage extends GetView<LecturaController> {
  final lecturaCtr = Get.find<LecturaController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LecturaController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Lecturas del contador'),
        ),
        body: _contenido(),
      );
    });
  }

  Widget _contenido() {
    final ContadorModel contador = lecturaCtr.contador;

    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: FadeInLeft(
                delay: Duration(milliseconds: 500),
                child: _headerContadorName(contador)),
          ),
          LecturaForm(
            // height: 0.3 * Get.height, //el 20% del alto de la pantalla
            width: Get.width, //el ancho completo de la pantalla
            formKey: formKey,
            contador: contador,
            lectCtr: lecturaCtr,
          ),
          Expanded(
            child: _listaLecturas(contador),
          ),
        ],
      ),
    );
  }

  Widget _headerContadorName(ContadorModel contador) {
    return Container(
      padding: EdgeInsets.only(top: 0),
      width: 0.7 * Get.width,
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(0),
        color: Colors.blue[300],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
        child: Text('${contador.nombre}',
            textAlign: TextAlign.center, style: TemaTexto().tituloTarjeta),
      ),
    );
  }

  Widget _listaLecturas(ContadorModel contador) {
    return Obx(() {
      if (lecturaCtr.tarjetasLect.isNotEmpty) {
        return ListView(
          children: lecturaCtr.tarjetasLect,
        );
      }
      return TarjetaLectura(); //sin parametro ya devuelve que no tiene nada
    });
  }
}
