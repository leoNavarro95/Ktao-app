
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tabla extends StatelessWidget {

  final List<String> titleRow;
  final Color titleColor;
  final Color primaryColor, secundaryColor;

  final List<List<dynamic>> cuerpo;

  
  const Tabla(
    { 
      @required this.titleRow, 
      this.titleColor     = Colors.blueGrey,  
      this.primaryColor   = Colors.grey, 
      this.secundaryColor = Colors.blueGrey, 
      this.cuerpo,

    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: Table(
        columnWidths: {0:FractionColumnWidth(0.3)},
        children: body(cuerpo)
      ),
    );
  }

 
  

  List<TableRow> body(List<List<dynamic>> cuerpo){
    
    List<Loza> _row = []; //children de los TableRow
    List<TableRow> tabla = [];
    Color _color;
    
    //* TitleRow, el titulo da la tabla
          tabla.add(TableRow(
            children: titleRow.map((e) => Loza( color: titleColor, text: e,),).toList()
          ));

    //? se toma como referencia del tamanho de la tabla a cuerpo[0], primera fila
    for (int i = 0; i < (cuerpo[0]).length ; i++){
      for(int j = 0; j < cuerpo.length; j++){

        if((i % 2) == 0){
          _color = primaryColor;
        } else{
          _color = secundaryColor;
        }

        //* si la casilla posee datos
        if(i < cuerpo[j].length){
          String _titulo;
          // si no es un numero, no se hace la conversion
          if(num.tryParse(cuerpo[j][i].toString()) == null){
            _titulo = cuerpo[j][i];
          } else {
            _titulo = cuerpo[j][i].toStringAsFixed(2);
          }
          _row.add(Loza( color: _color, text: _titulo));
        }
        //* de lo contrario la Loza se llena con un string vacio 
        else {
          _row.add(Loza( color: _color, text: " "));
        }

      }
      tabla.add(TableRow(children: _row.toList()));
      _row.clear();
    }

    return tabla;
  }


}

class Loza extends StatelessWidget {
  
  final Color color;
  final String text;

  const Loza({@required this.color, @required this.text});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(0.5),
      width: 100,
      height: 30,
      color: color,
      child: Center(child: Text(text, style: Get.theme.textTheme.subtitle2.merge(TextStyle(color: Colors.white)),)),
    );
  }
}