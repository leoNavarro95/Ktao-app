
import 'package:flutter/material.dart';

class Tabla extends StatelessWidget {

  final List<String> titleRow;
  final Color titleColor;
  final Color primaryColor, secundaryColor;

  final List<List<num>> cuerpo;

  //? TODO: falta implementear el Body
  
  const Tabla(
    {
      Key key, 
      @required this.titleRow, 
      @required this.titleColor, 
      this.primaryColor, 
      this.secundaryColor,
      this.cuerpo,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        children: body(cuerpo)
      ),
    );
  }

 
  

  List<TableRow> body(List<List<num>> cuerpo){
    
    List<Loza> _row = []; //children de los TableRow
    List<TableRow> tabla = [];
    
    //* TitleRow, el titulo da la tabla
          tabla.add(TableRow(
            children: titleRow.map((e) => Loza( color: titleColor, title: e,),).toList()
          ));

    //? se toma como referencia del tamanho de la tabla a cuerpo[0], primera fila
    for (int i = 0; i < (cuerpo[0]).length ; i++){
      for(int j = 0; j < cuerpo.length; j++){
        
        //* si se esta en el rango de la fila se puede acceder a los datos
        if(i < cuerpo[j].length){
          // String _titulo;
          // if(cuerpo[j][i].is)
          _row.add(Loza( color: Colors.blueGrey[300], title: cuerpo[j][i].toStringAsFixed(2)));
        }
        //* de lo contrario la Loza se llena con un string vacio 
        else {
          _row.add(Loza( color: Colors.blueGrey[300], title: " "));
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
  final String title;

  const Loza({Key key, @required this.color, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(0.5),
      width: 100,
      height: 50,
      color: color,
      child: Center(child: Text(title)),
    );
  }
}