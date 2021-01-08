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
          _botonAgregarLect(textCtr, inputDateCtr)
        ],
      ),
    );
  }

  //* no funciona el flash del movil
  Widget _lamp() {
    final _apagadaColor = Colors.yellow[300].withAlpha(100);
    final _encendidaColor = Colors.yellow[300].withAlpha(200);
    return Container(
      width: 0.2 * Get.width,
      height: 50,
      margin: EdgeInsets.only(top: 10, right: 10),
      child: FlatButton(
        shape: StadiumBorder(),
        color: (lectCtr.estadoLampara) ? _encendidaColor : _apagadaColor,
        child: Icon(Icons.lightbulb_outline, color: Colors.white),
        onPressed: () {
          // lectCtr.switchLamp();
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
      final int lecturaEntrada = int.parse(textCtr.text);
      // final String fecha = date
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
      margin: EdgeInsets.symmetric(horizontal: 10),
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
