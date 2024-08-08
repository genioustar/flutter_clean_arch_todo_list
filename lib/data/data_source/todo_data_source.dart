import 'package:fastcam_firebase_example/di/firebase_service.dart';
import 'package:fastcam_firebase_example/domain/entity/todo_item.dart';
import 'package:injectable/injectable.dart';

@singleton
class TodoDataSource {
  final FirebaseService _firebaseService;

  TodoDataSource(this._firebaseService);

  Future<void> addTodoItem(String uid, String text) {
    final todoRed =
        _firebaseService.database.ref().child('users/$uid/todos').push();
    return todoRed.set({
      'text': text,
      'done': false,
    });
  }

  Future<List<TodoItem>> getTodoItems(String uid) async {
    final snapshot =
        await _firebaseService.database.ref().child('users/$uid/todos').get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> todoItemsMap =
          snapshot.value as Map<dynamic, dynamic>;
      List<TodoItem> todoItems = [];
      todoItemsMap.forEach((key, value) {
        todoItems.add(TodoItem(
          id: key,
          text: value['text'],
          done: value['done'],
        ));
      });
      return todoItems;
    } else {
      return [];
    }
  }

  Future<void> updateTodoItem(String uid, String todoId, bool done) {
    return _firebaseService.database
        .ref()
        .child('users/$uid/todos/$todoId')
        .update({'done': done});
  }

  Future<void> deleteTodoItem(String uid, String todoId) {
    return _firebaseService.database
        .ref()
        .child('users/$uid/todos/$todoId')
        .remove();
  }
}
