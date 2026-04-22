import 'package:bloc_todo/features/todo/bloc/todo_event.dart';
import 'package:bloc_todo/features/todo/bloc/todo_state.dart';
import 'package:bloc_todo/features/todo/todo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  static const String _boxName = 'todos';

  TodoBloc() : super(TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onTodoAdded);
    on<TodoUpdated>(_onTodoUpdated);
    on<TodoDeleted>(_onTodoDeleted);
    on<TodoCompleted>(_onTodoCompleted);
  }

  // ── helpers ──────────────────────────────────────────────────────────────

  Box<Todo> get _box => Hive.box<Todo>(_boxName);

  List<Todo> get _todosFromBox => _box.values.toList();

  // ── handlers ──────────────────────────────────────────────────────────────

  Future<void> _onLoadTodos(
    LoadTodos event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoaded(todos: _todosFromBox));
  }

  Future<void> _onTodoAdded(AddTodo event, Emitter<TodoState> emit) async {
    final int nextId =
        _box.isEmpty ? 1 : (_box.values.map((t) => t.id).reduce((a, b) => a > b ? a : b) + 1);

    final newTodo = Todo(
      id: nextId,
      title: event.title,
      description: event.description,
    );

    await _box.put(newTodo.id, newTodo);
    emit(TodoLoaded(todos: _todosFromBox));
  }

  Future<void> _onTodoUpdated(
    TodoUpdated event,
    Emitter<TodoState> emit,
  ) async {
    final existing = _box.get(event.id);
    if (existing == null) return;

    final updated = existing.copyWith(
      title: event.title,
      description: event.description,
    );

    await _box.put(event.id, updated);
    emit(TodoLoaded(todos: _todosFromBox));
  }

  Future<void> _onTodoDeleted(
    TodoDeleted event,
    Emitter<TodoState> emit,
  ) async {
    await _box.delete(event.id);
    emit(TodoLoaded(todos: _todosFromBox));
  }

  Future<void> _onTodoCompleted(
    TodoCompleted event,
    Emitter<TodoState> emit,
  ) async {
    final existing = _box.get(event.id);
    if (existing == null) return;

    await _box.put(event.id, existing.copyWith(isCompleted: event.isCompleted));
    emit(TodoLoaded(todos: _todosFromBox));
  }
}
