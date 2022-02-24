import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/todo_page.dart';
import 'cubits/cubits.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoFilterCubit>(
          create: (context) => TodoFilterCubit(),
        ),
        BlocProvider<TodoSearchCubit>(
          create: (context) => TodoSearchCubit(),
        ),
        BlocProvider<TodoListCubit>(
          create: (context) => TodoListCubit(),
        ),
        BlocProvider<ActiveTodoCountCubit>(
          create: (context) => ActiveTodoCountCubit(
            initialCount: context.read<TodoListCubit>().state.todos.length,
            todoListCubit: context.read<TodoListCubit>(),
          ),
        ),
        BlocProvider<FilteredTodoCubit>(
          create: (context) => FilteredTodoCubit(
            initialTodos: context.read<TodoListCubit>().state.todos,
            filterCubit: context.read<TodoFilterCubit>(),
            searchCubit: context.read<TodoSearchCubit>(),
            listCubit: context.read<TodoListCubit>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodoPage(),
      ),
    );
  }
}
