import 'package:bloc_todo/features/todo/bloc/todo_bloc.dart';
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
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return const TodoCard();
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
          Checkbox(value: todo.isCompleted, onChanged: (value) {}),
          const Gap(8),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [Text(todo.title), Text(todo.description)],
            ),
          ),
          PopupMenuButton(
            position: .under,
            itemBuilder: (context) {
              return [
                const PopupMenuItem(child: Text("Edit")),
                const PopupMenuItem(child: Text("Delete")),
              ];
            },
          ),
        ],
      ),
    );
  }
}

void _showAddTodoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Add Todo"),
        content: Column(
          mainAxisSize: .min,
          children: [
            TextFormField(
              decoration: const InputDecoration(label: Text("Title")),
            ),
            const Gap(8),
            TextFormField(
              decoration: const InputDecoration(label: Text("Description")),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      );
    },
  );
}
