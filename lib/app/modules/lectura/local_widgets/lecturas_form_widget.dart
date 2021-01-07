import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:healthCalc/app/data/model/lectura_model.dart';
import 'package:healthCalc/app/data/provider/data_base_provider.dart';
import 'package:healthCalc/app/modules/lectura/lectura_controller.dart';
import 'package:healthCalc/app/theme/text_theme.dart';

class LecturaForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final ContadorModel contador;
  final double height;
  final double width;
  final LecturaController lectCtr;

  final _inputDateController = new TextEditingController();

  LecturaForm(
      {this.formKey, this.height, this.contador, this.width, this.lectCtr});

  @override
  Widget build(BuildContext context) {
    final textCtr = TextEditingController();

    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(5),
      color: Colors.blue[100],
      child: Column(
        children: <Widget>[
          _texto(),
          _inputTextLectura(textCtr),
          _crearFecha(context),
          _botonAgregarLect(textCtr),
        ],
      ),
    );
  }

  Widget _botonAgregarLect(TextEditingController textCtr) {
    return FlatButton(
      shape: StadiumBorder(),
      color: Colors.lightBlue,
      child: Icon(Icons.add, color: Colors.white),
      onPressed: () async {
        await _guardaLectura(textCtr);
      },
    );
  }

  Future<void> _guardaLectura(TextEditingController textCtr) async {
    //validate() devuelve true si el formulario es valido
    if (formKey.currentState.validate()) {
      final lect = LecturaModel(
          lectura: lectCtr.lecturaFromTextInput, idContador: contador.id);
      await DBProvider.db.insertarLectura(lect);
      await lectCtr.updateVisualFromDB();
      textCtr.clear();
    }
  }

  Container _texto() {
    return Container(
        margin: EdgeInsets.all(8),
        child: Text(
          'Introduzca una nueva lectura',
          style: TemaTexto().bottomSheetBody,
        ));
  }

  String _validacion(String value) {
    if (value.isEmpty) {
      return 'Campo vacio';
    }
    lectCtr.lecturaFromTextInput = int.parse(value);
    return null;
  }

  Widget _inputTextLectura(TextEditingController textCtr) {
    return Container(
      width: 0.5 * Get.width,
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: formKey,
        child: TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp('[ .,-]')),
          ],
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
              labelText: 'Lectura',
              labelStyle: TemaTexto().infoTarjeta,
              border: OutlineInputBorder()),
          controller: textCtr,
          validator: _validacion,
        ),
      ),
    );
  }

  Widget _crearFecha(BuildContext context) {
    return Container(
      width: 0.5 * Get.width,
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        enableInteractiveSelection: false,
        readOnly: true,
        controller: _inputDateController,
        decoration: InputDecoration(
            labelText: 'Fecha',
            labelStyle: TemaTexto().infoTarjeta,
            border: OutlineInputBorder()),
        onTap: () {
          // FocusScope.of(Get.context).requestFocus(new FocusNode());
          _selectDate(context);
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    String _fecha = '';

    DateTime fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2019),
      lastDate: new DateTime(2025),
      // locale: Locale('es', 'ES'),
    );

    if (fechaSeleccionada != null) {
      _fecha = fechaSeleccionada.toString();
      _fecha = _fecha.replaceRange(10, 23, '');
      _inputDateController.text =
          _fecha; //el controlador es el que inyecta el texto
    }
  }
}
