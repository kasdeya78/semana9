import 'package:flutter/material.dart';
import 'package:semana9/db/db_admin.dart';
import 'package:semana9/models/task_model.dart';
import 'package:semana9/widgets/my_form_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<String> getFullName() async {
    return "Eduardo Chavez";
  }

  ShowDialogForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyFormWidget();
      },
    ).then((value) {
      print("Formulario cerrado");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ShowDialogForm();
        },
        child: const Icon(
          Icons.add,
        ),
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
