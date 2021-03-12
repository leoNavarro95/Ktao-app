import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ktao/app/global_widgets/ktao_graph/ktao_graph_widget.dart';
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
            Text(
              'Tasa de consumo (poner helper)',
              textAlign: TextAlign.center,
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
