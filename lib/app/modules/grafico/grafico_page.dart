import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ktao/app/global_widgets/ktao_graph/ktao_graph_widget.dart';
import 'package:ktao/app/modules/grafico/grafico_controller.dart';
import 'package:ktao/app/utils/lecturas_utils.dart';

class GraficoPage extends GetView<GraficoController> {
  final Map<String, List<double>> lectXmes; // tasaConsumo [(delta-kWh)/dia]
  GraficoPage({this.lectXmes}) : assert(lectXmes != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<GraficoController>(
          init: GraficoController(),
          builder: (_) {
            return Container(
              margin: EdgeInsets.only(top: 50),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: KTaoGraph(
                  lectXmes: lectXmes,
                  tasasConsumo: utilGetTasasConsumo(_.lectOrd),  //! cambiar aqui tasaConsumo por la instancia de lecturaController.tasaConsumo
                ),
              ),
            );
          }),
    );
  }
}
