// Define a model for Todo
class Todo {
  final int? id;
  final String title;
  bool completed;
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

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, completed: $completed, userId: $userId}';
  }
}
