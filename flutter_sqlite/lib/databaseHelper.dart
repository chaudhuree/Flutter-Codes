import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'models/todo.dart';
import 'models/user.dart';

// Singleton class to manage the SQLite database
class DatabaseHelper {
  // Private static variable to hold the database instance
  static Database? _database;

  // Singleton instance of DatabaseHelper
  static final DatabaseHelper instance = DatabaseHelper._();

  // Private constructor to prevent external instantiation
  DatabaseHelper._();

  // Getter for the database instance (lazy-loaded)
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database, or open it if already exists
  Future<Database> _initDatabase() async {
    // Get the directory where the database file will be stored
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // Define the path to the database file
    String path = join(documentsDirectory.path, 'user.db');

    // Open the database, creating it if it doesn't exist
    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate, // Called when the database is first created
      onUpgrade: _onUpgrade, // Called when the database is upgraded
    );
  }

  // Create the tables in the database
  Future<void> _onCreate(Database db, int version) async {
    // Create the 'users' table
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT
      )
    ''');

    // Create the 'todos' table
    await db.execute('''
      CREATE TABLE todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        completed INTEGER DEFAULT 0,
        userId INTEGER,
        FOREIGN KEY (userId) REFERENCES users (id)
      )
    ''');
  }

  // Helper method to check if a column exists in a table
  Future<bool> _columnExists(
    Database db,
    String tableName,
    String columnName,
  ) async {
    var result = await db.rawQuery("PRAGMA table_info($tableName)");
    return result.any((column) => column['name'] == columnName);
  }

  // Handle database upgrades
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // If upgrading from version 1, create the 'todos' table
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE todos(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          userId INTEGER,
          FOREIGN KEY (userId) REFERENCES users (id)
        )
      ''');
    }

    // If upgrading from version 2, add 'completed' column to 'todos' table
    if (oldVersion < 3) {
      bool columnExists = await _columnExists(db, 'todos', 'completed');
      if (!columnExists) {
        await db.execute(
          'ALTER TABLE todos ADD COLUMN completed INTEGER DEFAULT 0',
        );
      }
    }
  }

  // **User-related CRUD operations**

  // Insert a user into the 'users' table
  Future<int> insertUser(User user) async {
    Database db = await database;
    return await db.insert('users', user.toMap());
  }

  // Get all users from the 'users' table
  Future<List<User>> getUsers() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  // Update a user's information
  Future<int> updateUser(User user) async {
    Database db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // Delete a user from the 'users' table
  Future<int> deleteUser(int id) async {
    Database db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // **Todo-related CRUD operations**

  // Insert a todo into the 'todos' table
  Future<int> insertTodo(Todo todo) async {
    Database db = await database;
    return await db.insert('todos', todo.toMap());
  }

  // Get all todos for a specific user
  Future<List<Todo>> getTodosByUser(int userId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'todos',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  // Update a todo's information
  Future<int> updateTodo(Todo todo) async {
    Database db = await database;
    return await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  // Update a todo's completed status
  Future<int> updateTodoCompleted(int id, bool completed) async {
    Database db = await database;
    return await db.update(
      'todos',
      {'completed': completed ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete a todo from the 'todos' table
  Future<int> deleteTodo(int id) async {
    Database db = await database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
