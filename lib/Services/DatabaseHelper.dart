import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Models/Company.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('companies.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE companies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        icon TEXT NOT NULL,
        category TEXT NOT NULL,
        address TEXT NOT NULL,
        phone TEXT NOT NULL,
        webPage TEXT NOT NULL,
        lon REAL NOT NULL,
        lat REAL NOT NULL,
        email TEXT NOT NULL
      )
    ''');
  }

  // CREATE
  Future<int> insertCompany(Company company) async {
    final db = await database;
    return await db.insert('companies', company.toMap());
  }

  // READ ALL
  Future<List<Company>> getAllCompanies(String type) async {
    final db = await database;
    final result = await db.query('companies', where: 'category = ?', whereArgs: [type]);
    return result.map((map) => Company.fromMap(map)).toList();
  }


  Future close() async {
    final db = await database;
    db.close();
  }
}