import 'package:fastcam_firebase_example/domain/data_repository.dart';
import 'package:fastcam_firebase_example/domain/entity/todo_item.dart';
import 'package:fastcam_firebase_example/domain/result.dart';
import 'package:fastcam_firebase_example/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTodoItemsUseCase implements UseCase<List<TodoItem>, void> {
  final DataRepository _dataRepository;

  GetTodoItemsUseCase(this._dataRepository);
  @override
  Future<List<TodoItem>> call(void params,
      {required ResultErrorCallback onError}) async {
    final result = await _dataRepository.getTodoItems();
    if (result is ResultError) {
      onError(result.error!);
    }
    return result.data!;
  }
}
