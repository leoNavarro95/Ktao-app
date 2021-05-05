import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ktao/app/utils/math_util.dart';

class CalculadoraController extends GetxController{

  RxInt lectura1 = 0.obs;
  RxInt lectura2 = 0.obs;  

  final textCtrLectura1 = TextEditingController();
  final textCtrLectura2 = TextEditingController();

  RxInt consumo  = 0.obs;
  RxDouble costo = 0.0.obs;
  RxList<double> listConsumo = [0.0].obs;
  RxList<double> listPrecio = [0.0].obs;//List<double>().obs;

  RxBool expanded = false.obs;

  @override
  void onInit() {
    super.onInit();
    lectura1.value = 0;
    lectura2.value = 0;
    consumo.value = 0;
    costo.value = 0.0;
  }
  @override
  void onClose() {
    this.textCtrLectura1.dispose();
    this.textCtrLectura2.dispose();
    super.onClose();
  }

  void expand(){
    expanded.value = !expanded.value;
    lectura2.value = 0;
    textCtrLectura2.clear();
    this.calcular();
  }

  
  void calcular(){
    consumo.value = (lectura2.value - lectura1.value).abs();
    listPrecio.clear();
    listConsumo.clear();
    Map<String, dynamic> resultado = calcCosto(consumo.value.toDouble());
    
    costo.value = resultado["costo"]; // es de tipo RxDouble
    List<double> lc = resultado["listaConsumo"];
    // lc.forEach((e) { listConsumo.add(e);});
    listConsumo.addAll(lc.toList());
    List<double> lp = resultado["listaPrecio"];
    // lp.forEach((e) { listPrecio.add(e);});
    listPrecio.addAll(lp.toList());
    

  }


}