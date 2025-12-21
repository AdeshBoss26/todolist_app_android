class Task {
  int? id;
  int userId;
  String title;
  String? description;
  bool isDone;

  Task({
    this.id,
    required this.userId,
    required this.title,
    this.description,
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'isDone': isDone ? 1 : 0,
    };
  }
}
