import 'package:fastcam_firebase_example/domain/entity/todo_item.dart';
import 'package:fastcam_firebase_example/domain/entity/user_profile.dart';
import 'package:fastcam_firebase_example/domain/result.dart';
import 'package:fastcam_firebase_example/domain/usecase/todo/dto/update_todo_dto.dart';

abstract class DataRepository {
  Future<Result<UserProfile>> login(String email, String password);
  Future<Result<void>> logout();
  Future<Result<UserProfile>> register(
      String email, String password, String name);
  Future<Result<UserProfile>> getCurrentUser();
  Future<Result<bool>> isLogin();
  // TodoItem 관련 메서드로 item을 추가할때는 user의 uid가 필요한데 해당 정보는 현재 로그인된 사용자 정보에서 가져올 수 있어 구현할때 uid를 파라미터로 받고 지금은 받을 수 없음.
  Future<Result<void>> addTodoItem(String text);
  Future<Result<void>> updateTodoItem(UpdateTodoDto updateTodoDto);
  Future<Result<void>> deleteTodoItem(String todoId);
  Future<Result<List<TodoItem>>> getTodoItems();
}
