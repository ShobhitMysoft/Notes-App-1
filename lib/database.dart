import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> MyDatabase() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(

    join(await getDatabasesPath(), 'task_databse.db'),

    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE tasks(id INTEGER PRIMARY KEY, completed INTEGER, task STRING)',
      );
    },

    version: 1
  );

  Future<void> insertTask(Task task) async {
    final db = await database;

    await db.insert('tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Task>> tasks() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
        return Task(id: maps[i]['id'], completed: maps[i]['completed'], task: maps[i]['task']);
      }
    );
  }

}

// Data Model Class
class Task {
  final int id;
  final int completed;
  final String task;

  const Task({
    required this.id,
    required this.completed,
    required this.task
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'completed': completed,
      'task': task,
    };
  }
  
  @override
  String toString() {
    return 'Task{id: $id, completed: $completed, task: $task}';
  }
}