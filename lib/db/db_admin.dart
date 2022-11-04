import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sqflite/sqflite.dart';

import '../models/task_model.dart';

class DBAdmin {
  Database? myDatabase;

  //singleton
  static final DBAdmin db = DBAdmin._();
  DBAdmin._();

  Future<Database?> checkDatabase() async {
    if (myDatabase != null) {
      return myDatabase;
    }

    myDatabase = await initBatabase(); //Crear base de datos
    return myDatabase;
  }

  Future<Database> initBatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "TaskDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database dbx, int version) {
        //crear la tabla correspondiente
        dbx.execute(
            "CREATE TABLE TASK(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, status TEXT)");
      },
    );
  }

  Future<int> insertRawTask(TaskModel model) async {
    Database? db = await checkDatabase();
    int res = await db!.rawInsert(
      "INSERT INTO TASK(title, description, status) VALUES ('${model.title}','${model.description}','${model.status.toString()}')",
    );
    return res;
  }

  Future<int> insertTask(TaskModel model) async {
    Database? db = await checkDatabase();
    int res = await db!.insert(
      "TASK",
      {
        "title": model.title,
        "description": model.description,
        "status": model.status,
      },
    );
    return res;
  }

  getRawTask() async {
    Database? db = await checkDatabase();
    List tasks = await db!.rawQuery("SELECT * FROM Task");
    print(tasks);
  }

  Future<List<TaskModel>> getTask() async {
    Database? db = await checkDatabase();
    List<Map<String, dynamic>> tasks = await db!.query("Task");
    List<TaskModel> taskModelList =
        tasks.map((e) => TaskModel.deMapModel(e)).toList();

    // tasks.forEach(
    //   (element) {
    //     TaskModel task = TaskModel.deMapModel(element);
    //     taskModelList.add(task);
    //   },
    // );
    print(taskModelList);
    return taskModelList;
  }

  updateRawTask() async {
    Database? db = await checkDatabase();
    int res = await db!.rawUpdate(
        "UPDATE Task SET title = 'tarea 1', description ='descripcion de tarea 1', status='true' WHERE id =  1");
    print(res);
  }

  updateTask() async {
    Database? db = await checkDatabase();
    db!.update(
      "Task",
      {
        "title": "tarea 2",
        "description": "descripcion tarea 2",
        "status": "true",
      },
      where: "id = 2",
    );
  }

  deleteRawTask() async {
    Database? db = await checkDatabase();
    int res = await db!.rawDelete("DELETE FROM TASK WHERE id = 2");
    print(res);
  }

  Future<int> deleteTask(int id) async {
    Database? db = await checkDatabase();
    int res = await db!.delete(
      "TASK",
      where: "id = $id",
    );
    return res;
  }
}
