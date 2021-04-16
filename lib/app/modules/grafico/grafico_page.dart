import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ktao/app/global_widgets/ktao_graph/ktao_graph_widget.dart';
import 'package:ktao/app/global_widgets/widgets.dart';
import 'package:ktao/app/modules/grafico/grafico_controller.dart';
import 'package:ktao/app/utils/lecturas_utils.dart';
import 'package:ktao/app/utils/math_util.dart';

class GraficoPage extends GetView<GraficoController> {
  // final Map<String, List<double>> lectXmes; // tasaConsumo [(delta-kWh)/dia]
  // GraficoPage({this.lectXmes}) : assert(lectXmes != null);

  @override
  Widget build(BuildContext context) {
    final graficoCtr = Get.put(GraficoController());
    final List<double> _tasasConsumo = utilGetTasasConsumo(graficoCtr.lectOrd);

    bool _hasNegativeData = utilHasNegativeData(_tasasConsumo);

    final _grafico = new KTaoGraph(
      lectXmes: graficoCtr.lecturasXmes,
      tasasConsumo: _tasasConsumo,
      bkgColor: Color(0xb590d4fe),
      hasLabelOnYaxis: true,
      hasNegativeData: _hasNegativeData,
    );

    return Container(
      margin: EdgeInsets.only(top: 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            myroundedContainer(
              text: Text('Tasa de consumo'),
              icon: Icons.info_outline,
              onTap: () async {
                return await dialogInfo(
                  icon: Icons.info_outline,
                  titulo: 'Tasa de consumo',
                  subtitulo: 'La tasa de consumo es la variación del consumo eléctrico por días, lo que permite conocer cuánto está consumiendo su vivienda con respecto al paso del tiempo en días. Por ejemplo, si su casa ha consumido 100kWh en 5 días, la tasa de consumo sería de 100/5 kWh/día lo que daría como resultado 20 kWh/día'
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _grafico,
            ),
          ],
        ),
      ),
    );
  }
}
