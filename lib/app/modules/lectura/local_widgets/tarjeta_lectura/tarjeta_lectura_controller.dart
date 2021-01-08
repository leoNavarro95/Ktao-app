import 'package:get/get.dart';

class TarjetaLectController extends GetxController {
  bool expanded = false;

  void expand(String id) {
    expanded = !expanded;
    update([id]);
  }
}
