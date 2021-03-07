

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
// import 'package:ktao/app/global_widgets/menu_lateral.dart';
import 'package:ktao/app/modules/detail/detail_controller.dart';

import 'local_widgets/my_widgets.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(builder: (_){
      return Scaffold(
        
        body: Stack(
          children: <Widget>[
            fondoApp(),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  titulo(),
                  botonera()
                ],
              ),
              ),
        ],
        ),

      bottomNavigationBar: bottomNavBar(context),

    );
    });
  }
}