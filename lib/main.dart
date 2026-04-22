import 'package:bloc_todo/core/theme/app_theme.dart';
import 'package:bloc_todo/features/todo/bloc/todo_bloc.dart';
import 'package:bloc_todo/features/todo/bloc/todo_event.dart';
import 'package:bloc_todo/features/todo/todo_model.dart';
import 'package:bloc_todo/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);

  // Register the generated TypeAdapter, then open the typed box.
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>('todos');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TodoBloc()..add(const LoadTodos()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: SplashScreen(),
    );
  }
}
