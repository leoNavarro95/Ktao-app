import 'package:get/get.dart';
import 'package:ktao/app/data/model/lectura_model.dart';
import 'package:ktao/app/modules/lectura/lectura_controller.dart';

class GraficoController extends GetxController {


  List<LecturaModel> lectOrd = [];

  @override
  void onInit() {
    super.onInit();
    final lectCtr = Get.find<LecturaController>();
    lectOrd = lectCtr.lectOrdenadas.toList();   
  }
  
}
