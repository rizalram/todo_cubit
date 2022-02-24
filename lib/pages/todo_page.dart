import 'package:flutter/material.dart';

import 'create_todo.dart';
import 'search_and_filter.dart';
import 'show_todos.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Todos',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const CreateTodo(),
                const SizedBox(height: 16),
                SearchAndFilter(),
                const ShowTodos(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
