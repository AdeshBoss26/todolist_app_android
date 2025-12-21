import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("todo.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        title TEXT NOT NULL,
        description TEXT,
        isDone INTEGER NOT NULL,
        FOREIGN KEY (userId) REFERENCES users(id)
      )
    ''');
  }

  // Insert User
  Future<int> insertUser(Map<String, dynamic> row) async {
    final db = await database;
    return await db.insert('users', row);
  }

  // Validate Login
  Future<Map<String, dynamic>?> validateUser(
      String username, String password) async {
    final db = await database;
    final res = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    return res.isNotEmpty ? res.first : null;
  }

  // Insert Task
  Future<int> insertTask(Map<String, dynamic> row) async {
    final db = await database;
    return await db.insert('tasks', row);
  }

  // Get Tasks by User
  Future<List<Map<String, dynamic>>> getTasks(int userId,
      {bool completed = false}) async {
    final db = await database;
    return await db.query(
      'tasks',
      where: 'userId = ? AND isDone = ?',
      whereArgs: [userId, completed ? 1 : 0],
    );
  }

  // Update Task
  Future<int> updateTask(int id, Map<String, dynamic> row) async {
    final db = await database;
    return await db.update('tasks', row, where: 'id = ?', whereArgs: [id]);
  }

  // Delete Task
  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
