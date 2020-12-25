

import 'package:get/state_manager.dart';
import 'package:healthCalc/app/modules/home/local_widgets/tarjeta/tarjeta_contador.dart';

class HomeController extends GetxController{
  
  RxString resultado = ''.obs;
  RxList<TarjetaContador> tarjetas = List<TarjetaContador>().obs;

  @override
  void onReady() {
    super.onReady();
    this.resultado.value = 'hola';
  }

  void adicionarTarjeta( TarjetaContador tarjeta){
    tarjetas.add(tarjeta);
  }

}