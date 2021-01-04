import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthCalc/app/data/model/lectura_model.dart';
import 'package:healthCalc/app/theme/text_theme.dart';

class TarjetaLectura extends StatelessWidget {

  final LecturaModel lectura;

  const TarjetaLectura({
    Key key,
    this.lectura,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _borderR = 10.0;

    if(lectura == null){
      return _cardNoLectura();
    }

    return Card(
      
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderR)),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(50),
        
        onLongPress: () async{
          
        },
        onTap: (){
          
        },
        child: Container(
          width: Get.width,
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _header('${this.lectura.lectura} kWh', _borderR),
              _body(),
            ],
          )
          ),
      ),
    );
  }

  ClipRRect _header( String titulo, double _borderR, {Color titlebkg}) {
    
    if(titlebkg == null){
      titlebkg = Colors.blue[300];
    }

    return ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(_borderR),
                topRight: Radius.circular(_borderR),
                ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                color: titlebkg,
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
          label: Text('${lectura.id}',style: TemaTexto().cuerpoTarjeta),
          avatar: CircleAvatar(child: Icon(Icons.flash_on))
          ),
          InputChip(
            onPressed: (){},
            padding: EdgeInsets.all(10),
            label: Text('${lectura.fecha} fecha', style: TemaTexto().cuerpoTarjeta),
            avatar: CircleAvatar(
              child: Icon(Icons.attach_money),
              )
          ),
      ],
    );
  }

  Widget _cardNoLectura() {
    final _borderR = 10.0;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderR)),
            child: InkWell(
              splashColor: Colors.blue.withAlpha(50),
              
              onTap: (){
                //TODO: agregar nueva lectura 
              },
              child: Container(
                width: 300,
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _header('No hay lecturas', _borderR, titlebkg: Colors.grey[400]),
                    
                    SizedBox(height: 50),
                    
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.add_box_rounded,
                        size: 100,
                        color: Colors.grey[400],
                        ),
                    ),

                    Text('Agregar una nueva', style: TemaTexto().bottomSheetBody,)

                  ],
                )
                ),
            ),
      ),
        ],
        ),
    );
  } 
  
}