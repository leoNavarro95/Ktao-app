import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

import 'package:ktao/app/data/provider/data_base_provider.dart';
import 'package:ktao/app/modules/detalles/detalles_controller.dart';
import 'package:ktao/app/modules/grafico/grafico_page.dart';
import 'package:ktao/app/modules/lectura/local_widgets/agregar_lectura_dialog.dart';
import 'package:ktao/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura.dart';
import 'package:ktao/app/theme/text_theme.dart';
import 'package:ktao/app/modules/detalles/detalles_page.dart';

import 'lectura_controller.dart';

class LecturaPage extends GetView<LecturaController> {
  final lecturaCtr = Get.find<LecturaController>();
  final detallesCtr = Get.find<DetallesController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final detalles = DetallesPage(contador: lecturaCtr.contador);
    //! Get.put(DetallesController(contador: lecturaCtr.contador));  debe funcionar pues esta inyectado en el binding de Home
    final graficos = GraficoPage(); //lectXmes: detallesCtr.lecturasXmes

    //las paginas que se van a encontrar en el tabBarView
    final List<Widget> paginas = [_contenido(), detalles, graficos];
    // paginas.add(Center(child: Text(lecturaCtr.myTabs[2].text)));

    return GetBuilder<LecturaController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Lecturas'),
            bottom: TabBar(
              controller: _.tabController,
              tabs: _.myTabs,
            ),
          ),
          body: TabBarView(
            controller: _.tabController,
            children: paginas,
          ),
          floatingActionButton: _myFloatingActionButton(),
        );
      },
    );
  }

  ///solo se va a permitir en la p
  Widget _myFloatingActionButton() {
    return Obx(() {
      if (lecturaCtr.indice.value == 0) {
        return Roulette(
          spins: 2,
          delay: Duration(milliseconds: 1000),
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              await agregarLecturaDialog(
                formKey,
                lecturaCtr,
                title: "Nueva lectura",
              );
            },
          ),
        );
      }
      return ZoomOut(
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: null,
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
        color: Get.theme.toggleableActiveColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
        child: Text('${contador.nombre}',
            textAlign: TextAlign.center, style: Get.theme.textTheme.headline4),
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
