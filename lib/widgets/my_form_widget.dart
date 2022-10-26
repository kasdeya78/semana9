import 'package:flutter/material.dart';
import 'package:semana9/db/db_admin.dart';
import 'package:semana9/models/task_model.dart';

class MyFormWidget extends StatefulWidget {
  const MyFormWidget({super.key});

  @override
  State<MyFormWidget> createState() => _MyFormWidgetState();
}

class _MyFormWidgetState extends State<MyFormWidget> {
  bool isFinished = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  addTask() {
    TaskModel taskModel = TaskModel(
        title: _titleController.text,
        description: _descriptionController.text,
        status: isFinished.toString());

    DBAdmin.db.insertTask(taskModel);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Agregar tarea"),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: "Titulo",
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
          TextField(
            controller: _descriptionController,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: "Descripcion",
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
          Row(
            children: [
              const Text(
                "Estado: ",
              ),
              const SizedBox(
                width: 6.0,
              ),
              Checkbox(
                value: isFinished,
                onChanged: (value) {
                  isFinished = value!;
                  setState(() {});
                },
              ),
            ],
          ),
          const SizedBox(
            height: 6.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancelar",
                ),
              ),
              SizedBox(
                width: 6.0,
              ),
              ElevatedButton(
                onPressed: () {
                  addTask();
                  DBAdmin.db.getRawTask();
                },
                child: Text(
                  "Aceptar",
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
