

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:healthCalc/app/modules/detail/detail_controller.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(builder: (_){
      return Scaffold(body: Text("Detail Page"),);
    });
  }
}