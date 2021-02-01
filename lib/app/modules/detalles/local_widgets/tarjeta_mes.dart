import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura.dart';
import 'package:healthCalc/app/theme/text_theme.dart';

/// contiene las lecturas efectuadas por mes/anho, lo que permite ordenar las lecturas por periodos de tiempo
class TarjetaMes extends StatelessWidget {
  final String fecha;
  final List<TarjetaLectura> lecturasMes;

  const TarjetaMes({
    @required this.fecha,
    @required this.lecturasMes,
  })  : assert(fecha != null),
        assert(lecturasMes != null);

  @override
  Widget build(BuildContext context) {
    bool isWinter = false;

    final String initFecha =
        fecha.substring(0, 3); //toma los tres primeros caracteres de la fecha
    if ((initFecha == 'nov') | (initFecha == 'dic') | (initFecha == 'ene')) {
      isWinter = true;
    } else {
      isWinter = false;
    }

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
    String assetStr;
    if (isWinter)
      assetStr = "assets/banner_invierno.svg";
    else
      assetStr = "assets/banner_verano.svg";

    return Container(
      width: Get.width,
      // color: Color.fromRGBO(120, 200, 220, 1),
      child: Stack(
        children: [
          Container(
            width: Get.width,
            height: 50,
            child: SvgPicture.asset(
              assetStr,
              fit: BoxFit.fitHeight,
            ),
          ),
          Center(
            child: Text(
              fecha,
              style: TemaTexto().tituloTarjeta,
              textAlign: TextAlign.center,
            ),
          ), //'diciembre del 2020'
        ],
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
