import 'package:bloc_todo/features/todo/bloc/todo_event.dart';
import 'package:bloc_todo/features/todo/bloc/todo_state.dart';
import 'package:bloc_todo/features/todo/todo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<AddTodo>(_onTodoAdded);
    on<TodoUpdated>(_onTodoUpdated);
    on<TodoDeleted>(_onTodoDeleted);
    on<TodoCompleted>(_onTodoCompleted);
  }

  void _onTodoAdded(AddTodo event, Emitter<TodoState> emit) {
    final int lastTodoId = state.todos.isEmpty ? 0 : state.todos.last.id;
    emit(
      TodoLoaded(
        todos: [
          ...state.todos,
          Todo(
            id: lastTodoId + 1,
            title: event.title,
            description: event.description,
          ),
        ],
      ),
    );
  }

  void _onTodoUpdated(TodoUpdated event, Emitter<TodoState> emit) {
    if (!state.todos.any((e) => e.id == event.id)) return;
    emit(
      TodoLoaded(
        todos: state.todos
            .map(
              (e) => e.id == event.id
                  ? e.copyWith(
                      title: event.title,
                      description: event.description,
                    )
                  : e,
            )
            .toList(),
      ),
    );
  }

  void _onTodoDeleted(TodoDeleted event, Emitter<TodoState> emit) {
    emit(
      TodoLoaded(todos: state.todos.where((e) => e.id != event.id).toList()),
    );
  }

  void _onTodoCompleted(TodoCompleted event, Emitter<TodoState> emit) {
    emit(
      TodoLoaded(
        todos: state.todos
            .map(
              (e) => e.id == event.id
                  ? e.copyWith(isCompleted: event.isCompleted)
                  : e,
            )
            .toList(),
      ),
    );
  }
}
