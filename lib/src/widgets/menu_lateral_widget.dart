import 'package:flutter/material.dart';
import 'package:preferencias_de_usuario/src/pages/calculadora_page.dart';
import 'package:preferencias_de_usuario/src/pages/getx_page.dart';
import 'package:preferencias_de_usuario/src/pages/home_page.dart';
import 'package:preferencias_de_usuario/src/pages/settings_page.dart';

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
                Navigator.pushReplacementNamed(context, HomePage.routeName);
              },

            ),


            ListTile(
              leading: Icon(Icons.calculate, color: Colors.blue,),
              title: Text('Calculadora'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue,),
              onTap: () {
                Navigator.pushReplacementNamed(context, CalculadorasMainPage.routeName);
              },

            ),


            ListTile(
              leading: Icon(Icons.settings, color: Colors.blue,),
              title: Text('Configuración'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue,),
              onTap: (){
                // Navigator.pop(context); //permite cerrar el menu de navegacion vertical
                Navigator.pushReplacementNamed(context, SettingsPage.routeName);
              } 
            ),

            ListTile(
              leading: Icon(Icons.gradient, color: Colors.blue,),
              title: Text('GetX tests'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue,),
              onTap: (){
                // Navigator.pop(context); //permite cerrar el menu de navegacion vertical
                Navigator.pushReplacementNamed(context, 'GetX');
              } 
            ),

        ],
        ),
    );
  }
}