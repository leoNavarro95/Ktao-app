import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthCalc/app/data/model/contador_model.dart';
import 'package:healthCalc/app/global_widgets/widgets.dart';
import 'package:healthCalc/app/modules/home/local_widgets/bottom_sheet_opciones.dart';
import 'package:healthCalc/app/routes/app_routes.dart';
import 'package:healthCalc/app/theme/text_theme.dart';
import 'package:healthCalc/app/utils/lecturas_utils.dart';

class TarjetaContador extends StatelessWidget {
  final ContadorModel contador;
  final int cantLecturas;
  final double consumoTotal;
  final double costoTotal;
  const TarjetaContador({
    Key key,
    this.contador,
    this.cantLecturas = 0,
    this.consumoTotal = 0.0,
    this.costoTotal = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _borderR = 10.0;

    if (contador == null) {
      return _cardNoContador();
    }
    return Card(
      margin: EdgeInsets.all(20),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderR)),
      elevation: 5,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(50),
        onLongPress: () async {
          await bottomSheetOpciones(contador);
        },
        onTap: () async {
          Get.toNamed(AppRoutes.LECTURAS, arguments: contador);
        },
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _header(this.contador.nombre, _borderR),
            _body(),
          ],
        )),
      ),
    );
  }

  ClipRRect _header(String titulo, double _borderR, {Color titlebkg}) {
    if (titlebkg == null) {
      titlebkg = Colors.blue[300];
    }

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(_borderR),
        topRight: Radius.circular(_borderR),
      ),
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(5),
          color: titlebkg,
          child: Text(
            titulo,
            textAlign: TextAlign.center,
            style: TemaTexto().tituloTarjeta,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _info(),
        Divider(
          height: 1,
        ),
        _graphic()
      ],
    );
  }

  Widget _graphic() {
    return Column(
      children: [
        Icon(Icons.bar_chart_sharp, color: Colors.blue, size: 50),
        myroundedContainer(
          bkgColor: Colors.blue.withAlpha(20),
          icon: Icons.check_box,
          iconColor: Colors.blue,
          text: Text(
            'Gráfico aquí',
            style: TemaTexto().infoTarjeta.merge(TextStyle(fontSize: 14)),
          ),
        ),
      ],
    );
  }

  Widget _info() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          myroundedContainer(
            icon: Icons.featured_play_list_outlined,
            iconColor: Colors.blue,
            text: Text('$cantLecturas',
                style: TemaTexto().infoTarjeta.merge(TextStyle(fontSize: 14))),
          ),
          myroundedContainer(
            icon: Icons.monetization_on_outlined,
            iconColor: Colors.blue,
            text: Text('${utilFormatNum(costoTotal.toStringAsFixed(0))} CUP',
                style: TemaTexto().infoTarjeta.merge(TextStyle(fontSize: 14))),
          ),
          myroundedContainer(
            icon: Icons.flash_on,
            iconColor: Colors.blue,
            text: Text('${utilFormatNum(consumoTotal.toStringAsFixed(0))} KWh',
                style: TemaTexto().infoTarjeta.merge(TextStyle(fontSize: 14))),
          ),
        ],
      ),
    );
  }

  Widget _cardNoContador() {
    final _borderR = 10.0;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_borderR)),
            child: InkWell(
              splashColor: Colors.blue.withAlpha(50),
              child: Container(
                  width: 300,
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _header('No hay contador', _borderR,
                          titlebkg: Colors.grey[400]),
                      SizedBox(height: 50),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.add_box_rounded,
                          size: 100,
                          color: Colors.grey[400],
                        ),
                      ),
                      Text(
                        'Agregar uno nuevo',
                        style: TemaTexto().bottomSheetBody,
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
