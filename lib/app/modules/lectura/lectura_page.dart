import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

import 'package:healthCalc/app/data/provider/data_base_provider.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/agregar_lectura_dialog.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura.dart';
import 'package:healthCalc/app/theme/text_theme.dart';
import 'package:healthCalc/app/modules/historial/historial_page.dart';

import 'lectura_controller.dart';

class LecturaPage extends GetView<LecturaController> {
  final lecturaCtr = Get.find<LecturaController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final tabs = ['Gestión', 'Historial', 'Gráficos'];
    final historial = HistorialPage(
      contador: lecturaCtr.contador,
    );

    //las paginas que se van a encontrar en el tabBarView
    final List<Widget> paginas = [_contenido(), historial];
    paginas.add(Center(child: Text(lecturaCtr.myTabs[2].text)));

    return GetBuilder<LecturaController>(builder: (_) {
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
          floatingActionButton: _myFloatingActionButton());
    });
  }

  ///solo se va a permitir en la p
  Widget _myFloatingActionButton() {
    return Obx((){
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
