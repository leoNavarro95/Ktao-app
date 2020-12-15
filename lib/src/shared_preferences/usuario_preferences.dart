import 'package:shared_preferences/shared_preferences.dart';

//OJO este método para trabajar con almacenamiento persistenente en nuestra app puede ser implementado fácilmente con esta clase.
//Debe poner el sigiente código en el main.dart:
/**
 * import 'package:healthCalc/src/shared_preferences/usuario_preferences.dart';
 * 
 * void main() async{
 * 
 * WidgetsFlutterBinding.ensureInitialized();
 * final prefs = new PreferenciasUsuario();
 * await prefs.initPrefs();
 * 
 * runApp(MyApp());
 * }
 */

//patrón singleton: busca que todas las instancias implementadas de esta clase sean las mismas, cada vez que se haga un new para una instancia nueva va a ser la misma para todas

/*
   * @brief
   * en ingenieria de software, singleton o instancia unica es un patron de diseno que permite restringir la creacion 
   * de onjetos pertenecientes a una clase o el valor de un tipo a un unico objeto. Su intención consiste en 
   * garantizar que una clase solo tenga una instancia y proporcionar un punto de acceso global a ella. Las situaciones mas habituales de aplicacion de este patron son aquellas en as que dicha clase conrola el acceso a un recurso fisico unico o cuando cierto tipo de datos debe estar disponible para todos los demas objetos de la app
   */

class PreferenciasUsuario {
  //la instancia de la misma clase se implementa dentro de ella misma, y se define como privada para que no pueda ser instanciada externamente y así controlar que esta sea la unica instancia en toda la app
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  //constructor por defecto, cada vez que se quiera hacer una "nueva" instancia de la clase, este constructor siempre devuelve la misma instancia para todas
  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  //permite tener el acceso al almacenamiento persistente del dispositivo
  SharedPreferences _prefs;

  /**
     * SharedPreferences permite guardar datos persistentes en el teléfono de una manera sencilla
     * Se debe usar para estructuras de datos sencillas, algo como las preferencias de 
     * la aplicación, color, en qué página se quedó, usuario, configuración y demás; 
     * permite no complicarnos con estructuras complejas de BBDD para algo que no lo requiere.
     */

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del género

  get genero {
    return _prefs.getInt('genero') ??
        1; // si no existe el género la propiedad por defecto será un 1
  }

  set genero(int value) {
    _prefs.setInt('genero', value);
  }

  // GET y SET del colorSecundario

  get colorSecundario {
    return _prefs.getBool('colorSecundario') ??
            false; // si no existe el campo se setea la propiedad por defecto
  }

  set colorSecundario( bool value ) {
    _prefs.setBool('colorSecundario', value);
  }

  // GET y SET del nombreUser

  get nombreUser {
    return _prefs.getString('nombreUser') ??
            'sin nombre'; // si no existe el campo se setea la propiedad por defecto
  }

  set nombreUser( String value ) {
    _prefs.setString('nombreUser', value);
  }

  // GET y SET de la última página

  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ??
            'home'; // si no existe el campo se setea la propiedad por defecto
  }

  set ultimaPagina( String value ) {
    _prefs.setString('ultimaPagina', value);
  }

  get estatura {
    return _prefs.getDouble('estatura') ?? 0.0;
  }
  
  set estatura( double val){
    _prefs.setDouble('estatura', val);
  }

  get peso {
    return _prefs.getDouble('peso') ?? 0.0;
  }

  set peso(double value){
    _prefs.setDouble('peso', value);
  }

  get imc {
    return _prefs.getDouble('imc') ?? 0.0;
  }

  set imc(double value){
    _prefs.setDouble('imc', value);
  }

}
