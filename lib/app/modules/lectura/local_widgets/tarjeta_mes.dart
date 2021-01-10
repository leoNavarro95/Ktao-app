import 'package:flutter/material.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura.dart';

class TarjLectXMes extends StatelessWidget {
  final List<TarjetaLectura> listTarjetasLect;

  const TarjLectXMes({@required this.listTarjetasLect});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('test'),
    );
  }

  /// retorna un String con el mes y el anho. Por ejempo si se le pasan los parametros 
  /// mes=2 y anho=2020, retorna "febrero del 2020". mes tiene que estar entre 1 y 12
  String obtenerFecha(int mes, int anho) {
    List<String> meses = [
      '',
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre',
    ];

    if ((mes <= 0) | (mes > 12)) {
      return 'mes incorrecto';
    }
    return '${meses[mes]} del ${anho.toString()}';
  }

  // el formato de la fecha es XX/XX/XXXX ex: 08/01/2021
  Map<String,int> descomponerFecha(String fecha){
    List<String> splitFecha = fecha.split('/'); // salida ex: ['08','01','2021']
    return {
      'month': int.parse(splitFecha[1]), //8
      'year' : int.parse(splitFecha[2]), //2021
    };
  }

  List<Widget> _buildListLectXMes(List<TarjetaLectura> list) {
    
    for (int i = 0; i < list.length; i++) {

    }
  }
}
