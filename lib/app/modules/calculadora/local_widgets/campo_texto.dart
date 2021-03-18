import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ktao/app/modules/calculadora/calculadora_controller.dart';

class CampoTextoCalculadora extends StatelessWidget {
  final String titulo;
  CampoTextoCalculadora({@required this.titulo});

  final CalculadoraController calcCtr = Get.find<CalculadoraController>();

  @override
  Widget build(BuildContext context) {
    return buildTextField();
  }

  Container buildTextField() {
    return Container(
      width: Get.width * 0.4,
      child: TextField(
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[ .,-]'))],
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        controller: getTextControler(this.titulo),
        decoration:
            InputDecoration(icon: Icon(Icons.flash_on), labelText: titulo),
        onChanged: onTextFieldChanged,
      ),
    );
  }

  void onTextFieldChanged(String val) {
    int valor = val.isNotEmpty ? int.parse(val).toInt() : 0;
    if ((titulo == "Lectura 1") || (titulo == "Consumo")) {
      calcCtr.lectura1.value = valor;
    } else {
      calcCtr.lectura2.value = valor;
    }
    calcCtr.calcular();
  }

  TextEditingController getTextControler(String titulo) {
    switch (titulo) {
      case "Lectura 1":
        return calcCtr.textCtrLectura1;
      case "Lectura 2":
        return calcCtr.textCtrLectura2;
    }
    return calcCtr.textCtrLectura1;
  }
}