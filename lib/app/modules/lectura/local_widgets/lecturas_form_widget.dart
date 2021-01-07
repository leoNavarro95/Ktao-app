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

  LecturaForm(
      {this.formKey, this.height, this.contador, this.width, this.lectCtr});

  @override
  Widget build(BuildContext context) {
    final textCtr = TextEditingController();
    final inputDateCtr = TextEditingController();

    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(5),
      color: Colors.blue[100],
      child: Column(
        children: <Widget>[
          _texto(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _inputTextLectura(textCtr),
              _crearFecha(inputDateCtr),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _lamp(),
              _botonAgregarLect(textCtr, inputDateCtr),
            ],
          )
        ],
      ),
    );
  }

  Widget _lamp() {
    return Container(
      width: 0.2 * Get.width,
      height: 50,
      margin: EdgeInsets.only(top: 10, right: 10),
      child: FlatButton(
        shape: StadiumBorder(),
        color: Colors.yellow[300].withAlpha(
            100), //* OJO cambiarle el alpha en dependencia del estado del flash
        child: Icon(Icons.lightbulb_outline, color: Colors.white),
        onPressed: () {
          //! TODO: Encender el flash del movil
          print(DateTime.now().toString()); //.replaceRange(10, 26, ''));
        },
      ),
    );
  }

  Widget _botonAgregarLect(
      TextEditingController textCtr, TextEditingController dateCtr) {
    return Container(
      width: 0.4 * Get.width,
      height: 50,
      margin: EdgeInsets.only(top: 10),
      child: FlatButton(
        shape: StadiumBorder(),
        color: Colors.lightBlue,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await _guardaLectura(textCtr, dateCtr);
        },
      ),
    );
  }

  Future<void> _guardaLectura(
      TextEditingController textCtr, TextEditingController dateCtr) async {
    //validate() devuelve true si el formulario es valido
    if (formKey.currentState.validate()) {
      int lecturaEntrada = int.parse(textCtr.text);
      if (lecturaEntrada != null) {
        final lect = LecturaModel(
            lectura: lecturaEntrada,
            idContador: contador.id,
            fecha: dateCtr.text);
        await DBProvider.db.insertarLectura(lect);
        await lectCtr.updateVisualFromDB();
        textCtr.clear();
      } else {
        throw Error();
      }
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
    return null;
  }

  Widget _inputTextLectura(TextEditingController textCtr) {
    return Container(
      width: 0.4 * Get.width,
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 10),
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

  Widget _crearFecha(TextEditingController dateCtr) {
    return Container(
      width: 0.4 * Get.width,
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        enableInteractiveSelection: false,
        readOnly: true,
        controller: dateCtr,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Fecha',
          hintText: DateTime.now().toString().replaceRange(10, 26, ''),
          labelStyle: TemaTexto().infoTarjeta,
          border: OutlineInputBorder()),
        onTap: () {
          // FocusScope.of(Get.context).requestFocus(new FocusNode());
          _selectDate(dateCtr);
        },
      ),
    );
  }

  Future<void> _selectDate(TextEditingController dateCtr) async {
    String _fecha = '';

    DateTime fechaSeleccionada = await showDatePicker(
      context: Get.context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2019),
      lastDate: new DateTime(2025),
      // locale: Locale('es', 'ES'),
    );

    if (fechaSeleccionada != null) {
      _fecha = fechaSeleccionada.toString();
      _fecha = _fecha.replaceRange(10, 23, '');
      dateCtr.text = _fecha; //el controlador es el que inyecta el texto
    }
  }
}
