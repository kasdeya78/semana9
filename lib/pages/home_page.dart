import 'package:flutter/material.dart';
import 'package:semana9/db/db_admin.dart';
import 'package:semana9/models/task_model.dart';

class HomePage extends StatelessWidget {
  Future<String> getFullName() async {
    return "Eduardo Chavez";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: FutureBuilder(
        future: DBAdmin.db.getTask(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            List<TaskModel> myTask = snap.data;
            return ListView.builder(
              itemCount: myTask.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(myTask[index].title),
                  subtitle: Text(myTask[index].description),
                  trailing: Text(
                    myTask[index].id.toString(),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
