//! Archivo que contiene funciones utiles para la realizacion de calculos:

List<int> rango = [
  100,
  150,
  200,
  250,
  300,
  350,
  400,
  450,
  500,
  600,
  700,
  1000,
  1800,
  2600,
  3400,
  4200,
  5000
];
List<double> precios = [
  0.33,
  1.07,
  1.43,
  2.46,
  3.00,
  4.00,
  5.00,
  6.00,
  7.00,
  9.20,
  9.45,
  9.85,
  10.80,
  11.80,
  12.90,
  13.95,
  15.00,
  20.00
];

//*Para mostrar en la tabla, no se usa en este archivo
List<String> rangos = [
  '0 a 100',
  '101 a 150',
  '151 a 200',
  '201 a 250',
  '251 a 300',
  '301 a 350',
  '351 a 400',
  '401 a 450',
  '451 a 500',
  '501 a 600',
  '601 a 700',
  '701 a 1000',
  '1001 a 1800',
  '1801 a 2600',
  '2601 a 3400',
  '3401 a 4200',
  '4201 a 5000',
  '+ 5000'
];

///*  Usada para calcular el costo en moneda nacional del consumo electrico.
///*  _________________________________________________________
///*     Tarifa usada 2021
///*  _________________________________________________________
///*     Rango      Consumo(kWh)    Precio(CUP)     Importe(CUP)
///*  _________________________________________________________
///*     0-100                      0.40
///*  _________________________________________________________
///*     101-150                    1.30
///*  _________________________________________________________
///*     151-200                    1.75
///*  _________________________________________________________
///*     201-250                    3.00
///*  _________________________________________________________
///*     251-300                    4.00
///*  _________________________________________________________
///*     301-350                    7.50
///*  _________________________________________________________
///*     351-500                    9.00
///*  _________________________________________________________
///*     501-1000                   10.00
///*  _________________________________________________________
///*     1001-5000                  15.00
///*  _________________________________________________________
///*     +5000                      25.00
///*  _________________________________________________________
///*

Map<String, dynamic> calcCosto(double consumo) {
  //170
  double costoAcumulado = 0.0;
  List<double> precioXrango = [];
  List<double> consumoXrango = [];
  double costoTotal = 0.0;

  for (int index = 0; index < rango.length; index++) {
    if (consumo > rango[index]) {
      // 100*0.4 | (150-100)*1.3 | (170-150)*1.75
      double consumoRango =
          (rango[index] - ((index == 0) ? 0 : rango[index - 1])).toDouble();
      consumoXrango.add(consumoRango);

      costoAcumulado = consumoRango * precios[index];
      precioXrango.add(costoAcumulado);
      costoTotal += costoAcumulado;
    } else {
      //iteracion final

      double consumoRango = (consumo - ((index == 0) ? 0 : rango[index - 1]));
      consumoXrango.add(consumoRango);

      costoAcumulado = consumoRango * precios[index];
      precioXrango.add(costoAcumulado);
      costoTotal += costoAcumulado;

      break;
    }
  }
  if (consumo > 5000) {
    double consumoResto = consumo - 5000;
    consumoXrango.add(consumoResto);
    costoAcumulado = consumoResto * precios[precios.length - 1];
    precioXrango.add(costoAcumulado);
    costoTotal += costoAcumulado;
  }

  return {
    "costo": costoTotal,
    "listaConsumo": consumoXrango,
    "listaPrecio": precioXrango,
  };
}

/// retorna un map con los valores extremos de la lista. 
/// si list = [50, -25, 100], 
/// retorna {"minValue": -25,"maxValue": 100, }
Map<String, num> utilgetExtremeValues(List<num> list) {
  //list = [50, -25, 100]
  final List<num> sortList = list.toList();
  sortList.sort(); // list = [-25, 50, 100]
  final minValue = sortList[0];
  final maxValue = sortList[sortList.length - 1];

  return {
    "minValue": minValue,
    "maxValue": maxValue,
  };
}

///recorre la lista de double y devuelve true cuando tiene algun numero negativo
bool utilHasNegativeData(List<double> numList){
  for(double numb in numList){
    if(numb.isNegative)
      return true;
  }
  return false;
}
