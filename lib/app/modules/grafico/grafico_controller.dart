import 'package:get/get.dart';
import 'package:ktao/app/data/model/lectura_model.dart';
import 'package:ktao/app/modules/detalles/detalles_controller.dart';
import 'package:ktao/app/modules/lectura/lectura_controller.dart';

class GraficoController extends GetxController {


  List<LecturaModel> lectOrd = [];
  Map<String, List<double>> lecturasXmes = {};

  @override
  void onInit() {
    super.onInit();
    final lectCtr = Get.find<LecturaController>();
    final detallesCtr = Get.find<DetallesController>();
    lectOrd = lectCtr.lectOrdenadas.reversed.toList();
    lecturasXmes = detallesCtr.lecturasXmes;
  }

  // @override
  // void onClose(){
  
  //   super.onClose();
  // }
  
}
