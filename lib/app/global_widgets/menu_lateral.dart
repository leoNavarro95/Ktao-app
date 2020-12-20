import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthCalc/app/routes/app_routes.dart';



class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/menu-img.jpg',),
                fit: BoxFit.cover
                ),
              
            ),
            ),
            
            ListTile(
              leading: Icon(Icons.home, color: Colors.blue,),
              title: Text('Inicio'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue,),
              onTap: () {
                // Navigator.pushReplacementNamed(context, HomePage.routeName);
                // Get.offNamed(AppRoutes.HOME);
                Get.toNamed(AppRoutes.HOME);
              },

            ),


            ListTile(
              leading: Icon(Icons.info, color: Colors.blue,),
              title: Text('Detalles'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue,),
              onTap: () {
                // Navigator.pushReplacementNamed(context, CalculadorasMainPage.routeName);
                // Get.offNamed(AppRoutes.DETAIL);
                Get.back();
                Get.toNamed(AppRoutes.DETAIL);
              },

            ),

        ],
        ),
    );
  }
}

