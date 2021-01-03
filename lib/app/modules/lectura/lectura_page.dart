
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthCalc/app/data/model/lectura_model.dart';
import 'package:healthCalc/app/data/provider/data_base_provider.dart';

import 'lectura_controller.dart';

class LecturaPage extends GetView<LecturaController> {


  @override
  Widget build(BuildContext context) {

    return GetBuilder<LecturaController>(
      builder: (_){
      return Scaffold(
        appBar: AppBar(title: Text('Lecturas del contador')),
        body: listaLecturasWidget(),
      );
    });
  }
}

Widget listaLecturasWidget() {
  final listaCtr = Get.find<LecturaController>();
  // final lecturas = DBProvider.db.getLecturasByContador(listaCtr.contador);

  return FutureBuilder<List<LecturaModel>>(
    // future: DBProvider.db.getLecturasByContador(listaCtr.contador),
    future: DBProvider.db.getTodasLecturas(),
    builder: (BuildContext context, AsyncSnapshot<List<LecturaModel>> snapshot) {
      //si aun no hay datos de la base de datos
      if(!snapshot.hasData){
        return Center(child: CircularProgressIndicator());
      }

      final lecturas = snapshot.data;

      if ( lecturas.isEmpty ){
        return Center(child: Text('No hay lecturas'));
      }

      return ListView.builder(
        itemCount: lecturas.length,
        itemBuilder: (cont, index ){
          return ListTile(
            leading: Icon(Icons.table_view),
            title: Text('${lecturas[index].id} - ${lecturas[index].lectura}'),
            subtitle: Text('${lecturas[index].idContador} - ${lecturas[index].fecha}'),
          );
        }
        );
    },
  );

}