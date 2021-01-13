import 'package:flutter/material.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura.dart';

/// contiene las lecturas efectuadas por mes/anho, lo que permite ordenar las lecturas por periodos de tiempo
class TarjetaMes extends StatelessWidget {
  final String fecha;
  final List<TarjetaLectura> lecturasMes;


  const TarjetaMes({@required this.fecha, @required this.lecturasMes,}
  )  : assert(fecha != null),
       assert(lecturasMes != null) 
  ;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: contenedorMes(this.fecha),
    );
  }

  Widget contenedorMes(String fecha,){
    return Container(
      child: Column(
        children: [
          _encabezado(fecha),
          _lecturasMes(this.lecturasMes),
        ],
      ),
    );
  }

  Widget _encabezado(String fecha){
    return Container(
      color: Colors.cyanAccent,
      child: Text(fecha), //'diciembre del 2020'
    );
  }

  
  Widget _lecturasMes(List<TarjetaLectura> listaLecturasMes){
    return Column(children: listaLecturasMes,);
  }

  
}
