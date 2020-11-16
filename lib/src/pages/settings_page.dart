import 'package:flutter/material.dart';
import 'package:preferencias_de_usuario/src/shared_preferences/usuario_preferences.dart';
import 'package:preferencias_de_usuario/src/widgets/menu_lateral_widget.dart';



class SettingsPage extends StatefulWidget {
  
  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final prefs = new PreferenciasUsuario();

  bool _colorSecundario;
  int _genero;
  String _nombre;

  TextEditingController _controller;

  /*
   * initState() se ejecuta justo antes que el build() 
   */
  @override
  void initState() {
    
    super.initState();
    prefs.ultimaPagina = SettingsPage.routeName;

    _genero          = prefs.genero;
    _colorSecundario = prefs.colorSecundario;
    _nombre          = prefs.nombreUser;

    
    _controller = new TextEditingController( text: _nombre );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      
      appBar: AppBar(
        title: Text('Configuración'),
        backgroundColor: (prefs.colorSecundario) ? Colors.blueGrey : Colors.blue,
      ),

      body: _crearConfig(),
      
    );
  }

  Widget _crearConfig() {
    return ListView(
      padding: EdgeInsets.all( 10.0 ),
      children: <Widget>[
        Text('Parámetros:',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
        
        Divider(),

        CheckboxListTile(
          value: _colorSecundario,
          onChanged: ( val ) {
            _colorSecundario = val;
            prefs.colorSecundario = _colorSecundario;
            setState((){});
          },
          title: Text('Color secundario'),
        ),
        
        RadioListTile(
          groupValue: _genero,
          value: 1,
          onChanged: _setSelectedRadio,
          title: Text('Masculino'),
        ),

        RadioListTile(
          groupValue: _genero,
          value: 2,
          onChanged: _setSelectedRadio, // no es necesario pasarle los argumentos porque los toma por defecto
          title: Text('Femenino'),
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Nombre',
              helperText: 'INtroduzca su nombre'
            ),
            onChanged: ( val ) {
              prefs.nombreUser = val;

            } ,

            ),
          )
        
      ],
    );
  }

  _setSelectedRadio ( int valor ) {
    
    
    prefs.genero = valor; //se usa el setter declarado en PreferenciasUsuario

    _genero = valor;
    setState(() {});//se renderiza el widget
  }
}