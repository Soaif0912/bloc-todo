import 'package:bloc_todo/features/todo/bloc/todo_bloc.dart';
import 'package:bloc_todo/features/todo/bloc/todo_event.dart';
import 'package:bloc_todo/features/todo/bloc/todo_state.dart';
import 'package:bloc_todo/features/todo/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text("Todo List")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoInitial) {
              return const Center(child: Text("No todos yet"));
            }
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return TodoCard(todo: todo);
              },
            );
          },
        ),
      ),
    );
  }
}

class TodoCard extends StatelessWidget {
  final Todo todo;
  const TodoCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Row(
        children: [
          Checkbox(
            value: todo.isCompleted,
            onChanged: (value) {
              context.read<TodoBloc>().add(
                TodoCompleted(id: todo.id, isCompleted: value!),
              );
            },
          ),
          const Gap(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(todo.title), Text(todo.description)],
            ),
          ),
          PopupMenuButton(
            position: PopupMenuPosition.under,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text("Edit"),
                  onTap: () {
                    _showUpdateDialog(context, todo);
                  },
                ),
                PopupMenuItem(
                  child: Text("Delete"),
                  onTap: () {
                    context.read<TodoBloc>().add(TodoDeleted(id: todo.id));
                  },
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}

void _showAddTodoDialog(BuildContext context) {
  final todoAddFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Add Todo"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: todoAddFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a title";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(label: Text("Title")),
                  ),
                  const Gap(8),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      label: Text("Description"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (!todoAddFormKey.currentState!.validate()) return;

              context.read<TodoBloc>().add(
                AddTodo(
                  title: titleController.text,
                  description: descriptionController.text,
                ),
              );
              titleController.clear();
              descriptionController.clear();
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      );
    },
  );
}

void _showUpdateDialog(BuildContext context, Todo todo) {
  final todoUpdateFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController(
    text: todo.title,
  );
  TextEditingController descriptionController = TextEditingController(
    text: todo.description,
  );

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Update Todo"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: todoUpdateFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a title";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(label: Text("Title")),
                  ),
                  const Gap(8),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      label: Text("Description"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (!todoUpdateFormKey.currentState!.validate()) return;

              context.read<TodoBloc>().add(
                TodoUpdated(
                  id: todo.id,
                  title: titleController.text,
                  description: descriptionController.text,
                ),
              );
              titleController.clear();
              descriptionController.clear();
              Navigator.pop(context);
            },
            child: const Text("Update"),
          ),
        ],
      );
    },
  );
}
