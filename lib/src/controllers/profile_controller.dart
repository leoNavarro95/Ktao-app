import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:preferencias_de_usuario/models/user_model.dart';

class ProfileController extends GetxController {
  User _user;
  User get user => _user;

  String _inputText = '';

  String get inputText => _inputText;

  void onTextFieldChanged(String text) {
    this._inputText = text;
  }

  void goToBackWithData() {
    if (this._inputText.trim().length > 0) {
      // TODO: navega a la pagina anterior con los datos de inputText
      Get.back(result: this._inputText);
    } else {
      Get.dialog(
        AlertDialog(
          title: Text("Error de entrada"),
          content: Text("Datos incorrectos"),
          actions: [
            FlatButton(onPressed: () => Get.back(), child: Text('Aceptar')),
          ],
        ),
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    //Get.arguments toma los argumentos enviados desde showUserProfile() en arguments:
    this._user = Get.arguments as User; //OJO as es para hacer casting
  }
}
