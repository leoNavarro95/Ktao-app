import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'package:healthCalc/src/controllers/reactive_controller.dart';
import 'package:healthCalc/src/widgets/menu_lateral_widget.dart';

class GetReactivePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      
      return GetBuilder <ReactiveController>(
        init: ReactiveController(),
        builder: (_){
          return Scaffold(
        drawer: MenuLateral(),
        appBar: AppBar(
          title: Text('Reactive page with Get'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx((){
                print('counter');
                return Text(_.counter.value.toString());
            }),
              Obx((){
                print('date');
                return Text(_.date.value);
            })
            ], 
            ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'Increment',
              child: Icon(Icons.add),
              onPressed: ()=>_.increment()
              ),

              SizedBox(width: 10),

            FloatingActionButton(
              heroTag: 'GetDate',
              child: Icon(Icons.calendar_today_outlined),
              onPressed: ()=>_.getDate()
          ),
          ],
        ),
      );
        }
        );

  }

}