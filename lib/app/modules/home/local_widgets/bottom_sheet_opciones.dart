import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthCalc/app/data/model/contador_model.dart';
import 'package:healthCalc/app/data/provider/data_base_provider.dart';
import 'package:healthCalc/app/global_widgets/widgets.dart';
import 'package:healthCalc/app/modules/home/home_controller.dart';
import 'package:healthCalc/app/theme/text_theme.dart';

///Despliega un dialogo con las opciones para cada contador
///tiene las opciones de editar y borrar contador
///se activa ante el longPress de la tarjetaContador respectiva
Future<void> bottomSheetOpciones(ContadorModel contador) {
  final _formKey = GlobalKey<FormState>();
  final homeCtr = Get.find<HomeController>();
  return Get.bottomSheet(
    BottomSheet(
        backgroundColor: Colors.lightBlue[50],
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        enableDrag: true,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        onClosing: () {
          // Get.snackbar('Ningun contador eliminado.', 'Se mantienen los datos');
        },
        builder: (_) {
          return Container(
            height: 250,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Configuracion',
                    style: TemaTexto().bottomSheetTitulo,
                  ),
                  subtitle: Text('${contador.nombre}',
                      style: TemaTexto().bottomSheetBody),
                  leading: Icon(Icons.settings),
                ),
                Divider(),
                ListTile(
                    title: Text(
                      'Editar contador',
                      style: TemaTexto().bottomSheetBody,
                    ),
                    leading: Icon(Icons.edit),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      String nombre = await textEditOptionDialog(
                        _formKey,
                        title: 'Editar contador',
                        labelHelp: 'Nombre nuevo',
                        errorLabel: 'Introduzca un nombre',
                      );
                      if (nombre != null) {
                        final nuevoContador = ContadorModel(
                          id: contador.id, //! OJO para mantener el mismo id
                          nombre: nombre,
                          consumo: 0,
                          costoMesActual: 0.0,
                          ultimaLectura: 'Hoy',
                        );
                        await DBProvider.db
                            .updateContador(contador, nuevoContador);
                        mySnackbar(
                          title: 'Exito',
                          subtitle: 'Contador editado',
                          icon: Icons.dashboard_customize,
                        );
                        await homeCtr.updateVisualFromDB();
                      } else {
                        mySnackbar(
                          title: 'No se efectuo ningun cambio',
                          subtitle: 'Se mantienen los datos anteriores',
                        );
                      }
                    }),
                ListTile(
                  title: Text(
                    'Eliminar contador',
                    style: TemaTexto().bottomSheetBody,
                  ),
                  leading: Icon(Icons.delete),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _eliminarContador(contador);
                  },
                ),
              ],
            ),
          );
        }),
  );
}

Future<void> _eliminarContador(ContadorModel contador) async {
  final homeCtr = Get.find<HomeController>();
  bool aceptas = await borraContadorDialog(contador);

  if (aceptas) {
    await DBProvider.db.deleteContador(contador.id);
    Get.snackbar('Exito', 'El contador ${contador.nombre} fue eliminado.');
    homeCtr.updateVisualFromDB();
  } else {
    Get.snackbar('Accion cancelada', 'Se mantienen los datos');
    // Get.back();
  }
}
