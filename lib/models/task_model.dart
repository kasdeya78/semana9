class TaskModel {
  int? id;
  String title;
  String description;
  String status;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  factory TaskModel.deMapModel(Map<String, dynamic> mapa) => TaskModel(
        id: mapa["id"],
        title: mapa["title"],
        description: mapa["description"],
        status: mapa["status"],
      );
}
