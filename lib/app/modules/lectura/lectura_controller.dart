import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ktao/app/data/model/contador_model.dart';
import 'package:ktao/app/data/model/lectura_model.dart';
import 'package:ktao/app/data/provider/data_base_provider.dart';
import 'package:ktao/app/modules/home/home_controller.dart';
import 'package:ktao/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura.dart';
import 'package:ktao/app/utils/lecturas_utils.dart';

//! TODO: no funciona el control del flash del movil
// import 'package:lamp/lamp.dart';
// import 'package:flutter_lantern/flutter_lantern.dart';

class LecturaController extends GetxController
    with SingleGetTickerProviderMixin {
  ContadorModel _contador;
  ContadorModel get contador => _contador;

  List<LecturaModel> _lectOrdenadas;
  List<LecturaModel> get lectOrdenadas => _lectOrdenadas;

  ///lista que contiene las tarjetas de las lecturas
  RxList<TarjetaLectura> tarjetasLect =
      List<TarjetaLectura>.empty(growable: true).obs;

  // Controladores de texto para dialogo adicionar lecturas
  final textCtr = TextEditingController();
  final inputDateCtr = TextEditingController();

  // ######### Control de los Tabs en el TabBarView #############
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Gestión'),
    Tab(text: 'Detalles'),
    Tab(text: 'Análisis'),
  ];
  TabController tabController;
  RxInt indice = 0.obs;
  //#############################################################
  @override
  void onInit() async {
    super.onInit();
    //se obtiene el argumento pasado desde la pagina anterior
    final Map<String, dynamic> datos = Get.arguments;
    this._contador = datos["contador"];
    this._lectOrdenadas = datos["lectOrdenadas"];

    tabController = TabController(vsync: this, length: myTabs.length);
    tabController.addListener(() {
      indice.value = tabController.index;
    });
    updateVisualFromDB();
  }

  @override
  void onClose() async {
    final homeCtr = Get.find<HomeController>();
    homeCtr.updateVisualFromDB();

    tabController.dispose();
    textCtr.dispose();
    inputDateCtr.dispose();

    super.onClose();
  }

  Future<void> updateVisualFromDB() async {
    this.tarjetasLect.clear();

    final List<LecturaModel> lecturasOrd = await getLecturasOrdenadas(contador);
    this._lectOrdenadas = lecturasOrd.toList();

    if (lecturasOrd.isNotEmpty) {
      tarjetasLect.addAll(fillCardLectura(
        lecturasOrd,
        tarjetasLect.toList(),
        cardIsDeletable: true,
        cardIsElevated: true,
        cardMostrarConsumo: true,
      ));
    }
  }
}
