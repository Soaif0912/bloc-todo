import 'package:bloc_todo/features/todo/todo_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              tween: Tween<double>(begin: 150.0, end: 100.0),
              onEnd: () {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(builder: (context) => const TodoScreen()),
                );
              },
              builder: (context, value, child) {
                return Icon(
                  Icons.check_circle,
                  size: value,
                  color: Colors.blue,
                );
              },
            ),
            Text("Todo App", style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}
