import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ktao/app/global_widgets/widgets.dart';
import 'package:ktao/app/modules/lectura/lectura_controller.dart';
import 'package:ktao/app/modules/lectura/local_widgets/lecturas_form_widget.dart';

Future<void> agregarLecturaDialog(
  GlobalKey<FormState> formKey,
  LecturaController lectCtr, {
  String title = "Title",
  String labelHelp = "Help label",
  String errorLabel = "Error",
}) async {
  final textCtr = lectCtr.textCtr;
  final inputDateCtr = lectCtr.inputDateCtr;

  final formulario = LecturaForm(
    formKey: formKey,
    lectCtr: lectCtr,
    textCtr: textCtr,
    inputDateCtr: inputDateCtr,
  );

  return await Get.dialog(
    AlertDialog(
      titlePadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: Get.theme.textTheme.headline5//bottomSheetTitulo,
      ),
      content: formulario,
      actions: <Widget>[
        TextButton(
            child: Text('CANCELAR', style: TextStyle(color: Get.theme.indicatorColor),),
            onPressed: () {
              textCtr.clear();
              Get.back();
            }),
        TextButton(
          child: Text('OK', style: TextStyle(color: Get.theme.indicatorColor),),
          onPressed: () async {
            final String dbStatus = await formulario.guardaLectura(textCtr,
                inputDateCtr); //si es true se logro guardar sino hubo error
            if (dbStatus.substring(0, 5) != "Error") {
              Get.back();
            }
            mySnackbar(
              title: dbStatus,
              subtitle: ' ',
            );
          },
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
