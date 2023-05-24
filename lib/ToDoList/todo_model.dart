class Todo {
  String title;
  String description;

  Todo({
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'],
      description: map['description'],
    );
  }
}
