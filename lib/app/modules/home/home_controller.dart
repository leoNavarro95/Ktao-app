import 'package:get/state_manager.dart';
import 'package:healthCalc/app/data/model/lectura_model.dart';
import 'package:healthCalc/app/data/provider/data_base_provider.dart';
import 'package:healthCalc/app/modules/home/local_widgets/tarjeta_contador.dart';
import 'package:healthCalc/app/utils/lecturas_utils.dart';
import 'package:healthCalc/app/utils/math_util.dart';

class HomeController extends GetxController {
  RxString resultado = ''.obs;
  RxList<TarjetaContador> tarjetas = List<TarjetaContador>().obs;

  @override
  void onInit() {
    super.onInit();

    updateVisualFromDB();
  }

  Future<void> updateVisualFromDB() async {
    final contadores = await DBProvider.db.getTodosContadores();

    this.tarjetas.clear();

    for (ContadorModel contador in contadores) {
      final List<LecturaModel> lecturas =
        await DBProvider.db.getLecturasByContador(contador);
      
      final double _consumoT = getConsumoTotal(lecturas);
      final Map<String, dynamic> _infoCosto = calcCosto(_consumoT);
      final double _costoT = _infoCosto["costo"];

      tarjetas.add(
        TarjetaContador(
          contador: contador,
          cantLecturas: this.getCantLecturas(lecturas),
          consumoTotal: _consumoT,
          costoTotal: _costoT,
        ),
      );
    }
  }

  int getCantLecturas(List<LecturaModel> lecturas) {
    final int cantidadLect = (lecturas == null) ? 0 : lecturas.length;
    return cantidadLect;
  }
}
