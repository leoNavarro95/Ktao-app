import 'package:get/state_manager.dart';
import 'package:healthCalc/app/data/model/lectura_model.dart';
import 'package:healthCalc/app/data/provider/data_base_provider.dart';
import 'package:healthCalc/app/modules/home/local_widgets/tarjeta_contador.dart';

class HomeController extends GetxController {
  RxString resultado = ''.obs;
  RxList<TarjetaContador> tarjetas = List<TarjetaContador>().obs;

  @override
  void onInit() {
    super.onInit();
    //if(!inicializado) //si no se ha inicializado se actualiza la vista
    updateVisualFromDB();
  }


  Future<void> updateVisualFromDB() async {
    this.tarjetas.clear();
    

    final contadores = await DBProvider.db.getTodosContadores();


    for (ContadorModel contador in contadores) {
      final int cantLect = await this.getCantLecturas(contador);

      tarjetas.add(
        TarjetaContador(
          contador: contador,
          cantLecturas: cantLect,
        ),
      );
    }
  }

  Future<int> getCantLecturas(ContadorModel contador) async {
    final List<LecturaModel> lecturas =
        await DBProvider.db.getLecturasByContador(contador);
    int cantidadLect = ( lecturas == null ) ? 0 : lecturas.length;
    return cantidadLect;
  }
}
