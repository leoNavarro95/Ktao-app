import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthCalc/app/data/model/contador_model.dart';
import 'package:healthCalc/app/data/model/lectura_model.dart';
import 'package:healthCalc/app/data/provider/data_base_provider.dart';
import 'package:healthCalc/app/modules/home/home_controller.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura.dart';
import 'package:healthCalc/app/utils/lecturas_utils.dart';

//! TODO: no funciona el control del flash del movil
// import 'package:lamp/lamp.dart';
// import 'package:flutter_lantern/flutter_lantern.dart';

class LecturaController extends GetxController
    with SingleGetTickerProviderMixin {
  ContadorModel _contador;
  ContadorModel get contador => _contador;

  ///lista que contiene las tarjetas de las lecturas
  RxList<TarjetaLectura> tarjetasLect = List<TarjetaLectura>().obs;

  // Controladores de texto para dialogo adicionar lecturas
  final textCtr = TextEditingController();
  final inputDateCtr = TextEditingController();

  // ######### Control de los Tabs en el TabBarView #############
  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Gestión',
    ),
    Tab(
      text: 'Detalles',
    ),
    Tab(
      text: 'Gráficos',
    ),
  ];
  TabController tabController;
  RxInt indice = 0.obs;
  //#############################################################
  @override
  void onInit() async {
    super.onInit();
    //se obtiene el argumento pasado desde la pagina anterior
    this._contador = Get.arguments as ContadorModel;

    tabController = TabController(vsync: this, length: myTabs.length);
    tabController.addListener(() {
      indice.value = tabController.index;
    });

    await updateVisualFromDB();
  }

  @override
  void onClose() {
    final homeCtr = Get.find<HomeController>();
    homeCtr.updateVisualFromDB();

    tabController.dispose();
    textCtr.dispose();
    inputDateCtr.dispose();

    super.onClose();
  }

  void adicionarTarjetaLectura(TarjetaLectura tarjeta) {
    tarjetasLect.add(tarjeta);
  }

  Future<void> updateVisualFromDB() async {
    this.tarjetasLect.clear();

    final List<LecturaModel> lecturas =
        await DBProvider.db.getLecturasByContador(contador);

    if (lecturas != null) {
      final List<LecturaModel> lectOrdenadas = ordenarPorFecha(lecturas);

      tarjetasLect.addAll(utilFillCardLectura(
        lectOrdenadas,
        tarjetasLect.toList(),
        cardIsDeletable: true,
        cardIsElevated: true,
        cardMostrarConsumo: false
      ));
      
    }
  }
}
