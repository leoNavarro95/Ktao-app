

import 'package:get/state_manager.dart';
import 'package:healthCalc/app/data/provider/data_base_provider.dart';
import 'package:healthCalc/app/modules/home/local_widgets/tarjeta/tarjeta_contador.dart';

class HomeController extends GetxController{
  
  RxString resultado = ''.obs;
  RxList<TarjetaContador> tarjetas = List<TarjetaContador>().obs;

  @override
  void onReady() {
    super.onReady();
    // this.resultado.value = 'hola';
    updateVisualFromDB();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   updateVisualFromDB();
  // }

  void adicionarTarjeta( TarjetaContador tarjeta){
    tarjetas.add(tarjeta);
  }

  Future<void> updateVisualFromDB() async {

    this.tarjetas.clear();
    
    final contadores = await DBProvider.db.getTodosContadores();

    for(int i = 0; i < contadores.length ; i++){
      this.adicionarTarjeta(TarjetaContador(contador: contadores[i],));
    }

  }

}