import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthCalc/app/data/model/contador_model.dart';
import 'package:healthCalc/app/data/provider/data_base_provider.dart';
import 'package:healthCalc/app/modules/detalles/local_widgets/tarjeta_mes.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura.dart';
import 'package:healthCalc/app/theme/text_theme.dart';

import 'detalles_controller.dart';

class DetallesPage extends GetView<DetallesController> {
  final ContadorModel contador;
  DetallesPage({@required this.contador}) : assert(contador != null);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GetBuilder<DetallesController>(
      init: DetallesController(contador: contador),
      builder: (_) {
        return FutureBuilder(
          future: _.updateVisualFromDB(),
          // initialData: InitialData,
          builder:
              (BuildContext context, AsyncSnapshot<List<TarjetaMes>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                    child: Text(
                  'Cargando...',
                  style: TemaTexto().titulo,
                )),
              );
            }

            final tarjetas = snapshot.data;
            if (tarjetas.isEmpty) return TarjetaLectura();

            return ListView.builder(
                itemCount: tarjetas.length,
                itemBuilder: (context, index) {
                  return tarjetas[index];
                });
          },
        );
      },
    ));
  }
}
