import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura.dart';
import 'package:healthCalc/app/theme/text_theme.dart';
import 'package:healthCalc/app/utils/math_util.dart';

/// contiene las lecturas efectuadas por mes/anho, lo que permite ordenar las lecturas por periodos de tiempo
class TarjetaMes extends StatelessWidget {
  final String fecha; // en formato /MM/YYYY
  final List<TarjetaLectura> lecturasMes;

  ///define que este mes ya esta cerrado por una lectura de recibo
  final bool isClosed;

  const TarjetaMes({
    @required this.fecha,
    @required this.lecturasMes,
    this.isClosed = false,
  })  : assert(fecha != null),
        assert(lecturasMes != null);
  @override
  Widget build(BuildContext context) {
    bool isWinter = true;

    // final String initFecha =
    //     fecha.substring(0, 3); //toma los tres primeros caracteres de la fecha
    // if ((initFecha == 'nov') | (initFecha == 'dic') | (initFecha == 'ene')| (initFecha == 'feb')) {
    //   isWinter = true;
    // } else {
    //   isWinter = false;
    // }

    return Container(
      child: contenedorMes(this.fecha, isWinter),
    );
  }

  Widget contenedorMes(String fecha, bool isWinter) {
    return Container(
      child: Column(
        children: [
          _encabezado(fecha, isWinter),
          _lecturasMes(this.lecturasMes, isWinter),
        ],
      ),
    );
  }

  Widget _encabezado(String fecha, bool isWinter) {
    double consumo = this.lecturasMes[lecturasMes.length - 1].lectura.lectura -
        this.lecturasMes[0].lectura.lectura;

    Map<String, dynamic> calculos = calcCosto(consumo);
    double costo = calculos["costo"];

    final String reciboStr = this.isClosed ? "Mes cerrado" : "Mes sin cerrar";

    Color myColor;
    if (isWinter)
      myColor = Color.fromRGBO(100, 150, 200, 1);
    else
      myColor = Colors.deepOrangeAccent;

    return Container(
      width: Get.width,
      color: myColor,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(flex: 1),
                (this.isClosed)
                    ? Icon(Icons.done_all, color: Colors.grey[100])
                    : Container(),
                Spacer(flex: 5),
                Text(
                  fecha,
                  style: TemaTexto().tituloTarjeta,
                  textAlign: TextAlign.center,
                ),
                Spacer(flex: 5)
              ],
            ),
            Divider(
              color: Colors.white24,
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${consumo.toStringAsFixed(2)} kWh',
                  style:
                      (consumo.isNegative)
                      ? TemaTexto().tituloTarjeta.merge(TextStyle(fontSize: 14, color: Colors.red))
                      : TemaTexto().tituloTarjeta.merge(TextStyle(fontSize: 14)),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${costo.toStringAsFixed(2)} CUP',
                  style:
                      (costo.isNegative)
                      ? TemaTexto().tituloTarjeta.merge(TextStyle(fontSize: 14, color: Colors.red))
                      : TemaTexto().tituloTarjeta.merge(TextStyle(fontSize: 14)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Divider(
              color: Colors.white24,
              height: 1,
            ),
            Text(
              reciboStr,
              textAlign: TextAlign.center,
              style: TemaTexto()
                  .cuerpoTarjeta
                  .merge(TextStyle(color: Colors.grey[100], fontSize: 10)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lecturasMes(List<TarjetaLectura> listaLecturasMes, bool isWinter) {
    Color bkgColor;
    if (isWinter) {
      bkgColor = Color.fromRGBO(175, 241, 248, 0.5);
    } else {
      bkgColor = Color.fromRGBO(253, 226, 55, 0.6);
    }

    return Container(
      color: bkgColor,
      child: Column(children: listaLecturasMes),
    );
  }
}
