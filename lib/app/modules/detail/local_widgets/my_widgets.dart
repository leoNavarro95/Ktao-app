
import 'dart:math';

import 'package:flutter/material.dart';

  Widget fondoApp(){
    
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,

      decoration: BoxDecoration(
        //para darle un color con gradiente lineal
        gradient: LinearGradient(
          //el origen del sistema de coordenadas está en la esquina izquierda superior del movil (0;0), el final de ese sistema está en la esquina derecha inferior (1;1)

          begin: FractionalOffset(0.0, 0.6),//inicio del gradiente para coordenada x=0, y=0.6 
          end: FractionalOffset(0.0, 1.0),

          colors: [
            Color.fromRGBO(52, 54, 101, 1.0),
            Color.fromRGBO(35,35,57,1.0),
          ]
          ),
      ),
    );

    //Transform.rotate, Creates a widget that transforms its child using a rotation around the center.The angle argument must not be null. It gives the rotation in clockwise radians.

    final cajaRosa = Transform.rotate(
      angle: -pi/5.0,
      child: Container(
      width: 360.0,
      height: 360.0,

      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(90.0),
        
        gradient: LinearGradient(
          begin: FractionalOffset(0, 1),
          end: FractionalOffset(1, 0),
          colors: [
            Color.fromRGBO(250, 80, 195, 1),
            Color.fromRGBO(241, 142, 172, 1)
          ]),

      ),

    ),
      
      );

    return Stack(children: <Widget>[
      gradiente,
      //Creates a widget that controls where a child of a [Stack] is positioned.
      Positioned(
        top: -80.0,
        child: cajaRosa
        ),
    ],);


  }

  Widget titulo() {

    final estilo1 = TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold);
    final estilo2 = TextStyle(color: Colors.white, fontSize: 15.0);

    return Container(

      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: SafeArea(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            Text('Classify transaction', style: estilo1,),
            SizedBox(height: 10.0),
            Text('Classify this transaction into a particular category', style: estilo2),
          ]
          ,),
      ),
      );
  }

  Widget bottomNavBar(BuildContext context){

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor:  Color.fromRGBO(55,57,84,1.0),
        primaryColor: Colors.pinkAccent,
        textTheme: Theme.of(context).textTheme.copyWith(
          caption: TextStyle( color: Color.fromRGBO(116, 117, 152, 1.0))
        )
      ),

      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon( Icons.calendar_today ),
            label: "Container()",
            ),

            BottomNavigationBarItem(
            icon: Icon( Icons.poll ),
            label: "Container()"
            ),

            BottomNavigationBarItem(
            icon: Icon( Icons.power ),
            label: "Container()"
            ),
        ],
        ),
    );
  }

  Widget botonera(){
    return Table(
      children: <TableRow>[
        TableRow(
          children: [
            crearBotonRedondeado(color: Colors.purple[300]),
            crearBotonRedondeado(texto: 'Alarma',),
          ]
        ),
        TableRow(
          children: [
            crearBotonRedondeado(color: Colors.blue, texto: 'Cartel loco', icono: Icons.all_inclusive),
            crearBotonRedondeado(color: Colors.yellow),
          ]
        ),
        TableRow(
          children: [
            crearBotonRedondeado(icono: Icons.aspect_ratio, color: Colors.white70),
            crearBotonRedondeado(),
          ]
        ),
        TableRow(
          children: [
            crearBotonRedondeado(),
            crearBotonRedondeado(),
          ]
        ),
      ],
    );
  }
  
  Widget crearBotonRedondeado({Color color: Colors.pinkAccent, String texto: 'Algo', IconData icono: Icons.alarm}){
    
    return Container(
      height: 180.0,
      margin: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(62, 66, 107, 0.7),
        borderRadius: BorderRadius.circular(30.0)
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget> [
          SizedBox(height: 5.0,),
          CircleAvatar(
            backgroundColor: color,
            radius: 35.0,
            child: Icon( icono, color: Colors.white, size: 30.0 ),
            ),
            Text(texto, style: TextStyle(color: color),),
            SizedBox(height: 5.0,),
        ]
      )
    );
  }
