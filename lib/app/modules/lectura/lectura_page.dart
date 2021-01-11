import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

import 'package:healthCalc/app/data/provider/data_base_provider.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/agregar_lectura_dialog.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura_controller.dart';
import 'package:healthCalc/app/theme/text_theme.dart';

import 'lectura_controller.dart';

class LecturaPage extends GetView<LecturaController> {
  final lecturaCtr = Get.find<LecturaController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final tabs = ['Gestión', 'Detalles', 'Gráficos'];
    final List<Widget> paginas = [_contenido()];
    for (int i = 1; i < tabs.length; i++) {
      paginas.add(Center(child: Text(tabs[i])));
    }

    return GetBuilder<LecturaController>(builder: (_) {
      return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Lecturas'),
            bottom: TabBar(
              tabs: tabs.map((e) => Text(e)).toList(),
            ),
          ),
          body: TabBarView(
            children: paginas,
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              await agregarLecturaDialog(
                formKey,
                lecturaCtr,
                title: "Nueva lectura",
              );
            },
          ),
        ),
      );
    });
  }

  Widget _contenido() {
    final ContadorModel contador = lecturaCtr.contador;

    return Container(
      child: Stack(
        children: [
          Container(
            child: _listaLecturas(contador),
          ),

          // TarjLectXMes(month: DateTime.now().month, year: DateTime.now().year,),
          Container(
            alignment: Alignment.topCenter,
            child: BounceInDown(
                delay: Duration(milliseconds: 500),
                from: 120,
                child: _headerContadorName(contador)),
          ),
        ],
      ),
    );
  }

  Widget _headerContadorName(ContadorModel contador) {
    return Container(
      padding: EdgeInsets.only(top: 0),
      width: 0.7 * Get.width,
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(0),
        color: Colors.blue[300],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
        child: Text('${contador.nombre}',
            textAlign: TextAlign.center, style: TemaTexto().tituloTarjeta),
      ),
    );
  }

  Widget _listaLecturas(ContadorModel contador) {
    return Obx(() {
      if (lecturaCtr.tarjetasLect.isNotEmpty) {
        return ListView.builder(
          itemCount: lecturaCtr.tarjetasLect.length,
          itemBuilder: (_, index) {
            if (index == 0) {
              return Column(
                children: [
                  SizedBox(height: 50),
                  lecturaCtr.tarjetasLect[index],
                ],
              );
            }
            return lecturaCtr.tarjetasLect[index];
          },
        );
      }
      return TarjetaLectura(); //sin parametro ya devuelve que no tiene nada
    });
  }
}
