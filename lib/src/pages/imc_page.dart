import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:preferencias_de_usuario/src/shared_preferences/usuario_preferences.dart';


class CalculadoraPage extends StatefulWidget {
  static final String routeName = 'calculadora';

  @override
  _CalculadoraPageState createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {

  @override
  void initState(){
    prefs.ultimaPagina = CalculadoraPage.routeName;
    super.initState();
  }

  final prefs = new PreferenciasUsuario();

  double _estatura = 0;
  double _peso     = 0;
  String _imc   = "0.0";


  // TextEditingController _textCtrEstatura, _textCtrPeso;
  final _textCtrEstatura = new TextEditingController();
  final _textCtrPeso = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Center(
      
      child: _principal(),
    );
  }


  Widget _principal() {
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        Text(
          'Índice de masa corporal',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Divider(),
        _creaFormulario(),
        _crearBotonIMC(),
        Divider(),
        _resultadoIMC(),
        Divider(),
        
      ],
    );
  }

  Widget _creaFormulario() {
    return Column(
      children: [
        _campoTexto(
            textController: _textCtrEstatura,
            titulo: 'Estatura',
            subTitulo: 'Introduzca la estatura (m)',
            ),
        _campoTexto(
            textController: _textCtrPeso,
            titulo: 'Peso',
            subTitulo: 'Introduzca el peso (Kg)',
            ),
      ],
    );
  }

  Widget _campoTexto(
      {TextEditingController textController,
      String titulo,
      String subTitulo,
      }) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[ ,-]')),],
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          controller: textController,
          decoration: InputDecoration(labelText: titulo, helperText: subTitulo),
          onChanged: (val) {
            // prefs.nombreUser = val;
            double valor = double.parse(val).toDouble();

            //TODO: trabajar con el error en caso de introducir en el campo valores que anulen la conversion

            if( titulo == "Peso"){
              _peso = valor;
            }
            else if( titulo == "Estatura"){
              _estatura = valor;
            }
          },
        ));
  }

  Widget _crearBotonIMC() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.0),
      child: ElevatedButton.icon(
        // style: ButtonStyle(),
        icon: Icon(Icons.calculate),
        label: Text('Calcular IMC'),
        onPressed: () {
          setState(() {
            _imc = (_peso / (_estatura * _estatura)).toDouble().toStringAsFixed(2);
          });
        },
      ),
    );
  }

  Widget _resultadoIMC() {
    return Container(
      
        child: Text(
      'IMC: $_imc',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30,
      ),
    ));
  }

 

}
