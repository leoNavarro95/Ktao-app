import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ktao/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura.dart';
import 'package:ktao/app/theme/text_theme.dart';
import 'package:ktao/app/utils/math_util.dart';

/// contiene las lecturas efectuadas por mes/anho, lo que permite ordenar las lecturas por periodos de tiempo
class TarjetaMes extends StatelessWidget {
  final String fecha; // en formato /MM/YYYY
  final List<TarjetaLectura> lecturasMes;
  final double consumoMes;

  ///define que este mes ya esta cerrado por una lectura de recibo
  final bool isClosed;

  const TarjetaMes({
    @required this.fecha,
    @required this.lecturasMes,
    @required this.consumoMes,
    this.isClosed = false,
  })  : assert(fecha != null),
        assert(lecturasMes != null);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: contenedorMes(),
    );
  }

  Widget contenedorMes() {
    return Container(
      child: Column(
        children: [
          _encabezado(),
          _lecturasMes(this.lecturasMes),
        ],
      ),
    );
  }

  Widget _encabezado() {
    
    

    Map<String, dynamic> calculos = calcCosto(this.consumoMes);
    double costo = calculos["costo"];

    final String estatusMes = this.isClosed ? "Mes cerrado" : "Mes sin cerrar";

    return Container(
      width: Get.width,
      color: Get.theme.disabledColor, //Color.fromRGBO(100, 150, 200, 1),
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
                  this.fecha,
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
                  '${this.consumoMes.toStringAsFixed(2)} kWh',
                  style: (this.consumoMes.isNegative)
                      ? TemaTexto().tituloTarjeta.merge(
                          TextStyle(fontSize: 14, color: Get.theme.errorColor))
                      : TemaTexto()
                          .tituloTarjeta
                          .merge(TextStyle(fontSize: 14)),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${costo.toStringAsFixed(2)} CUP',
                  style: (costo.isNegative)
                      ? TemaTexto().tituloTarjeta.merge(
                          TextStyle(fontSize: 14, color: Get.theme.errorColor))
                      : TemaTexto()
                          .tituloTarjeta
                          .merge(TextStyle(fontSize: 14)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Text(
              estatusMes,
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

  Widget _lecturasMes(List<TarjetaLectura> listaLecturasMes) {
    return Container(
      child: Column(children: listaLecturasMes),
    );
  }
}
