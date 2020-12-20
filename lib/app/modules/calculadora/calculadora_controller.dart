import 'package:get/get.dart';

class CalculadoraController extends GetxController{

  RxInt lectura1 = 0.obs;
  // int get lectura1 => _lectura1.value;
  // set lectura1(int dato){
  // this._lectura1.value = dato;
  // }

  RxInt lectura2 = 0.obs;
  // int get lectura2 => _lectura2.value;
  // set lectura2(int dato){
  // this._lectura2.value = dato;
  // }

  RxInt consumo = 0.obs;
  // int get consumo => _consumo.value;
  // set consumo(int dato){
  // this._consumo.value = dato;
  // }

  void calcular(){
    consumo.value = (lectura2.value - lectura1.value).abs(); //? OJO: abs() retorna el valor absoluto (|x|)
    print('C[kWh]: $consumo');
  }

}