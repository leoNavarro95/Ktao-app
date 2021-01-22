import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthCalc/app/global_widgets/widgets.dart';
import 'package:healthCalc/app/modules/lectura/lectura_controller.dart';
import 'package:healthCalc/app/modules/lectura/local_widgets/lecturas_form_widget.dart';
import 'package:healthCalc/app/theme/text_theme.dart';

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
      backgroundColor: Colors.lightBlue[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TemaTexto().bottomSheetTitulo,
      ),
      content: formulario,
      actions: <Widget>[
        Container(
          child: FlatButton(
            child: Text('OK'),
            onPressed: () async {
              final bool isSaved = await formulario.guardaLectura(textCtr,
                  inputDateCtr); //si es true se logro guardar sino hubo error
              if (isSaved) {
                Get.back();
                mySnackbar(
                  title: 'Nueva lectura guardada',
                  subtitle: ' ',
                );
              } else{
                mySnackbar(
                    title: 'Error',
                    subtitle: 'No se guardó la lectura',
                  );
              }
            },
          ),
        ),
        FlatButton(
          child: Text('CANCELAR'),
          onPressed: () {
            textCtr.clear();
            Get.back();
          } 
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
