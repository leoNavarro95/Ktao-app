import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ktao/app/data/model/contador_model.dart';
import 'package:ktao/app/data/provider/data_base_provider.dart';
import 'package:ktao/app/global_widgets/widgets.dart';
import 'package:ktao/app/global_widgets/menu_lateral.dart';

import 'package:ktao/app/modules/home/home_controller.dart';

import 'local_widgets/tarjeta_contador.dart';

class HomePage extends StatelessWidget {
  //? Para hacer validacion del campo de texto
  final _formKey = GlobalKey<FormState>();
  final homeCtr = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          drawer: MenuLateral(),
          appBar: buildAppBar(),
          body: Obx(() {
            if (_.tarjetas.isNotEmpty) {
              return ListView(
                children: <Widget>[
                  // _buildTableContadores(contadores: _.tarjetas),
                  Column(
                    children: _.tarjetas,
                  ),
                ],
              );
            }
            return TarjetaContador();
          }),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: _agregarContador,
          ),
        ),
      );
    });
  }
  
  Future<bool> onWillPop() {
    return myboolDialog(
      titulo: '¿Desea cerrar la app?',
      subtitulo: ' '
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Inicio'),
      centerTitle: true,
    );
  }

  Future<void> _agregarContador() async {
    String nombre = await textEditOptionDialog(
      _formKey,
      title: 'Adicionar contador',
      labelHelp: 'Nombre contador',
      errorLabel: 'campo vacío',
    );
    if (nombre != null) {
      final contador = ContadorModel(
          nombre: nombre,
          consumo: 0,
          costoMesActual: 0.0,
          ultimaLectura: 'Hoy');

      await DBProvider.db.nuevoContador(contador);

      mySnackbar(
        title: 'Exito',
        subtitle: 'Nuevo contador en la base de datos',
        icon: Icons.dashboard_customize,
      );

      await homeCtr.updateVisualFromDB();
    } else {
      mySnackbar(
        title: 'No se efectuo ningun cambio',
        subtitle: 'Se mantienen los datos anteriores',
      );
    }
  }

  Future<void> _eliminarContadores() async {
    bool aceptas = await myboolDialog(
      titulo: '¿Desea eliminar todos los contadores?',
      subtitulo: "Se perderán los registros de la base de datos",
    );
    if (aceptas) {
      final cantidad = await DBProvider.db.deleteallContadores();
      String _mensaje;
      switch (cantidad) {
        case 0:
          _mensaje = 'Ningun contador eliminado';
          break;
        case 1:
          _mensaje = '1 contador eliminado';
          break;
        default:
          _mensaje = '$cantidad contadores eliminados';
          break;
      }
      mySnackbar(
        title: 'Accion de eliminar contador',
        subtitle: '$_mensaje',
        icon: Icons.delete,
      );
      await homeCtr.updateVisualFromDB();
    } else {
      mySnackbar(
        title: 'Ningun contador eliminado',
        subtitle: 'Se mantienen los datos',
      );
    }
  }
}
