import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthCalc/app/modules/home/local_widgets/tarjeta/tarjeta_controller.dart';
import 'package:healthCalc/app/theme/text_theme.dart';

class TarjetaContador extends StatelessWidget {

  final String titulo;
  final String consumo;

  const TarjetaContador({
    Key key,
    @required this.titulo, 
    this.consumo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _borderR = 10.0;
    
    return GetBuilder<TarjetaController>(
      init: TarjetaController(),
      id: titulo,
      builder: (_){
        return Card(
      
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderR)),
      elevation: _.elevacion,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(50),
        onLongPress: (){
          //TODO: ante longPress mostrar cuadro de opciones, borrar, editar, etc
          print('tarjeta presionada con duracion');
        },
        onTap: (){
          print('tarjeta presionada');
          _.presionada(titulo); // hace el efecto de que se presione visualmente, variando la elevvacion
          
        },
        child: Container(
          width: 150,
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _header(this.titulo, _borderR),
              _body(),
            ],
          )
          ),
      ),
    );

      });
  }

  ClipRRect _header( String titulo, double _borderR) {
    return ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(_borderR),
                topRight: Radius.circular(_borderR),
                ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                color: Colors.blue[300],
                child: Text(titulo, textAlign: TextAlign.center, style: TemaTexto().tituloTarjeta,)
                ),
            );
  }

  Widget _body(){
    return Column(
      children: [
        SizedBox(height: 50),
        Text('Hace 2 dias',style: TemaTexto().infoTarjeta),
        Divider(),
        InputChip(
          onPressed: (){},
          padding: EdgeInsets.all(10),
          label: Text('545kWh',style: TemaTexto().cuerpoTarjeta),
          avatar: CircleAvatar(child: Icon(Icons.flash_on))
          ),
          InputChip(
            onPressed: (){},
            padding: EdgeInsets.all(10),
            label: Text('10,000', style: TemaTexto().cuerpoTarjeta),
            avatar: CircleAvatar(
              child: Icon(Icons.attach_money),
              )
          ),
      ],
    );
  }

  
}