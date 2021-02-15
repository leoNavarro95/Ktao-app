import 'package:get/get.dart';
import 'package:healthCalc/app/data/model/lectura_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:healthCalc/app/data/model/contador_model.dart';
export 'package:healthCalc/app/data/model/contador_model.dart';

/// motor de la base da datos de la aplicacion basada en sqlite

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();
  // implementando un constructor privado para hacer patron Singleton
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  //Constanes
  static final String databaseName = 'ktao11.db'; //nombre de la base de datos
  static int version = 9;

  //Parametros de la tabla: contadores
  static final String contadoresTable = 'contadores';
  static final String columnContadoresId = 'id';
  static final String columnContadoresNombre = 'nombre';
  static final String columnContadoresConsumo = 'consumo';
  static final String columnContCostoMesActual = 'costoMesActual';
  static final String columnContUltimaLectura = 'ultimaLectura';

  //Sentencias SQL para crear la tabla contadores
  static final String createTableContadores = 'CREATE TABLE $contadoresTable ('
      ' $columnContadoresId INTEGER PRIMARY KEY,'
      ' $columnContadoresNombre TEXT NOT NULL,'
      " $columnContadoresConsumo INTEGER DEFAULT '0',"
      " $columnContCostoMesActual REAL DEFAULT '0.0',"
      " $columnContUltimaLectura TEXT DEFAULT 'no fecha'"
      ')';

  ///Parametros de la tabla: lecturas
  static final String lecturasTable = 'lecturas';
  static final String columnLecturasId = 'id';
  static final String columnLecturasLect = 'lectura';
  static final String columnLecturasFecha = 'fecha';
  static final String columnLecturasContadorId = 'id_contador';
  static final String columnIsRecibo = 'is_recibo';

  //Sentencias SQL para crear la tabla Lecturas
  static final String createTableLecturas = 'CREATE TABLE $lecturasTable ('
      ' $columnLecturasId INTEGER PRIMARY KEY,'
      ' $columnLecturasLect REAL NOT NULL,'
      " $columnLecturasFecha TEXT DEFAULT 'no disponible',"
      ' $columnLecturasContadorId INTEGER,'
      " $columnIsRecibo INTEGER,"
      ' FOREIGN KEY($columnLecturasContadorId) REFERENCES $contadoresTable($columnContadoresId) ON DELETE CASCADE'
      ')';

  initDB() async {
    // Get a location using getDatabasesPath
    String databasesPath =
        await getDatabasesPath(); //obtiene el path en donde se ubican los datos de la aplicacion
    final path = join(databasesPath,
        databaseName); //se le agrega el nombre del archivo .db donde se va a almacenar la bbdd

    return await openDatabase(path,
        version: version,
        onOpen: (db) {},
        // onCreate callback se ejecuta ya una vez creada la base de datos
        onCreate: _onCreate,
        onConfigure: _onConfigure,
        onUpgrade: _onUpgrade);
  }

  static Future _onCreate(Database db, int version) async {
    //se usa para crear las tablas de la base de datos,
    //si ya existe una instancia db creada no la vuelve a crear,
    await db.execute(createTableContadores); //se crea la tabla contadores
    await db.execute(createTableLecturas); //se crea la tabla lecturas
  }

  static Future _onConfigure(Database db) async {
    //Permite usar las foreign keys
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    Batch batch = db.batch();

    //primero se eliminan las tablas si existen en la base de datos
    batch.execute('DROP TABLE IF EXISTS $contadoresTable ;');
    batch.execute('DROP TABLE IF EXISTS $lecturasTable ;');
    //luego se vuelven a crear
    batch.execute(createTableContadores);
    batch.execute(createTableLecturas);

    await batch.commit();
  }

  /// Guarda en la Base de Datos una nueva instancia de ContadorModel
  /// Se le pasa una instancia del [nuevoContador] la cual sera guardada en la base de datoss
  /// de los contadores
  Future<int> nuevoContador(ContadorModel nuevoContador) async {
    //antes de empezar a usar la base de datos es necesario asegurar que esta ya esta disponible
    final db = await database;
    final resultado = await db.insert(contadoresTable, nuevoContador.toJson());

    return resultado;
  }

  /// Retorna una instancia de Contador dado un [id] presente en la base de datos
  ///!!! si el [id] no se encuentra en la tabla devuelve null
  Future<ContadorModel> getContadorById(int id) async {
    //* await db.rawQuery("SELECT * FROM $contadoresTable WHERE id='$id'");

    final db = await database;
    final resultado = await db
        .query(contadoresTable, where: 'id = ?', whereArgs: [
      id
    ]); //se encuesta la tabla en busqueda de un id que sea igual al id pasado como parametro
    return resultado.isNotEmpty
        ? ContadorModel.fromJson(resultado.first)
        : null;
  }

  Future<List<ContadorModel>> getTodosContadores() async {
    final db = await database;
    final resultado = await db.query(contadoresTable);

    List<ContadorModel> list = resultado.isNotEmpty
        ? resultado.map((e) => ContadorModel.fromJson(e)).toList()
        : []; //si esta vacia la base de datos returna una lista empty

    return list;
  }

  //Actualizar registros
  Future<int> updateContador(
      ContadorModel contadorUpdated, ContadorModel newContador) async {
    // Es necesario que se mantenga el mismo id
    if (newContador.id != contadorUpdated.id) {
      throw Error();
    } else {
      final db = await database;
      final resultado = await db.update(contadoresTable, newContador.toJson(),
          where: 'id = ?',
          whereArgs: [
            contadorUpdated.id
          ] //para solo actualizar el registro que posea ese id
          );
      return resultado; //retorna un entero con la cantidad de registros modificados
    }
  }

  // Borrar registros
  ///Borra de la base de datos el contador con el [id] pasado
  Future<int> deleteContador(int id) async {
    final db = await database;
    final resultado =
        await db.delete(contadoresTable, where: 'id = ?', whereArgs: [id]);
    Get.back(); //para cerrar el bottom_sheet
    return resultado; //entero con la cantidad de registros eliminados
  }

  ///Borra todos los contadores, pero deja la tabla creada
  Future<int> deleteallContadores() async {
    // final resultado = await db.delete('$contadoresTable');
    final db = await database;
    final resultado = await db.rawDelete('DELETE FROM $contadoresTable');
    return resultado; //entero con la cantidad de registros eliminados
  }

  //Queries a LECTURA en la Base de datos

  ///Se le pasa como parametro el contador a instertar la lectura y la lectura en si, dentro se
  ///encarga de igualar el foreign key de lectura con el id del contador
  Future<int> insertarLectura(LecturaModel lectura) async {
    final db = await database;
    final resultado = await db.insert(lecturasTable, lectura.toJson());
    return resultado;
  }

  ///Retorna una lista de las lecturas tomadas para el contador que se le pase como parametro
  Future<List<LecturaModel>> getLecturasByContador(
      ContadorModel contador) async {
    //* await db.rawQuery("SELECT * FROM $lecturasTable WHERE id_contador='$contador.id'");

    final db = await database;
    final resultado = await db
        .query(lecturasTable, where: 'id_contador = ?', whereArgs: [
      contador.id
    ]); //se encuesta la tabla en busqueda de un id que sea igual al id pasado como parametro
    final lecturasByContador = resultado.isNotEmpty
        ? resultado.map((e) => LecturaModel.fromJson(e)).toList()
        : null;
    return lecturasByContador;
  }

  Future<LecturaModel> getLecturasById(int id) async {
    final db = await database;
    final resultado =
        await db.query(lecturasTable, where: 'id = ?', whereArgs: [id]);
    return resultado.isNotEmpty ? LecturaModel.fromJson(resultado.first) : null;
  }

  ///Borra de la base de datos la lectura con el [id] pasado
  Future<int> deleteLectura(int id) async {
    final db = await database;
    final resultado =
        await db.delete(lecturasTable, where: 'id = ?', whereArgs: [id]);
    return resultado; //entero con la cantidad de registros eliminados, debe ser igual a 1
  }

  Future<List<LecturaModel>> getTodasLecturas() async {
    final db = await database;
    final resultado = await db.query(lecturasTable);

    List<LecturaModel> list = resultado.isNotEmpty
        ? resultado.map((e) => LecturaModel.fromJson(e)).toList()
        : []; //si esta vacia la base de datos returna una lista empty
    return list;
  }

  //Uso de la sentencia LIKE para encontrar patrones en la base de datos:
  /**
   * The following statement finds the tracks whose names contain: zero or more characters (%), followed
   * by Br, followed by a character ( _), followed by wn, and followed by zero or more characters ( %).
   *  * SELECT trackid, name FROM tracks WHERE name LIKE '%Br_wn%';
   */

  /// Devuelve las lecturas del [contador] dado encerradas en un mes y un anho. [fechaPattern] debe tener esta forma: /MM/YYYY, para que busque las lecturas tomadas en tal mes/anho
  Future<List<LecturaModel>> getLecturasByFechaPattern(
      ContadorModel contador, String fechaPattern) async {
    final db = await database;
    final resultado = await db.rawQuery(
        "SELECT * FROM $lecturasTable WHERE id_contador='${contador.id}' AND $columnLecturasFecha LIKE '%$fechaPattern'");
    List<LecturaModel> list = resultado.isNotEmpty
        ? resultado.map((e) => LecturaModel.fromJson(e)).toList()
        : []; //si esta vacia la base de datos returna una lista empty
    return list;
  }

  ///Comprueba si para el mes dado ya existe lectura de recibo, retorna true si ya existe tal lectura y false sino. En caso de existir una lectura de recibo no se debe permitir introducir mas lecturas para ese mes pues este ya esta "cerrado". [fechaPattern] debe ser en el formato /MM/YYYY
  Future<bool> isMonthClosedDB(
      ContadorModel contador, String fechaPattern) async {
    final db = await database;
    final resultado = await db.rawQuery(
        "SELECT * FROM $lecturasTable WHERE $columnLecturasContadorId='${contador.id}' AND $columnLecturasFecha LIKE '%$fechaPattern' AND $columnIsRecibo='1' ");
    List<LecturaModel> list = resultado.isNotEmpty
        ? resultado.map((e) => LecturaModel.fromJson(e)).toList()
        : []; //si esta vacia la base de datos returna una lista empty

    bool mesCerrado = false; //indica que ya el mes tiene lectura de recibo
    if (list.isNotEmpty) {
      print(
          'existen ${list.length} lecturas de recibo para la fecha $fechaPattern');
      mesCerrado = true;
    }
    return mesCerrado;
  }
}
