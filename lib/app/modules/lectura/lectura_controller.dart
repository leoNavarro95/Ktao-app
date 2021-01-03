

import 'package:get/get.dart';
import 'package:healthCalc/app/data/model/contador_model.dart';

class LecturaController extends GetxController {

  // final _obj = ''.obs;
  // set obj(value) => this._obj.value = value;
  // get obj => this._obj.value;
  ContadorModel _contador;
  ContadorModel get contador => _contador;

  @override
  void onInit() {
    super.onInit();
    this._contador = Get.arguments as ContadorModel; //se obtiene el argumento pasado desde la pagina anterior
  }

}

