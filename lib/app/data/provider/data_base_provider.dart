import 'package:healthCalc/app/data/model/contador_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// motor de la base da datos de la aplicacion basada en sqlite

class DBProvider{

  static Database _database;
  // implementando un constructor privado para hacer patron Singleton
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Future<Database> get database async {
    
    if( _database != null ){
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath(); //obtiene el path en donde se ubican los datos de la aplicacion
    String path = join(databasesPath, 'Ktao.db'); //se le agrega el nombre del archivo .db donde se va a almacenar la bbdd

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},

      // onCreate callback se ejecuta ya una vez creada la base de datos
      onCreate: (Database db , int version) async {
        //se usa para crear las tablas de la base de datos,
        //si ya existe una instancia db creada no la vuelve a crear,
        await db.execute(
          'CREATE TABLE Contadores('  //! OJO con el nombre de la tabla
          ' id INTERGER PRIMARY KEY,' // id auto-incrementado
          ' nombre TEXT,'             // nombre del contador (dado por el usuario)
          ' consumo_mes INTERGER,'    //consumo antes de cerrar el mes
          ' costo_actual REAL,'       //OJO hay que definirlo como num en dart
          ' ultima_lectura TEXT'      //va a ser un string con la fecha y hora
          ')'
        );


      }
      );


  }

  /// Metodo para guardar en la Base de Datos una nueva instancia de ContadorModel
  /// Se le pasa una instancia del [nuevoContador] la cual sera guardada en la base de datoss
  /// de los contadores
  nuevoContador( ContadorModel nuevoContador ) async {

    //antes de empezar a usar la base de datos es necesario asegurar que esta ya esta disponible
    final db        = await database;
    final resultado = await db.insert('Contadores', nuevoContador.toJson());

    return resultado;

  }


  /// Retorna una instancia de Contador dado un [id] presente en la base de datos
  ///!!! si el [id] no se encuentra en la tabla devuelve null
  Future<ContadorModel> getContadorId (int id) async {
    //* await db.rawQuery("SELECT * FROM Contadores WHERE id='$id'");
    
    final db        = await database;
    final resultado = await db.query('Contadores', where: 'id = ?', whereArgs: [id]); //se encuesta la tabla en busqueda de un id que sea igual al id pasado como parametro
    return resultado.isNotEmpty ? ContadorModel.fromJson( resultado.first ) : null;

  }

  Future<List<ContadorModel>> getTodosContadores() async {
    
    final db        = await database;
    final resultado = await db.query('Contadores');

    List<ContadorModel> list = resultado.isNotEmpty 
                                ? resultado.map((e) => ContadorModel.fromJson(e)).toList()
                                : []; //si esta vacia la base de datos returna una lista empty

    return list;
  }

  //Actualizar registros

  Future<int> updateContador( ContadorModel contadorUpdated ) async {

    final db        = await database;
    final resultado = await db.update(
      'Contadores', 
      contadorUpdated.toJson(), 
      where: 'id = ?', 
      whereArgs: [contadorUpdated.id] //para solo actualizar el registro que posea ese id
    ); 
    
    return resultado; //retorna un entero con la cantidad de registros modificados
  }

  // Borrar registros
  ///Borra de la base de datos el contador con el [id] pasado
  Future<int> deleteContador( int id) async {

    final db        = await database;
    final resultado = await db.delete('Contadores', where: 'id = ?', whereArgs: [id]);
    return resultado; //entero con la cantidad de registros eliminados

  }

  ///Borra todos los contadores, pero deja la tabla creada
  Future<int> deleteallContadores() async {

    // final resultado = await db.delete('Contadores');
    final db        = await database;
    final resultado = await db.rawDelete('DELETE FROM Contadores');
    return resultado; //entero con la cantidad de registros eliminados

  }

}
