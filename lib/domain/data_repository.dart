import 'package:fastcam_firebase_example/domain/entity/todo_item.dart';
import 'package:fastcam_firebase_example/domain/entity/user_profile.dart';
import 'package:fastcam_firebase_example/domain/result.dart';
import 'package:fastcam_firebase_example/domain/usecase/todo/dto/update_todo_dto.dart';

// DataRepository 추상 클래스는 다양한 데이터 작업을 수행하는 메서드를 정의합니다.
abstract class DataRepository {
  // 사용자 로그인 메서드입니다.
  Future<Result<UserProfile>> login(String email, String password);

  // 사용자 로그아웃 메서드입니다.
  Future<Result<void>> logout();

  // 사용자 등록 메서드입니다.
  Future<Result<UserProfile>> register(
      String email, String password, String name);

  // 현재 로그인된 사용자 정보를 가져오는 메서드입니다.
  Future<Result<UserProfile>> getCurrentUser();

  // 사용자가 로그인되어 있는지 확인하는 메서드입니다.
  Future<Result<bool>> isLogin();

  // 할 일 항목을 추가하는 메서드입니다.
  // 할 일 항목을 추가할 때는 사용자 UID가 필요한데, 현재 로그인된 사용자 정보에서 가져올 수 있습니다.
  Future<Result<void>> addTodoItem(String text);

  // 할 일 항목을 업데이트하는 메서드입니다.
  Future<Result<void>> updateTodoItem(UpdateTodoDto updateTodoDto);

  // 할 일 항목을 삭제하는 메서드입니다.
  Future<Result<void>> deleteTodoItem(String todoId);

  // 할 일 항목 목록을 가져오는 메서드입니다.
  Future<Result<List<TodoItem>>> getTodoItems();
}
