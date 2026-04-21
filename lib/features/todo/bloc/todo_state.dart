import 'package:bloc_todo/features/todo/todo_model.dart';

sealed class TodoState {
  final List<Todo> todos;
  const TodoState(this.todos);
}

class TodoInitial extends TodoState {
  TodoInitial() : super([]);
}

class TodoLoaded extends TodoState {
  TodoLoaded({required List<Todo> todos}) : super(todos);
}

class TodoError extends TodoState {
  TodoError({required List<Todo> todos}) : super(todos);
}
