import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:healthCalc/app/global_widgets/menu_lateral.dart';

import 'package:healthCalc/app/modules/home/home_controller.dart';

import 'local_widgets/tarjeta_contador.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeController>(builder: (_){
      return Scaffold(
        drawer: MenuLateral(),
        appBar: AppBar(title: Text('Inicio'), centerTitle: true,),
        body: Tarjeta()
        );
    });
  }
}

