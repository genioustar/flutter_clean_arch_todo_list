import 'package:fastcam_firebase_example/domain/entity/todo_item.dart';
import 'package:fastcam_firebase_example/domain/usecase/todo/add_todo_item_usecase.dart';
import 'package:fastcam_firebase_example/domain/usecase/todo/delete_todo_item_usecase.dart';
import 'package:fastcam_firebase_example/domain/usecase/todo/dto/update_todo_dto.dart';
import 'package:fastcam_firebase_example/domain/usecase/todo/get_todo_items_usecase.dart';
import 'package:fastcam_firebase_example/domain/usecase/todo/update_todo_item_usecase.dart';
import 'package:fastcam_firebase_example/injector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoListNotifier extends StateNotifier<TodoItemState> {
  TodoListNotifier() : super(TodoItemState.initial());

  Future<void> loadTodoItem() async {
    final getTodoItemsUseCase = locator<GetTodoItemsUseCase>();
    final result = await getTodoItemsUseCase(
      null,
      onError: (error) {
        state = TodoItemState.error(error.toString());
      },
    );
    state =
        result.isEmpty ? TodoItemState.empty() : TodoItemState.success(result);
  }

  Future<void> addTodoItem(String text) async {
    final addTodoItemUseCase = locator<AddTodoItemUseCase>();
    await addTodoItemUseCase(
      text,
      onError: (error) {
        state = TodoItemState.error(error.toString());
      },
    );
    await loadTodoItem();
  }

  Future<void> updateTodoItem(String id, bool done) async {
    final updateTodoItemUseCase = locator<UpdateTodoItemUseCase>();
    await updateTodoItemUseCase(UpdateTodoDto(id: id, done: done),
        onError: (error) {
      state = TodoItemState.error(error.toString());
    });
    await loadTodoItem();
  }

  Future<void> deleteTodoItem(String todoId) async {
    final deleteTotoItemUseCase = locator<DeleteTodoItemUseCase>();
    await deleteTotoItemUseCase(todoId, onError: (error) {
      state = TodoItemState.error(error.toString());
    });
    await loadTodoItem();
  }
}

final todoListNotifierProvider =
    StateNotifierProvider<TodoListNotifier, TodoItemState>(
        (_) => TodoListNotifier());

class TodoItemState {
  final bool isLoading;
  final bool isEmpty;
  final List<TodoItem> items;
  final String? errorMessage;

  TodoItemState(
      {this.isLoading = false,
      this.isEmpty = false,
      this.items = const [],
      this.errorMessage});
  factory TodoItemState.initial() => TodoItemState();
  factory TodoItemState.loading() => TodoItemState(isLoading: true);
  factory TodoItemState.empty() => TodoItemState(isEmpty: true);
  factory TodoItemState.success(List<TodoItem> items) =>
      TodoItemState(items: items);
  factory TodoItemState.error(String errorMessage) =>
      TodoItemState(errorMessage: errorMessage);
}
