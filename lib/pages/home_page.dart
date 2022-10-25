import 'package:flutter/material.dart';
import 'package:semana9/db/db_admin.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                DBAdmin.db.getTask();
              },
              child: Text(
                "Mostrar data",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //DBAdmin.db.insertRawTask();
                DBAdmin.db.insertTask();
              },
              child: Text(
                "Insertar data",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //DBAdmin.db.insertRawTask();
                DBAdmin.db.updateTask();
              },
              child: Text(
                "Actualizar tarea",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //DBAdmin.db.insertRawTask();
                DBAdmin.db.deleteTask();
              },
              child: Text(
                "Eliminar tarea",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
