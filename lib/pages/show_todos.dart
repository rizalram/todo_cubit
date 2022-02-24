import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cubits.dart';

import '../models/todo_model.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodoCubit>().state.filteredTodo;
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(todos[index].id),
          onDismissed: (_) {
            context.read<TodoListCubit>().removeTodo(todos[index]);
          },
          confirmDismiss: (_) {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Delete'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                );
              },
            );
          },
          background: showBackground(0),
          secondaryBackground: showBackground(1),
          child: _TodoItem(todo: todos[index]),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: todos.length,
    );
  }

  Widget showBackground(int direction) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}

class _TodoItem extends StatefulWidget {
  const _TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);
  final Todo todo;

  @override
  __TodoItemState createState() => __TodoItemState();
}

class __TodoItemState extends State<_TodoItem> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        onChanged: (_) {
          context.read<TodoListCubit>().toggleTodo(widget.todo.id);
        },
        value: widget.todo.complete,
      ),
      title: Text(widget.todo.desc),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            bool errorText = false;
            controller.text = widget.todo.desc;

            return StatefulBuilder(
              builder: (context, StateSetter setState) {
                return AlertDialog(
                  title: const Text('Edit'),
                  content: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      errorText: errorText ? 'Tidak boleh kosong' : null,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          errorText = controller.text.isEmpty ? true : false;
                          if (!errorText) {
                            context
                                .read<TodoListCubit>()
                                .editTodo(widget.todo.id, controller.text);
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: const Text('Edit'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
