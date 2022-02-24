import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../todo_list/todo_list_cubit.dart';
import '../../models/todo_model.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  final int initialCount;
  final TodoListCubit todoListCubit;
  StreamSubscription<TodoListState>? todoSubscription;

  ActiveTodoCountCubit({
    required this.initialCount,
    required this.todoListCubit,
    this.todoSubscription,
  }) : super(ActiveTodoCountState(activeTodoCount: initialCount)) {
    todoSubscription = todoListCubit.stream.listen((TodoListState event) {
      final int newActiveTodoCount =
          event.todos.where((Todo todo) => !todo.complete).toList().length;

      emit(state.copyWith(activeTodoCount: newActiveTodoCount));
    });
  }

  @override
  Future<void> close() {
    todoSubscription?.cancel();
    return super.close();
  }
}
