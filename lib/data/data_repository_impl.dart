import 'package:fastcam_firebase_example/data/data_source/auth_data_source.dart';
import 'package:fastcam_firebase_example/data/data_source/todo_data_source.dart';
import 'package:fastcam_firebase_example/domain/data_repository.dart';
import 'package:fastcam_firebase_example/domain/entity/todo_item.dart';
import 'package:fastcam_firebase_example/domain/entity/user_profile.dart';
import 'package:fastcam_firebase_example/domain/result.dart';
import 'package:fastcam_firebase_example/domain/usecase/todo/dto/update_todo_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DataRepository)
class DataRepositoryImpl extends DataRepository {
  final AuthDataSource _authDataSource;
  final TodoDataSource _todoDataSource;

  DataRepositoryImpl(
      {required TodoDataSource todoDataSource,
      required AuthDataSource authDataSource})
      : _authDataSource = authDataSource,
        _todoDataSource = todoDataSource;

  @override
  Future<Result<UserProfile>> getCurrentUser() => executeSafe(() async {
        final user = await _authDataSource.getCurrentUser();
        return UserProfile(
            email: user.email ?? '',
            name: user.displayName ?? '',
            uid: user.uid);
      });

  @override
  Future<Result<bool>> isLogin() => executeSafe(() async {
        return await _authDataSource.isSignedIn();
      });

  @override
  Future<Result<UserProfile>> login(String email, String password) =>
      executeSafe(() async {
        final user =
            await _authDataSource.signInWithEmailAndPassword(email, password);
        return UserProfile(
            email: user.email ?? '',
            name: user.displayName ?? '',
            uid: user.uid);
      });

  @override
  Future<Result<void>> logout() => executeSafe(() async {
        await _authDataSource.signOut();
      });

  @override
  Future<Result<UserProfile>> register(
          String email, String password, String name) =>
      executeSafe(() async {
        final user = await _authDataSource.registerUser(email, password, name);
        return UserProfile(
            email: user.email ?? '',
            name: user.displayName ?? '',
            uid: user.uid);
      });

  @override
  Future<Result<void>> addTodoItem(String text) => executeSafe(() async {
        // 현재 로그인된 사용자 정보를 가져옵니다.
        final user = await _authDataSource.getCurrentUser();
        // 현재 로그인된 사용자 정보에서 uid를 가져옵니다.
        final uid = user.uid;
        // TodoItem을 추가하는 메서드를 호출합니다.
        return _todoDataSource.addTodoItem(uid, text);
      });

  @override
  Future<Result<void>> deleteTodoItem(String todoId) => executeSafe(() async {
        // 현재 로그인된 사용자 정보를 가져옵니다.
        final user = await _authDataSource.getCurrentUser();
        // 현재 로그인된 사용자 정보에서 uid를 가져옵니다.
        final uid = user.uid;
        // TodoItem을 삭제하는 메서드를 호출합니다.
        return _todoDataSource.deleteTodoItem(uid, todoId);
      });

  @override
  Future<Result<List<TodoItem>>> getTodoItems() => executeSafe(() async {
        // 현재 로그인된 사용자 정보를 가져옵니다.
        final user = await _authDataSource.getCurrentUser();
        // 현재 로그인된 사용자 정보에서 uid를 가져옵니다.
        final uid = user.uid;
        // TodoItem 삭체하는 메서드를 호출합니다.
        return _todoDataSource.getTodoItems(uid);
      });

  @override
  Future<Result<void>> updateTodoItem(UpdateTodoDto dto) =>
      executeSafe(() async {
        // 현재 로그인된 사용자 정보를 가져옵니다.
        final user = await _authDataSource.getCurrentUser();
        // 현재 로그인된 사용자 정보에서 uid를 가져옵니다.
        final uid = user.uid;
        // TodoItem을 업데이트하는 메서드를 호출합니다.
        return _todoDataSource.updateTodoItem(uid, dto.id, dto.done);
      });
}
