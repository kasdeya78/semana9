import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sqflite/sqflite.dart';

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

  insertRawTask() async {
    Database? db = await checkDatabase();
    int rest = await db!.rawInsert(
      "INSERT INTO TASK(title, description, status) VALUES ('Ir de compras','comprar para la semana al mercado','false')",
    );
    print(rest);
  }

  insertTask() async {
    Database? db = await checkDatabase();
    int res = await db!.insert(
      "TASK",
      {
        "title": "COmprar nuevo disco",
        "description": "Nuevo disco de metallica",
        "status": "ture",
      },
    );
    print(res);
  }

  getRawTask() async {
    Database? db = await checkDatabase();
    List tasks = await db!.rawQuery("SELECT * FROM Task");
    print(tasks);
  }

  getTask() async {
    Database? db = await checkDatabase();
    List tasks = await db!.query("Task");
    print(tasks);
  }
}
