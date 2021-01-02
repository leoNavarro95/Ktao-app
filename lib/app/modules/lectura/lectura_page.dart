
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'lectura_controller.dart';

class LecturaPage extends GetView<LecturaController> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: Text('LecturaPage')),

    body: Container(
      child: GetX<LecturaController>(
        init: LecturaController(),
        builder: (_){
          return Container();
        }),
      ),
    );
  }
}