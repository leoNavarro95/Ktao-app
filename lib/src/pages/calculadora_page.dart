import 'package:flutter/material.dart';
import  'package:keyboard_actions/keyboard_actions.dart';
import 'package:preferencias_de_usuario/src/widgets/keyboard.dart';

import 'package:preferencias_de_usuario/src/shared_preferences/usuario_preferences.dart';
import 'package:preferencias_de_usuario/src/widgets/menu_lateral_widget.dart';

class CalculadoraPage extends StatefulWidget {
  static final String routeName = 'calculadora';

  @override
  _CalculadoraPageState createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  final prefs = new PreferenciasUsuario();

  final FocusNode _mynode = FocusNode();
  final mycustomNotifier = ValueNotifier<String>("0");
  
  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.blue[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _mynode,
          footerBuilder: (_) => CustumNumericKeyboard(
            notifier: mycustomNotifier,
          ),
        ),

      ],
    );
  }

  String _generoStr = 'masculino';
  int _genero   = 1;
  double _estatura = 0;
  double _peso     = 0;
  String _imc   = "0.0";


  // TextEditingController _textCtrEstatura, _textCtrPeso;
  final _textCtrEstatura = new TextEditingController();
  final _textCtrPeso = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      appBar: AppBar(
        title: Text('Calculadora'),
        backgroundColor:
            (prefs.colorSecundario) ? Colors.blueGrey : Colors.blue,
      ),
      body: _principal(),
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
        _seleccionGenero(),
        Divider(),
        _creaFormulario(),
        _crearBotonIMC(),
        Divider(),
        _resultadoIMC(),
        Divider(),
        _customInputField(),
        
      ],
    );
  }

Widget _customInputField(){
  return Container(
    height: 200,
    width: 200,
    child: KeyboardActions(
        // autoScroll: false,
        disableScroll: true,
        // tapOutsideToDismiss: true,
        config: _buildConfig(context),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                KeyboardCustomInput<String>(
                  focusNode: _mynode,
                  height: 65,
                  notifier: mycustomNotifier,
                  builder: (context, val, hasFocus) {
                    return Container(
                      alignment: Alignment.center,
                      color: hasFocus ? Colors.blue[200] : Colors.white,
                      child: Text(
                        val,
                        style: TextStyle(fontSize: 20),
                        //TODO: Tratar de usar un campo de texto TextField
                      ),
                    );
                  },
                ),
                
              ],
            ),
          ),
        ),
      ),
  );
}

  Widget _seleccionGenero() {
    return Container(
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Seleccione el género: $_generoStr'),
          RadioListTile(
            groupValue: _genero,
            value: 1,
            onChanged: _setSelectedRadio,
            title: Text('Masculino'),
          ),
          RadioListTile(
            groupValue: _genero,
            value: 2,
            onChanged:
                _setSelectedRadio, // no es necesario pasarle los argumentos porque los toma por defecto
            title: Text('Femenino'),
          ),
        ],
      ),
    );
  }

  _setSelectedRadio(int valor) {
    if (valor == 1)
      _generoStr = "masculino";
    else
      _generoStr = "femenino";

    _genero = valor;

    setState(() {}); //se renderiza el widget
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
          keyboardType: TextInputType.numberWithOptions(),
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
