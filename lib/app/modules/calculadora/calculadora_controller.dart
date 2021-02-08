import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthCalc/app/utils/math_util.dart';

class CalculadoraController extends GetxController{

  RxInt lectura1 = 0.obs;
  RxInt lectura2 = 0.obs;  

  final textCtrLectura1 = TextEditingController();
  final textCtrLectura2 = TextEditingController();

  RxInt consumo  = 0.obs;
  RxDouble costo = 0.0.obs;
  RxList<double> listConsumo = List<double>().obs;
  RxList<double> listPrecio = List<double>().obs;

  RxBool expanded = false.obs;

  @override
  void onInit() {
    super.onInit();
    lectura1.value = 0;
    lectura2.value = 0;
    consumo.value = 0;
    costo.value = 0.0;

    listConsumo.add(0);
    listPrecio.add(0.0);
    
  }
  @override
  void onClose() {
    this.textCtrLectura1.dispose();
    this.textCtrLectura2.dispose();
    print('cerrado');
    super.onClose();
  }

  void expand(){
    expanded.value = !expanded.value;
  }

  
  void calcular(){
    consumo.value = (lectura2.value - lectura1.value).abs(); //? OJO: abs() retorna el valor absoluto (|x|)
    listPrecio.clear();
    listConsumo.clear();
    Map<String, dynamic> resultado = calcCosto(consumo.value.toDouble());
    
    costo.value = resultado["costo"]; // es de tipo RxDouble
    List<double> lc = resultado["listaConsumo"];
    lc.forEach((e) { listConsumo.add(e);});
    List<double> lp = resultado["listaPrecio"];
    lp.forEach((e) { listPrecio.add(e);});
    

  }


}