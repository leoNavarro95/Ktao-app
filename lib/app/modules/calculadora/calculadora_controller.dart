import 'package:get/get.dart';
import 'package:healthCalc/app/utils/math_util.dart';

class CalculadoraController extends GetxController{

  RxInt lectura1 = 0.obs;
  RxInt lectura2 = 0.obs;  
  RxInt consumo  = 0.obs;
  RxDouble costo = 0.0.obs;
  
  void calcular(){
    consumo.value = (lectura2.value - lectura1.value).abs(); //? OJO: abs() retorna el valor absoluto (|x|)
    costo.value  = calcCosto(consumo.value);

  }


}