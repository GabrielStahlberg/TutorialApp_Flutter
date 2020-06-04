import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tutorial_app/widgets/notes/model/Note.dart';

class DatabaseNotesHelper {

  static final String tableName = "note";
  static final DatabaseNotesHelper _databaseHelper = DatabaseNotesHelper._internal();
  Database _db;

  factory DatabaseNotesHelper() {
    return _databaseHelper;
  }

  DatabaseNotesHelper._internal() {}

  get db async {
    return _db == null ? await initDb() : _db;
  }

  _onCreate(Database db, int version) async {
    String sql = "CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR, description TEXT, date DATETIME)";
    await db.execute(sql);
  }

  initDb() async {
    final databasePath = await getDatabasesPath();
    final databaseLocal = join(databasePath, "notes_db");

    var db = await openDatabase(databaseLocal, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<int> save(Note note) async {
    var dataBase = await db;
    int result = await dataBase.insert(tableName, note.convertToMap());
    return result;
  }

  Future<int> update(Note note) async {
    var dataBase = await db;
    return await dataBase.update(
      tableName,
      note.convertToMap(),
      where: "id = ?",
      whereArgs: [note.id]
    );
  }

  Future<int> delete(int id) async {
    var dataBase = await db;
    return await dataBase.delete(
        tableName,
        where: "id = ?",
        whereArgs: [id]
    );
  }

  findAll() async {
    var dataBase = await db;
    String sql = "SELECT * FROM $tableName ORDER BY date DESC";
    List notes = await dataBase.rawQuery(sql);
    return notes;
  }
}