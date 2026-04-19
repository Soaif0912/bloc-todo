import 'package:flutter/material.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo List")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(children: [const Text("Todo App")]),
      ),
    );
  }
}

class TodoAppBar extends StatelessWidget {
  const TodoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
