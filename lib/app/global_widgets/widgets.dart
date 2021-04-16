import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ktao/app/data/model/contador_model.dart';
import 'package:ktao/app/theme/theme_services.dart';

///Dialogo que si se acepta devuelve true y si se cancela devuelve false
Future<bool> myboolDialog(
    {String titulo = "Title", String subtitulo = "Subtitle"}) async {
  return await Get.dialog(
    AlertDialog(
      actionsPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text(
        titulo,
        style: Get.theme.textTheme.headline5,
      ),
      content: Text(
        subtitulo,
        style: Get.theme.textTheme.headline5,
      ),
      actions: <Widget>[
        TextButton(
          child: Text('CANCELAR'),
          onPressed: () => Get.back(result: false),
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Get.back(result: true);
          },
        ),
      ],
    ),
    barrierDismissible: false,
  );
}

Future<void> dialogInfo(
    {String titulo = "Title",
    String subtitulo = "Subtitle",
    IconData icon = Icons.info}) async {
  return await Get.dialog(
    AlertDialog(
      actionsPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      )),
      title: Column(
        children: [
          Row(
            children: [
              Icon(icon),
              SizedBox(width: 10),
              Text(
                titulo,
                style: Get.theme.textTheme.headline5,
              ),
            ],
          ),
        ],
      ),
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        child: Text(
          subtitulo,
          style:
              Get.theme.textTheme.caption.merge(TextStyle(color: Colors.white)),
        ),
      ),
    ),
  );
}

Future<bool> borraContadorDialog(ContadorModel contador) async {
  return await Get.dialog(
    AlertDialog(
      backgroundColor: Colors.lightBlue[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text('¿Desea eliminar el contador?'),
      content: Text(
          "El contador ${contador.nombre} sera eliminado completamente de la base de datos"),
      actions: <Widget>[
        TextButton(
          child: Text('CANCELAR'),
          onPressed: () => Get.back(result: false),
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Get.back(result: true);
          },
        ),
      ],
    ),
    barrierDismissible: false,
  );
}

Future<String> textEditOptionDialog(
  GlobalKey<FormState> formKey, {
  String title = "Title",
  String labelHelp = "Help label",
  String errorLabel = "Error",
}) async {
  String _valorInput = '';

  return await Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text(
        title,
        style: Get.theme.textTheme.headline5,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  style: Get.theme.textTheme.headline6,
                  decoration: InputDecoration(
                    labelText: labelHelp,
                    icon: Icon(Icons.add_box),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return errorLabel;
                    }
                    _valorInput = value;
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('CANCELAR'),
          onPressed: () =>
              Get.back(), //! va a retornar null, manejarlo del otro lado
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            //validate() devuelve true si el formulario es valido
            if (formKey.currentState.validate()) {
              Get.back(result: _valorInput);
            }
          },
        ),
      ],
    ),
    barrierDismissible: false,
  );
}

void mySnackbar({
  String title,
  String subtitle,
  IconData icon = Icons.warning,
  Color iconColor = Colors.red,
  int showMillisecs = 2500,
  bool isDisplayedInBottom = false,
}) {
  Color colorText =
      ThemeService().isSavedDarkMode() ? Colors.grey[300] : Colors.grey[900];
  return Get.snackbar(title, subtitle,
      snackPosition:
          isDisplayedInBottom ? SnackPosition.BOTTOM : SnackPosition.TOP,
      borderWidth: 2,
      // borderColor: Colors.black12,
      colorText: colorText,
      icon: Icon(
        icon,
        color: iconColor,
      ),
      duration: Duration(milliseconds: showMillisecs));
}

Widget myroundedContainer(
    {Text text,
    IconData icon,
    double iconSize = 18,
    Color bkgColor,
    Color iconColor,
    Function onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: bkgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: iconSize),
            SizedBox(
              width: 5,
            ),
            text,
          ],
        )),
  );
}

class MyCheckBoxController extends GetxController {
  bool checkValue = false;
  void changed(bool value) {
    checkValue = value;
    if (value) {
      mySnackbar(
        title: "Lectura de recibo",
        subtitle:
            "Al seleccionar esta opción, se cerrarán las operaciones para el mes",
        showMillisecs: 4000,
      );
    }
    update();
  }
}

class MyCheckBox extends GetView<MyCheckBoxController> {
  final String text;

  const MyCheckBox(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<MyCheckBoxController>(
          init: MyCheckBoxController(),
          builder: (_) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: _.checkValue,
                  onChanged: (value) {
                    _.changed(value);
                  },
                ),
                Text(
                  this.text,
                  style: Get.theme.textTheme.headline6,
                )
              ],
            );
          }),
    );
  }
}
