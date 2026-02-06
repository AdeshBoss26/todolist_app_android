import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
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
      version: 2,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // 1️⃣ USERS TABLE
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');

    // 2️⃣ TASKS TABLE
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

    // 3️⃣ PROFILE TABLE
    await db.execute('''
      CREATE TABLE profile (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        fullName TEXT,
        email TEXT,
        phone TEXT,
        FOREIGN KEY (userId) REFERENCES users(id)
      )
    ''');

    // 4️⃣ SETTINGS TABLE
    await db.execute('''
      CREATE TABLE settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        darkMode INTEGER,
        notifications INTEGER,
        FOREIGN KEY (userId) REFERENCES users(id)
      )
    ''');

    // 5️⃣ APP INFO TABLE
    await db.execute('''
      CREATE TABLE app_info (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        appName TEXT,
        version TEXT,
        developer TEXT
      )
    ''');
  }

  // ---------- EXISTING METHODS (unchanged) ----------

  Future<int> insertUser(Map<String, dynamic> row) async {
    final db = await database;
    return await db.insert('users', row);
  }

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

  // ✅ STEP 1 — Add new methods here

  // Get user by ID
  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await database;
    final res = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    return res.isNotEmpty ? res.first : null;
  }

  // Update username
  Future<int> updateUser(int id, String username) async {
    final db = await database;
    return await db.update(
      'users',
      {'username': username},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> insertTask(Map<String, dynamic> row) async {
    final db = await database;
    return await db.insert('tasks', row);
  }

  Future<List<Map<String, dynamic>>> getTasks(int userId,
      {bool completed = false}) async {
    final db = await database;
    return await db.query(
      'tasks',
      where: 'userId = ? AND isDone = ?',
      whereArgs: [userId, completed ? 1 : 0],
    );
  }

  Future<int> updateTask(int id, Map<String, dynamic> row) async {
    final db = await database;
    return await db.update('tasks', row,
        where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete('tasks',
        where: 'id = ?', whereArgs: [id]);
  }
}
