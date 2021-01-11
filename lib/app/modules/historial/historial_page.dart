import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'historial_controller.dart';

class HistorialPage extends GetView<HistorialController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GetBuilder<HistorialController>(
      init: HistorialController(),
      builder: (_) {
        return Container(
          child: Text('Hola loco'),
        );
      },
    ));
  }
}
