import 'package:fastcam_firebase_example/domain/data_repository.dart';
import 'package:fastcam_firebase_example/domain/result.dart';
import 'package:fastcam_firebase_example/domain/usecase/todo/dto/update_todo_dto.dart';
import 'package:fastcam_firebase_example/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateTodoItemUseCase implements UseCase<void, UpdateTodoDto> {
  final DataRepository _dataRepository;

  UpdateTodoItemUseCase(this._dataRepository);
  @override
  Future<void> call(UpdateTodoDto params,
      {required ResultErrorCallback onError}) async {
    final result = await _dataRepository.updateTodoItem(params);
    if (result is ResultError) {
      onError(result.error!);
    }
  }
}
