import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/paciente.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  DatabaseHelper.internal();
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes3.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE paciente(id INTEGER PRIMARY KEY, nome TEXT, idade TEXT, sexo TEXT, peso TEXT)');
  }

  Future<int> insertOnePaciente(Paciente paciente) async {
    var dbClient = await db;
    var result = await dbClient.insert("paciente", paciente.toMap());
    return result;
  }

  Future<List> getAllPacientes() async {
    var dbClient = await db;
    var result = await dbClient
        .query("paciente", columns: ["id", "nome", "idade", "sexo", "peso"]);
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM paciente'));
  }

  Future<Paciente> getPaciente(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query("paciente",
        columns: ["id", "nome", "idade", "sexo", "peso"],
        where: 'id = ?',
        whereArgs: [id]);
    if (result.length > 0) {
      return new Paciente.fromMap(result.first);
    }
    return null;
  }

  Future<int> deletePaciente(int id) async {
    var dbClient = await db;
    return await dbClient.delete("paciente", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updatePaciente(Paciente paciente) async {
    var dbClient = await db;
    return await dbClient.update("paciente", paciente.toMap(),
        where: "id = ?", whereArgs: [paciente.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
