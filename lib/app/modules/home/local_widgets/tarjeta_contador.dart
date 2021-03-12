import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ktao/app/data/model/contador_model.dart';
import 'package:ktao/app/data/model/lectura_model.dart';
import 'package:ktao/app/global_widgets/ktao_graph/ktao_graph_widget.dart';
import 'package:ktao/app/global_widgets/widgets.dart';
import 'package:ktao/app/modules/home/local_widgets/bottom_sheet_opciones.dart';
import 'package:ktao/app/routes/app_routes.dart';
import 'package:ktao/app/theme/text_theme.dart';
import 'package:ktao/app/utils/lecturas_utils.dart';
import 'package:ktao/app/utils/math_util.dart';

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
      child: FutureBuilder(
        future: getLecturasOrdenadas(this.contador),
        builder:
            (BuildContext context, AsyncSnapshot<List<LecturaModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                  child: Text(
                'Cargando...',
                style: TemaTexto().titulo,
              )),
            );
          }
          final lecturasOrdenadas = snapshot.data;

          return InkWell(
            splashColor: Colors.blue.withAlpha(50),
            onLongPress: () async {
              await bottomSheetOpciones(contador);
            },
            onTap: () {
              Get.toNamed(AppRoutes.LECTURAS, arguments: {
                "contador": this.contador,
                "lectOrdenadas": lecturasOrdenadas,
              });
            },
            child: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _header(this.contador.nombre, _borderR),
                _body(lecturasOrdenadas),
              ],
            )),
          );
        },
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
            style: TemaTexto()
                .bottomSheetTitulo
                .merge(TextStyle(color: Colors.white, fontSize: 16)),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )),
    );
  }

  Widget _body(List<LecturaModel> lectOrdenada) {
    return Column(
      children: [
        _info(),
        Divider(
          height: 1,
        ),
        _graphic(lectOrdenada),
      ],
    );
  }

  Widget _graphic(List<LecturaModel> lecturasOrdenadas) {
    KTaoGraph _grafico;
    Widget _chartInfo = Container();

    final List<double> _tasasConsumo =
        utilGetTasasConsumo(lecturasOrdenadas.reversed.toList());
    bool _hasNegativeData = utilHasNegativeData(_tasasConsumo);

    if (_hasNegativeData) {
      //con lecXmes vacio se logra que no se pinten los detalles del grafico
      _grafico = new KTaoGraph(
        lectXmes: {},
        tasasConsumo: [], //vacia a proposito para que no mueste nada
        hasLabelOnYaxis: false,
        hasLabelOnXaxis: false,
        hasBorder: false,
        hasNegativeData: _hasNegativeData,
        hasLineTouch: false,
        aspectRatio: 5,
        lineWidth: 2,
      );

      _chartInfo = myroundedContainer(
        bkgColor: Colors.blue.withAlpha(20),
        icon: Icons.warning_amber_rounded,
        iconColor: Colors.redAccent,
        text: Text(
          'Datos que dan resultados negativos',
          style: TemaTexto()
              .infoTarjeta
              .merge(TextStyle(fontSize: 14, color: Colors.redAccent)),
        ),
      );
    } else {
      _grafico = new KTaoGraph(
        lectXmes: {},
        tasasConsumo: _tasasConsumo,
        hasLabelOnYaxis: false,
        hasLabelOnXaxis: false,
        hasBorder: false,
        hasLineTouch: false,
        aspectRatio: 4,
        lineWidth: 2,
      );
    }

    return Column(
      children: [_grafico, _chartInfo],
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
                style: (costoTotal.isNegative)
                    ? TemaTexto()
                        .infoTarjeta
                        .merge(TextStyle(fontSize: 14, color: Colors.redAccent))
                    : TemaTexto().infoTarjeta.merge(TextStyle(fontSize: 14))),
          ),
          myroundedContainer(
            icon: Icons.flash_on,
            iconColor: Colors.blue,
            text: Text(
              '${utilFormatNum(consumoTotal.toStringAsFixed(0))} KWh',
              style: (consumoTotal.isNegative)
                  ? TemaTexto()
                      .infoTarjeta
                      .merge(TextStyle(fontSize: 14, color: Colors.redAccent))
                  : TemaTexto().infoTarjeta.merge(TextStyle(fontSize: 14)),
            ),
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
