part of 'filtered_todo_cubit.dart';

class FilteredTodoState extends Equatable {
  final List<Todo> filteredTodo;

  const FilteredTodoState({
    required this.filteredTodo,
  });

  factory FilteredTodoState.initial() {
    return const FilteredTodoState(filteredTodo: []);
  }

  @override
  List<Object> get props => [filteredTodo];

  @override
  String toString() => 'FilteredTodoState(filteredTodo: $filteredTodo)';

  FilteredTodoState copyWith({
    List<Todo>? filteredTodo,
  }) {
    return FilteredTodoState(
      filteredTodo: filteredTodo ?? this.filteredTodo,
    );
  }
}
