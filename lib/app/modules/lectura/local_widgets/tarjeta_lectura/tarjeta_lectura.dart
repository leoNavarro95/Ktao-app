import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthCalc/app/data/model/lectura_model.dart';
import 'package:healthCalc/app/data/provider/data_base_provider.dart';
import 'package:healthCalc/app/global_widgets/widgets.dart';
import 'package:healthCalc/app/modules/lectura/lectura_controller.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura_controller.dart';
import 'package:healthCalc/app/theme/text_theme.dart';

class TarjetaLectura extends GetView<TarjetaLectController> {
  final LecturaModel lectura;
  final bool mostrarConsumo;
  final bool isDeletable;
  final bool isElevated;
  // delta es la diferencia entre la lectura actual y la anterior
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
          SizedBox(height: 0.2 * Get.height),
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
              splashColor: Colors.blue.withAlpha(50),
              child: Container(
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _header(
                        '${this.lectura.lectura}',
                        _borderR,
                        titlebkg: Colors.yellow[300].withAlpha(120),
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
          splashColor: Colors.blue[100],
          iconSize: 30,
          icon: Icon(
            Icons.delete_outline_outlined,
            color: Colors.black38,
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
          splashColor: Colors.blue[100],
          iconSize: 40,
          icon: Icon(
            myIcon,
            color: Colors.black38,
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
                Expanded(child: Container()),
                Text(
                  'Lect: $titulo',
                  textAlign: TextAlign.center,
                  style: TemaTexto().tituloTarjetaDark,
                ),
                Expanded(child: Container()),
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
          style: TemaTexto().infoTarjeta);
      final double _delt = trending["delta"];
      final double _deltAnt = trending["deltaAnterior"];
      if (_delt > _deltAnt)
        _icono = Icons.arrow_upward;
      else
        _icono = Icons.arrow_downward;
    }

    Widget deltaConsumo;
    if (this.mostrarConsumo) {
      deltaConsumo = Container(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _consumo(_deltaText, _icono),
          ],
        ),
      );
    } else {
      deltaConsumo = Container();
    }

    if (controller.expanded) {
      return Container(
        color: Colors.yellow[50],
        child: Column(
          children: [
            deltaConsumo,
            this.mostrarConsumo ? Divider() : SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${this.lectura.fecha} ',
                      style: TemaTexto().infoTarjeta),
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
                splashColor: Colors.blue.withAlpha(50),
                child: Container(
                    width: 300,
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: Text(
                            'No existen lecturas registradas',
                            textAlign: TextAlign.center,
                            style: TemaTexto().tituloTarjetaDark,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.featured_play_list_outlined,
                            size: 100,
                            color: Colors.grey[400],
                          ),
                        ),
                        Text(
                          'Agrege nuevas lecturas',
                          style: TemaTexto().bottomSheetBody,
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
    return Text(tiempoStr, style: TemaTexto().infoTarjeta);
  }

  Widget _consumo(Text _deltaText, IconData icon) {
    return GestureDetector(
      onTap: () {
        _onTapConsumo(_deltaText.data);
      },
      child: Container(
          child: Row(
        children: [
          Icon(
            icon,
            color: (icon == Icons.arrow_downward) ? Colors.green : Colors.red,
            size: 18,
          ),
          _deltaText,
        ],
      )),
    );
  }

  void _onTapConsumo(String deltaConsumo) {
    IconData icono;
    Color color;
    String titulo, subtitulo;

    if (deltaConsumo[0] == '-') {
      icono = Icons.warning;
      color = Colors.red;
      titulo = 'Balance negativo';
      subtitulo = 'Error de lectura, compurebe los datos';
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
