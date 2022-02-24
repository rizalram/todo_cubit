import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/cubits.dart';
import '../models/todo_model.dart';
import '../utils/debounce.dart';

class SearchAndFilter extends StatelessWidget {
  SearchAndFilter({Key? key}) : super(key: key);

  final debounce = Debounce(duration: 400);

  @override
  Widget build(BuildContext context) {
    Color textColor(BuildContext context, Filter filter) {
      final currentFilter = context.watch<TodoFilterCubit>().state.filter;
      return filter == currentFilter ? Colors.blue : Colors.grey;
    }

    TextButton filterButton(BuildContext context, Filter filter) {
      return TextButton(
        onPressed: () {
          context.read<TodoFilterCubit>().changeFilter(filter);
        },
        child: Text(
          filter == Filter.active
              ? 'Active'
              : filter == Filter.complete
                  ? 'Complete'
                  : 'All',
          style: TextStyle(
            color: textColor(context, filter),
          ),
        ),
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
      );
    }

    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            filled: true,
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.all(16),
            border: InputBorder.none,
          ),
          onChanged: (String? search) {
            if (search != null) {
              debounce.run(() {
                context.read<TodoSearchCubit>().searchTerm(search);
              });
            }
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<ActiveTodoCountCubit, ActiveTodoCountState>(
              builder: (context, state) {
                return Text(
                  ' ${state.activeTodoCount} Task left',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                  ),
                );
              },
            ),
            Row(
              children: [
                filterButton(context, Filter.all),
                const SizedBox(width: 4),
                filterButton(context, Filter.active),
                const SizedBox(width: 4),
                filterButton(context, Filter.complete),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
