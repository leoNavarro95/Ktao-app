import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthCalc/app/data/model/contador_model.dart';
import 'package:healthCalc/app/data/model/lectura_model.dart';
import 'package:healthCalc/app/data/provider/data_base_provider.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura.dart';

import 'historial_controller.dart';
import 'local_widgets/tarjeta_mes.dart';

class HistorialPage extends GetView<HistorialController> {
  final ContadorModel contador;
  HistorialPage({@required this.contador}) : assert(contador != null);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GetBuilder<HistorialController>(
      init: HistorialController(contador: contador),
      builder: (_) {
        return Obx(() {
          if (_.tarjetasMes.isNotEmpty) {
            return ListView.builder(
                itemCount: _.tarjetasMes.length,
                itemBuilder: (context, index) {
                  return _.tarjetasMes[index];
                });
          }
          return TarjetaLectura(); //sin parametros ya indica que no existen lecturas
        });
      },
    ));
  }
}
