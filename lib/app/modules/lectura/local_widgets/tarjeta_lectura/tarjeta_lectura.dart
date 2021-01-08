import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthCalc/app/data/model/lectura_model.dart';
import 'package:healthCalc/app/data/provider/data_base_provider.dart';
import 'package:healthCalc/app/modules/lectura/lectura_controller.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura_controller.dart';
import 'package:healthCalc/app/theme/text_theme.dart';

class TarjetaLectura extends GetView<TarjetaLectController> {
  final LecturaModel lectura;

  const TarjetaLectura({
    Key key,
    this.lectura,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _borderR = 10.0;
    final lectCtr = Get.find<LecturaController>();

    if (lectura == null) {
      return _cardNoLectura();
    }

    return GetBuilder<TarjetaLectController>(
      init: TarjetaLectController(),
      global:
          false, //! OJO para permitir multiples instancias de controladores por cada widget
      id: lectura.id.toString(),
      builder: (_) {
        return Dismissible(
          key: UniqueKey(), //Key(lectura.id.toString()),
          background: _crearDismissibleBkg(),
          onDismissed: (direction) async {
            //primero se obtiene la lista de lecturas presentes antes de borrar en el contador
            final lecturas =
                await DBProvider.db.getLecturasByContador(lectCtr.contador);
            // se borra la lectura por su id de la DataBase
            await DBProvider.db.deleteLectura(lectura.id);

            //si el tamano de la lista de lecturas antes de borrar era igual a 1, hay que refrescar el visual para mostrar que ahora no existen lecturas
            if (lecturas.length == 1) {
              await lectCtr.updateVisualFromDB();
            }
          },
          child: Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_borderR)),
            child: InkWell(
              splashColor: Colors.blue.withAlpha(50),
              onLongPress: () async {},
              onTap: () {},
              child: Container(
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _header(
                        '${this.lectura.lectura}',
                        _borderR,
                        titlebkg: Colors.yellow[300].withAlpha(120),
                        controller: _,
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

  ClipRRect _header(String titulo, double _borderR,
      {Color titlebkg, TarjetaLectController controller}) {
    Widget iconoExpand;

    IconData myIcon;
    BorderRadius myBorder;

    if (controller.expanded) {
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

    if (controller != null) {
      iconoExpand = IconButton(
          splashColor: Colors.blue[100],
          iconSize: 40,
          icon: Icon(
            myIcon,
            color: Colors.black38,
          ),
          onPressed: () {
            controller.expand(lectura.id.toString());
          });
    } else {
      iconoExpand = Container(); // no se muestra nada
    }

    return ClipRRect(
      borderRadius: myBorder,
      child: Container(
          width: double.infinity,
          color: titlebkg,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              Text(
                'Lectura: $titulo',
                textAlign: TextAlign.center,
                style: TemaTexto().tituloTarjetaDark,
              ),
              Expanded(child: Container()),
              iconoExpand,
            ],
          )),
    );
  }

  Widget _body(TarjetaLectController controller) {
    if (controller.expanded) {
      return Container(
        color: Colors.yellow[50],
        child: Column(
          children: [
            Text('Lectura No. ${this.lectura.id}',
                style: TemaTexto().infoTarjeta),
            Divider(),
            Text('Fecha: ${this.lectura.fecha}',
                style: TemaTexto().infoTarjeta),
            Divider(),
            Text('Hace 2 dias', style: TemaTexto().infoTarjeta),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _cardNoLectura() {
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
    );
  }

  Widget _crearDismissibleBkg() {
    return Container(
      color: Colors.red,
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            Icons.delete,
            size: 48.0,
            color: Colors.white54,
          ),
          Text(
            'Borrar',
            style: TextStyle(
                color: Colors.yellow,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.delete,
            size: 48.0,
            color: Colors.white54,
          ),
        ],
      )),
    );
  }
}
