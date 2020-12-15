import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/route_manager.dart';

import 'package:healthCalc/src/controllers/home_controller.dart';
import 'package:healthCalc/src/pages/getx_widgets/home_list.dart';
import 'package:healthCalc/src/pages/getx_widgets/products_list.dart';
import 'package:healthCalc/src/widgets/menu_lateral_widget.dart';

//esta vista va a ser para aprender a usar GetX como gestor

class GetxPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return GetBuilder <HomeController>(
      init: HomeController(), //la clase donde está definido el controlador de estado
      builder: (_) {

        print('renderizado home');
        return Scaffold(
        drawer: MenuLateral(),
        appBar: AppBar(
          title: Text('GetX ejemplo'),
          // backgroundColor: (prefs.colorSecundario) ? Colors.blueGrey : Colors.blue,
        ),
        body: HomeList(),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.shopping_cart),
          onPressed: (){
            // _.increment();
            Get.to(ProductList());
          },
        ),
      );
      } 
    );
  }
}
