sealed class TodoEvent {
  const TodoEvent();
}

class TodoAdded extends TodoEvent {
  final int id;
  final String title;
  final String description;

  TodoAdded({required this.id, required this.title, required this.description});
}

class TodoUpdated extends TodoEvent {
  final int id;
  final String title;
  final String description;

  TodoUpdated({
    required this.id,
    required this.title,
    required this.description,
  });
}

class TodoDeleted extends TodoEvent {
  final int id;

  TodoDeleted({required this.id});
}

class TodoCompleted extends TodoEvent {
  final int id;
  final bool isCompleted;

  TodoCompleted({required this.id, required this.isCompleted});
}
