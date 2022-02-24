import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'todo_search_state.dart';

class TodoSearchCubit extends Cubit<TodoSearchState> {
  TodoSearchCubit() : super(TodoSearchState.initial());

  void searchTerm(String searchTerm) {
    emit(state.copyWith(searchTerm: searchTerm));
  }
}
