import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ktao/app/data/model/lectura_model.dart';
import 'package:ktao/app/data/provider/data_base_provider.dart';
import 'package:ktao/app/global_widgets/widgets.dart';
import 'package:ktao/app/modules/lectura/lectura_controller.dart';
import 'package:ktao/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura_controller.dart';
import 'package:ktao/app/theme/text_theme.dart';
import 'package:ktao/app/utils/math_util.dart';

class TarjetaLectura extends GetView<TarjetaLectController> {
  final LecturaModel lectura;
  final bool mostrarConsumo;
  final bool isDeletable;
  final bool isElevated;

  /// "delta": es la diferencia entre la lectura actual y la anterior
  /// "deltaAnterior": es esa diferencia anterior
  final Map<String, double> trending;

  const TarjetaLectura({
    this.lectura,
    this.trending = const {"delta": 0.0, "deltaAnterior": 0.0},
    this.mostrarConsumo = true,
    this.isDeletable = true,
    this.isElevated = true,
  });

  @override
  Widget build(BuildContext context) {
    final _borderR = 10.0;
    final lectCtr = Get.find<LecturaController>();

    if (lectura == null) {
      return ListView(
        children: [
          SizedBox(height: 0.15 * Get.height),
          _cardNoLectura(),
        ],
      );
    }

    return GetBuilder<TarjetaLectController>(
      init: TarjetaLectController(),
      //! OJO para permitir multiples instancias de controladores por cada widget
      global: false,

      id: lectura.id.toString(),
      builder: (_) {
        return FadeInLeft(
          child: Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_borderR)),
            elevation: isElevated ? 2.0 : 0.0,
            child: InkWell(
              child: Container(
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _header(
                        '${this.lectura.lectura}',
                        _borderR,
                        titlebkg: Get.theme.cardColor,
                        tarjLectCtr: _,
                        lectCtr: lectCtr,
                      ),
                      _body(_),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  Future<void> _eliminarLectura(LecturaController lectCtr) async {
    // se borra la lectura por su id de la DataBase
    await DBProvider.db.deleteLectura(lectura.id);
    await lectCtr.updateVisualFromDB();
  }

  Widget _botonEliminarLect(LecturaController lectCtr) {
    if (this.isDeletable) {
      return IconButton(
          iconSize: 30,
          icon: Icon(
            Icons.delete_outline_outlined,
            // color: Colors.black38,
          ),
          onPressed: () async {
            bool opcion = await myboolDialog(
                titulo: '¿Desea eliminar esta lectura?',
                subtitulo: 'Si elimina la lectura no podrá recuperarla');
            if (opcion) await _eliminarLectura(lectCtr);
          });
    }
    return Container();
  }

  ClipRRect _header(String titulo, double _borderR,
      {Color titlebkg,
      TarjetaLectController tarjLectCtr,
      @required LecturaController lectCtr}) {
    Widget iconoExpand;

    IconData myIcon;
    BorderRadius myBorder;

    if (tarjLectCtr.expanded) {
      myIcon = Icons.keyboard_arrow_up;
      myBorder = BorderRadius.only(
        topLeft: Radius.circular(_borderR),
        topRight: Radius.circular(_borderR),
      );
    } else {
      myIcon = Icons.keyboard_arrow_down;
      myBorder = BorderRadius.all(Radius.circular(_borderR));
    }

    if (titlebkg == null) {
      titlebkg = Colors.blue[300];
    }

    if (tarjLectCtr != null) {
      iconoExpand = IconButton(
          iconSize: 40,
          icon: Icon(
            myIcon,
            // color: Colors.black38,
          ),
          onPressed: () {
            tarjLectCtr.expand(lectura.id.toString());
          });
    } else {
      iconoExpand = Container(); // no se muestra nada
    }

    return ClipRRect(
      borderRadius: myBorder,
      child: GestureDetector(
        onTap: () {
          tarjLectCtr.expand(lectura.id.toString());
        },
        child: Container(
            width: double.infinity,
            color: titlebkg,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (lectura.isRecibo == 1)
                    ? Expanded(child: Container(margin: EdgeInsets.symmetric(horizontal: 2),child: Icon(Icons.done_all)))
                    : Spacer(flex: 1,),
                Text(
                  'Lect: $titulo',
                  textAlign: TextAlign.center,
                  style: Get.theme.textTheme.caption,
                ),
                Spacer(flex: 1,),
                _botonEliminarLect(lectCtr),
                iconoExpand,
              ],
            )),
      ),
    );
  }

  Widget _body(TarjetaLectController controller) {
    Text _deltaText;
    IconData _icono;
    if (trending["delta"] == null) {
      _deltaText = Text('0.0 kWh', style: TemaTexto().infoTarjeta);
      _icono = Icons.not_interested;
    } else if (trending["delta"].isNegative) {
      _deltaText = Text('${this.trending["delta"].toStringAsFixed(1)} kWh',
          style: TemaTexto().infoTarjetaError);
      _icono = Icons.error;
    } else {
      _deltaText = Text('${this.trending["delta"].toStringAsFixed(1)} kWh',
          style: Get.theme.textTheme.subtitle2);
      final double _delt = trending["delta"];
      final double _deltAnt = trending["deltaAnterior"];
      if (_delt > _deltAnt)
        _icono = Icons.arrow_upward;
      else
        _icono = Icons.arrow_downward;
    }
    Map<String, dynamic> calculos = calcCosto(trending["delta"]);
    double costoDbl = calculos["costo"];

    final Text costoTxt = Text('${costoDbl.toStringAsFixed(1)} CUP',
        style: Get.theme.textTheme.subtitle2 );

    Widget deltaConsumo;
    if (this.mostrarConsumo) {
      deltaConsumo = Container(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            myroundedContainer(
              text: _deltaText,
              icon: _icono,
              iconColor:
                  (_icono == Icons.arrow_downward) ? Colors.green : Colors.red,
              onTap: () {
                _onTapConsumo(_deltaText.data);
              },
            ),
            myroundedContainer(
              text: costoTxt,
              icon: Icons.monetization_on_outlined,
              iconColor: Colors.blueAccent,
            ),
          ],
        ),
      );
    } else {
      deltaConsumo = Container();
    }

    if (controller.expanded) {
      return Container(
        
        child: Column(
          children: [
            deltaConsumo,
            this.mostrarConsumo ? Divider(height: 5,) : SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${this.lectura.fecha} ',
                      style: Get.theme.textTheme.subtitle2),
                  _haceXTiempo(),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _cardNoLectura() {
    final _borderR = 10.0;
    return FlipInX(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_borderR)),
              child: InkWell(
                child: Container(
                    width: 300,
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            'No existen lecturas registradas',
                            textAlign: TextAlign.center,
                            style: Get.theme.textTheme.headline5,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.featured_play_list_outlined,
                            size: 100,
                          ),
                        ),
                        Text(
                          'Agrege nuevas lecturas',
                          style: Get.theme.textTheme.subtitle2,
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _haceXTiempo() {
    String fecha = this.lectura.fecha;
    List<String> fechaComponentes = fecha.split('/');

    int day = int.parse(fechaComponentes[0]);
    int month = int.parse(fechaComponentes[1]);
    int year = int.parse(fechaComponentes[2]);

    DateTime fechaLect = DateTime(year, month, day);
    DateTime hoy = DateTime.now();
    final tiempoDesde = hoy.difference(fechaLect);

    String tiempoStr;
    if (tiempoDesde.inDays == 0) {
      tiempoStr = '(Hoy)';
    } else {
      tiempoStr =
          '(Hace ${tiempoDesde.inDays} ${(tiempoDesde.inDays == 1) ? 'día' : 'días'})';
    }
    return Text(tiempoStr, style: Get.theme.textTheme.subtitle2);
  }

  void _onTapConsumo(String deltaConsumo) {
    IconData icono;
    Color color;
    String titulo, subtitulo;

    if (deltaConsumo[0] == '-') {
      icono = Icons.warning;
      color = Colors.red;
      titulo = 'Balance negativo';
      subtitulo = 'Error de lectura, compruebe los datos';
    } else {
      icono = Icons.info;
      color = Colors.yellow;
      titulo = 'Balance de consumo';
      subtitulo = '$deltaConsumo más que la lectura anterior';
    }
    mySnackbar(
        title: titulo, subtitle: subtitulo, icon: icono, iconColor: color);
  }
}
