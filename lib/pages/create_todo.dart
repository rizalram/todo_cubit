import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/cubits.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  _CreateTodoState createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Create Todo',
        contentPadding: EdgeInsets.symmetric(vertical: 16),
      ),
      onSubmitted: (String? desc) {
        if (desc != null && desc.trim().isNotEmpty) {
          context.read<TodoListCubit>().addTodo(desc);
          controller.clear();
        }
      },
    );
  }
}
