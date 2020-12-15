import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preferencias_de_usuario/src/shared_preferences/usuario_preferences.dart';
import 'package:preferencias_de_usuario/src/widgets/menu_lateral_widget.dart';

class HomePage extends StatefulWidget {
  
  static final String routeName = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final prefs = new PreferenciasUsuario();
  
  @override
  void initState(){
    prefs.ultimaPagina = HomePage.routeName;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /**
       * el drawer nos permite crear y controlar una barra lateral izquierda como navBar 
       * vertical
       */
      drawer: MenuLateral(),

      appBar: AppBar(
        title: Text('Inicio'),
        backgroundColor: (prefs.colorSecundario) ? Colors.blueGrey : Colors.blue,
        
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: <Widget>[
            Text('Color secundario: ${prefs.colorSecundario}'),
            Divider(),
            Text('Genero: ${prefs.genero}'),
            Divider(),
            Text('Nombre de usuario: ${prefs.nombreUser}'),
            Divider(),
          ],
          ),
      ),
    );
  }
}