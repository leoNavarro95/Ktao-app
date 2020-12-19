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
        body: Column(
          children: [
            reactiveWidget(_),
            // SizedBox(height: 20),
            Expanded(
              child: listaElementos(_),
            ),
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'Increment',
              
              child: Icon(Icons.add),

              onPressed: (){
                _.increment();
                _.getDate();
                _.addItem(_.date.value);
                }
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


  Widget reactiveWidget(ReactiveController _){
    return Container(
      // color: Colors.blueGrey,
      child: Column(
        
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Obx((){
            print('counter');
            return roundedBox(text: _.counter.value.toString(), bkgColor: Colors.blue[200]);
        }),
            SizedBox(width: 5),
            Obx((){
              print('date');
              return roundedBox(text: _.date.value.substring(0,19), bkgColor: Colors.blue[200]);
          }),

          ],
          ),
          SizedBox(height: 5),
          Divider(height: 2,thickness: 2,),
        ], 
        ),
    );
  }


  Widget roundedBox({String text, Color bkgColor}){
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.all(5),
        color: bkgColor,
        child: Text(text),
      )
    );
  }
  
  Widget listaElementos(ReactiveController _){

    return Obx(
      ()=> ListView.builder(
      itemCount: _.items.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 45),
              roundedBox(text: index.toString(), bkgColor: Colors.blue[100]),
              SizedBox(width: 5),
              roundedBox(text: _.items[index].substring(0,19), 
              bkgColor: Colors.blue[100]),
            ],
          ),
          trailing: Container(
            width: 40,
            height: 40,
            padding: EdgeInsets.all(0),
            // color: Colors.green,
            child: IconButton(
              icon: Icon(Icons.delete_outline,color: Colors.blueAccent,),
              onPressed: (){
                _.removeItem(index);
              }
              ),
          ),
        );
      }
      )
      );

  }

}