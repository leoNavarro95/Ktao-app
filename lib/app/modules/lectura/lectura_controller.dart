

import 'package:get/get.dart';
import 'package:healthCalc/app/data/model/contador_model.dart';
import 'package:healthCalc/app/data/provider/data_base_provider.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/tarjeta_lectura/tarjeta_lectura.dart';

//! TODO: no funciona el control del flash del movil
// import 'package:lamp/lamp.dart';
// import 'package:flutter_lantern/flutter_lantern.dart';

class LecturaController extends GetxController {

  ContadorModel _contador;
  ContadorModel get contador => _contador;

  ///lista que contiene las tarjetas de las lecturas
  RxList<TarjetaLectura> tarjetasLect = List<TarjetaLectura>().obs;

  bool estadoLampara = false; //false -- apagada/ true -- encendida
  
  @override
  void onInit() async {
    super.onInit();
    this._contador = Get.arguments as ContadorModel; //se obtiene el argumento pasado desde la pagina anterior
    
    final testLecturas = await DBProvider.db.getLecturasByFechaPattern(contador,'/01/2021');
    testLecturas.map((e){print('fecha: ${e.fecha} lectura: ${e.lectura}');}).toList();
    await updateVisualFromDB();
  }

  
  void adicionarTarjetaLectura( TarjetaLectura tarjeta){
    tarjetasLect.add(tarjeta);
  }

  Future<void> updateVisualFromDB() async {

    this.tarjetasLect.clear();
    
    final lecturas = await DBProvider.db.getLecturasByContador( contador );

    if(lecturas != null){
      for(int i = 0; i < lecturas.length ; i++){
      this.adicionarTarjetaLectura(TarjetaLectura(lectura: lecturas[i],));
    }
    }

  }

}

