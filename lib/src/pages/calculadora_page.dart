import 'package:flutter/material.dart';
import 'package:preferencias_de_usuario/src/pages/imc_page.dart';

import 'package:preferencias_de_usuario/src/shared_preferences/usuario_preferences.dart';
import 'package:preferencias_de_usuario/src/widgets/menu_lateral_widget.dart';

import 'area_superf_page.dart';

class CalculadorasMainPage extends StatefulWidget {
  static final String routeName = 'calculadora';

  @override
  _CalculadorasMainPageState createState() => _CalculadorasMainPageState();
}

class _CalculadorasMainPageState extends State<CalculadorasMainPage> {
  @override
  void initState() {
    prefs.ultimaPagina = CalculadorasMainPage.routeName;
    super.initState();
  }

  final prefs = new PreferenciasUsuario();

  int _pageIndex =
      0; //esta variable es el indice de cada pagina de cálculo, se controla por medio del bottomNavigationBar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      appBar: AppBar(
        title: Text('Calculadora'),
        backgroundColor:
            (prefs.colorSecundario) ? Colors.blueGrey : Colors.blue,
      ),
      body: _pagina(_pageIndex),
      bottomNavigationBar: _crearBottomNavBar(),
    );
  }

  Widget _pagina(int index) {
    switch (index) {
      case 0:
        return CalculadoraIMCPage();
      case 1:
        return AreaSupPage();
      default:
        return CalculadoraIMCPage();
    }
  }

  Widget _crearBottomNavBar() {
    return BottomNavigationBar(
        elevation: 20.0,
        backgroundColor: (prefs.colorSecundario) ? Colors.blueGrey : Colors.blue[100],
        iconSize: 40.0,
        currentIndex: _pageIndex,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(label: 'IMC', icon: Icon(Icons.handyman)),
          BottomNavigationBarItem(label: 'IMS', icon: Icon(Icons.backup)),
          BottomNavigationBarItem(label: 'ITR', icon: Icon(Icons.healing)),
        ]);
  }

  // de momento no se emplea este método, en un futuro se usará
  // Widget _seleccionGenero() {
  //   return Container(
  //     color: Colors.grey[200],
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text('Seleccione el género: $_generoStr'),
  //         RadioListTile(
  //           groupValue: _genero,
  //           value: 1,
  //           onChanged: _setSelectedRadio,
  //           title: Text('Masculino'),
  //         ),
  //         RadioListTile(
  //           groupValue: _genero,
  //           value: 2,
  //           onChanged:
  //               _setSelectedRadio, // no es necesario pasarle los argumentos porque los toma por defecto
  //           title: Text('Femenino'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // _setSelectedRadio(int valor) {
  //   if (valor == 1)
  //     _generoStr = "masculino";
  //   else
  //     _generoStr = "femenino";

  //   _genero = valor;

  //   setState(() {}); //se renderiza el widget
  // }

}
