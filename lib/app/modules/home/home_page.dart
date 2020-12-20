import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'package:healthCalc/app/modules/home/home_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeController>(builder: (_){
      return Scaffold(body: Text("Home page"));
    });
  }
}