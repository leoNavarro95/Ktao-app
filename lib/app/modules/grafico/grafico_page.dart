import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthCalc/app/global_widgets/ktao_graph/ktao_graph_widget.dart';
import 'package:healthCalc/app/modules/grafico/grafico_controller.dart';

class GraficoPage extends GetView<GraficoController> {
  final Map<String, List<double>> lectXmes; // tasaConsumo [(delta-kWh)/dia]

  GraficoPage({
    this.lectXmes
  }): assert (lectXmes != null);
  @override
  Widget build(BuildContext context) {

    return Container(
      child: GetBuilder<GraficoController>(
          init: GraficoController(),
          builder: (_) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: KTaoGraph( lectXmes: lectXmes, ),
              ),
            );
          }),
    );
  }
}
