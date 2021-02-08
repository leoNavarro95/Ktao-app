import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:healthCalc/app/data/model/lectura_model.dart';
import 'package:healthCalc/app/data/provider/data_base_provider.dart';
import 'package:healthCalc/app/modules/lectura/lectura_controller.dart';
import 'package:healthCalc/app/theme/text_theme.dart';

class LecturaForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final LecturaController lectCtr;
  final TextEditingController textCtr;
  final TextEditingController inputDateCtr;

  LecturaForm({this.formKey, this.lectCtr, this.textCtr, this.inputDateCtr});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            _texto(),
            _inputTextLectura(textCtr),
            _crearFecha(inputDateCtr),
            //_botonAgregarLect(textCtr, inputDateCtr)
          ],
        ),
      ),
    );
  }
  bool yaExisteLectConEsaFecha = false;

  Future<bool> guardaLectura(
      TextEditingController textCtr, TextEditingController dateCtr) async {
    //validate() devuelve true si el formulario es valido
    if (formKey.currentState.validate()) {
      final double lecturaEntrada = double.parse(textCtr.text);
      // final String fecha = date
      if (lecturaEntrada != null) {
        final lect = LecturaModel(
            lectura: lecturaEntrada,
            idContador: lectCtr.contador.id,
            fecha: dateCtr.text);
        //* Hay que comprobar que no exista una lectura con la misma fecha
        final List<LecturaModel> lectConMismaFecha = await DBProvider.db
            .getLecturasByFechaPattern(lectCtr.contador, dateCtr.text);
        if (lectConMismaFecha.length != 0) {
          yaExisteLectConEsaFecha = true;

        } else {
          await DBProvider.db.insertarLectura(lect);
          await lectCtr.updateVisualFromDB();
          textCtr.clear();
          return true;
        }
      } else {
        throw Error();
      }
    }
    return false; // no se guardó nada por error de entrada
  }

  Container _texto() {
    return Container(
        margin: EdgeInsets.only(bottom: 8),
        child: Text(
          'Introduzca una nueva lectura',
          style: TemaTexto().bottomSheetBody,
        ));
  }

  String _validacion(String value) {
    if (value.isEmpty) {
      return 'Campo vacio';
    }
    if ((value.length < 5) | (value.length > 7)) {
      return 'Lectura inválida';
    }
    return null;
  }

  Widget _inputTextLectura(TextEditingController textCtr) {
    return Container(
      width: 0.4 * Get.width,
      height: 60,
      margin: EdgeInsets.only(bottom: 20),
      child: Form(
        key: formKey,
        child: TextFormField(
          inputFormatters: [
            // FilteringTextInputFormatter.deny(RegExp('[ ,-]')),
            MaskTextInputFormatter(
                mask: '#####.#', filter: {"#": RegExp(r'[0-9]')}),
          ],
          keyboardType: TextInputType.numberWithOptions(),
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
    String fecha = DateTime.now().toString().replaceRange(10, 26, '');
    fecha = torcerFecha(fecha);
    dateCtr.text = fecha;

    return Container(
      width: 0.4 * Get.width,
      height: 60,
      margin: EdgeInsets.all(0),
      child: TextField(
        enableInteractiveSelection: false,
        readOnly: true,
        controller: dateCtr,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: 'Fecha',
            // hintText: fecha,
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
      initialDate: new DateTime.now(), //donde va a poner el selector
      firstDate: new DateTime(2020), //desde que fecha se puede elegir
      lastDate: new DateTime
          .now(), //ultima fecha que se puede elegir, NO SE PERMITE SELECCIONAR FUTURO
      locale: Locale('es', 'ES'),
    );

    if (fechaSeleccionada != null) {
      _fecha = fechaSeleccionada.toString();
      _fecha = _fecha.replaceRange(10, 23, '');

      String fecha = torcerFecha(_fecha);
      print(fecha);
      dateCtr.text = fecha; //el controlador es el que inyecta el texto
    }
  }

  String torcerFecha(String fecha) {
    //si fecha es: 2021-01-02 retorna ['2021','01','02']
    List<String> compFecha = fecha.split('-');
    String fechaTorcida = '';
    for (int i = compFecha.length; i > 0; i--) {
      if (i == 1) {
        fechaTorcida += compFecha[i - 1];
      } else
        fechaTorcida += compFecha[i - 1] + '/';
    }
    return fechaTorcida;
  }
}
