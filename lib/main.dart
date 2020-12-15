import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthCalc/src/pages/home_page.dart';
import 'package:healthCalc/src/pages/settings_page.dart';
import 'package:healthCalc/src/shared_preferences/usuario_preferences.dart';
import 'package:healthCalc/src/pages/calculadora_page.dart';
import 'package:healthCalc/src/pages/splash_page.dart';
import 'package:healthCalc/src/controllers/global_controller.dart';
import 'package:healthCalc/src/pages/getx_reactive_page.dart';

void main() async{
  /**
   * !como está implementado el patrón Singleton, esta instancia prefs va a ser la misma en 
   * !todo el programa. Esto permite hacer que la app antes de iniciarse, espere a crear la 
   * !instancia y inicializarla. Recordar que prefs es para usar almacenamiento persistente 
   * !en nuestra app
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
    
    // aquí se define el controlador global de la app a traves de Getx
    Get.put(GlobalController()); //esto permite usar este controlador desde cualquier parte del codigo sin necesidad de hacer init etc..

    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Health Calculator',

      routes: {

        HomePage.routeName             : ( BuildContext context ) => HomePage(),
        SettingsPage.routeName         : ( BuildContext context ) => SettingsPage(),
        CalculadorasMainPage.routeName : ( BuildContext context ) => CalculadorasMainPage(),
        'GetX'                         : ( BuildContext context ) => SplashPage(),
        'GetReactive'                  : ( BuildContext context ) => GetReactivePage(),
      },

      initialRoute: prefs.ultimaPagina,

      
    );
  }
}
