import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:preferencias_de_usuario/src/controllers/home_controller.dart';

class TextHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<HomeController>(
          id: 'texto',
          builder: (_) {
            print('renderizado texto');
            return Text(_.counter.toString());
          }),
    );
  }
}
