import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/todo_model.dart';
import '../todo_filter/todo_filter_cubit.dart';
import '../todo_list/todo_list_cubit.dart';
import '../todo_search/todo_search_cubit.dart';

part 'filtered_todo_state.dart';

class FilteredTodoCubit extends Cubit<FilteredTodoState> {
  final TodoFilterCubit filterCubit;
  final TodoSearchCubit searchCubit;
  final TodoListCubit listCubit;

  final List<Todo> initialTodos;

  StreamSubscription<TodoFilterState>? filterSubscription;
  StreamSubscription<TodoSearchState>? searchSubscription;
  StreamSubscription<TodoListState>? listSubscription;

  FilteredTodoCubit({
    required this.filterCubit,
    required this.searchCubit,
    required this.listCubit,
    required this.initialTodos,
  }) : super(FilteredTodoState(filteredTodo: initialTodos)) {
    filterSubscription = filterCubit.stream.listen((event) {
      setFilteredList();
    });
    searchSubscription = searchCubit.stream.listen((event) {
      setFilteredList();
    });
    listSubscription = listCubit.stream.listen((event) {
      setFilteredList();
    });
  }

  void setFilteredList() {
    List<Todo> _filteredTodos;

    switch (filterCubit.state.filter) {
      case Filter.active:
        _filteredTodos =
            listCubit.state.todos.where((Todo todo) => !todo.complete).toList();
        break;
      case Filter.complete:
        _filteredTodos =
            listCubit.state.todos.where((Todo todo) => todo.complete).toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = listCubit.state.todos;
    }

    if (searchCubit.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) =>
              todo.desc.toLowerCase().contains(searchCubit.state.searchTerm))
          .toList();
    }

    emit(state.copyWith(filteredTodo: _filteredTodos));
  }

  @override
  Future<void> close() {
    filterSubscription?.cancel();
    searchSubscription?.cancel();
    listSubscription?.cancel();
    return super.close();
  }
}
