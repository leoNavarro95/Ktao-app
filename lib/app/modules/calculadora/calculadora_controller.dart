import 'package:get/get.dart';
import 'package:healthCalc/app/utils/math_util.dart';

class CalculadoraController extends GetxController{

  RxInt lectura1 = 0.obs;
  RxInt lectura2 = 0.obs;  
  RxInt consumo  = 0.obs;
  RxDouble costo = 0.0.obs;
  RxList<int> listConsumo = List<int>().obs;
  RxList<double> listPrecio = List<double>().obs;

  @override
  void onReady() {
    super.onReady();
    listConsumo.add(0);
    listPrecio.add(0.0);
    
  }

  
  void calcular(){
    consumo.value = (lectura2.value - lectura1.value).abs(); //? OJO: abs() retorna el valor absoluto (|x|)
    listPrecio.clear();
    listConsumo.clear();
    Map<String, dynamic> resultado = calcCosto(consumo.value);
    print('${resultado["listaConsumo"]}//${resultado["listaPrecio"]}');
    
    costo.value = resultado["costo"]; // es de tipo RxDouble
    List<int> lc = resultado["listaConsumo"];
    lc.forEach((e) { listConsumo.add(e);});
    List<double> lp = resultado["listaPrecio"];
    lp.forEach((e) { listPrecio.add(e);});

    print("___________");
    print('$listConsumo // $listPrecio');
    

  }


}