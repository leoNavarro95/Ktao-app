

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (_){
      return Scaffold(
        body: Center(child: Text("Splash page")),
      );
    });
  }
}