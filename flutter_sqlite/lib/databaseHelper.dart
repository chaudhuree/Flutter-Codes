import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// Define a model for the data you want to store (User in this case)
class User {
  final int? id;
  final String name;
  final String email;

  User({this.id, required this.name, required this.email});

  // Convert a User object into a Map so it can be inserted into the database
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email};
  }

  // Convert a Map into a User object
  factory User.fromMap(Map<String, dynamic> map) {
    return User(id: map['id'], name: map['name'], email: map['email']);
  }
}

// Define a model for Todo
class Todo {
  final int? id;
  final String title;
  bool completed = false;
  final int userId;

  Todo({
    this.id,
    required this.title,
    this.completed = false,
    required this.userId,
  });

  // Convert a Todo object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed ? 1 : 0,
      'userId': userId,
    };
  }

  // Convert a Map into a Todo object
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      completed: map['completed'] == 1,
      userId: map['userId'],
    );
  }
}

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._();

  DatabaseHelper._();

  // Open the database, or create it if it doesn't exist
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'user.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // Create tables
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        completed INTEGER,
        userId INTEGER,
        FOREIGN KEY (userId) REFERENCES users (id)
      )
    ''');
  }

  // Upgrade database
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
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
  }

  // Insert a user into the database
  Future<int> insertUser(User user) async {
    Database db = await database;
    return await db.insert('users', user.toMap());
  }

  // Get all users from the database
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

  // Delete a user
  Future<int> deleteUser(int id) async {
    Database db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // Insert a todo into the database
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

  // Update a todo
  Future<int> updateTodo(Todo todo) async {
    Database db = await database;
    return await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  // Delete a todo
  Future<int> deleteTodo(int id) async {
    Database db = await database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
