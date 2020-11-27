import 'package:flutter/material.dart';
import 'package:preferencias_de_usuario/src/pages/getx_page.dart';

import 'package:preferencias_de_usuario/src/pages/home_page.dart';
import 'package:preferencias_de_usuario/src/pages/settings_page.dart';
import 'package:preferencias_de_usuario/src/shared_preferences/usuario_preferences.dart';
import 'package:preferencias_de_usuario/src/pages/calculadora_page.dart';


void main() async{
  /**
   * como está implementado el patrón Singleton, esta instancia prefs va a ser la misma en 
   * todo el programa. Esto permite hacer que la app antes de iniciarse, espere a crear la 
   * instancia y inicializarla. Recordar que prefs es para usar almacenamiento persistente 
   * en nuestra app
   */
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  //no importa repetir esta instancia, como es un Singleton nos devuelve la misma instancia anterior sin llamar a una nueva
  final prefs = new PreferenciasUsuario();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Preferencias de Usuario',

      routes: {

        HomePage.routeName             : ( BuildContext context ) => HomePage(),
        SettingsPage.routeName         : ( BuildContext context ) => SettingsPage(),
        CalculadorasMainPage.routeName : ( BuildContext context ) => CalculadorasMainPage(),
        GetxPage.routeName             : ( BuildContext context ) => GetxPage(),
        
      },

      initialRoute: prefs.ultimaPagina,

      
    );
  }
}
