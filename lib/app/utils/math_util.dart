
//! Archivo que contiene funciones utiles para la realizacion de calculos:

List<int> rango = [100,150,200,250,300,350,500,1000,5000];
List<double> precios = [0.4,1.3,1.75,3.0,4.0,7.50,9.0,10.0,15.0,25.0];


/**
 *  Usada para calcular el costo en moneda nacional del consumo electrico.
 *  _________________________________________________________
 *     Tarifa usada 2021
 *  _________________________________________________________
 *     Rango      Consumo(kWh)    Precio(CUP)     Importe(CUP)
 *  _________________________________________________________
 *     0-100                      0.40
 *  _________________________________________________________
 *     101-150                    1.30
 *  _________________________________________________________
 *     151-200                    1.75
 *  _________________________________________________________
 *     201-250                    3.00
 *  _________________________________________________________
 *     251-300                    4.00
 *  _________________________________________________________
 *     301-350                    7.50
 *  _________________________________________________________
 *     351-500                    9.00
 *  _________________________________________________________
 *     501-1000                   10.00
 *  _________________________________________________________
 *     1001-5000                  15.00
 *  _________________________________________________________
 *     +5000                      25.00
 *  _________________________________________________________
 * 
 */

double calcCosto(int consumo){ //170

  double costoAcumulado = 0.0;
  List<double> precioXrango = [];
  List<int> consumoXrango = [];
  double costoTotal = 0.0;

  for(int index = 0; index<=rango.length; index++){
    

    if(consumo > rango[index]){
      // 100*0.4 | (150-100)*1.3 | (170-150)*1.75
      int consumoRango = (rango[index] - ((index == 0)? 0:rango[index-1]));
      consumoXrango.add(consumoRango);

      costoAcumulado =  consumoRango * precios[index]; 
      precioXrango.add(costoAcumulado);
      costoTotal += costoAcumulado;
    } else { //iteracion final
      
      int consumoRango = ( consumo - ((index == 0)? 0:rango[index-1]) );
      consumoXrango.add(consumoRango);

      costoAcumulado = consumoRango * precios[index];
      precioXrango.add(costoAcumulado);
      costoTotal += costoAcumulado;
      
      index = 10; //para que salga del bucle for()
    }
  }


  print("| $consumoXrango | $precioXrango"); 
  return costoTotal;
}