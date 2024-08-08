import 'package:fastcam_firebase_example/domain/data_repository.dart';
import 'package:fastcam_firebase_example/domain/result.dart';
import 'package:fastcam_firebase_example/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddTodoItemUseCase implements UseCase<void, String> {
  final DataRepository _dataRepository;

  AddTodoItemUseCase(this._dataRepository);
  @override
  Future<void> call(String params,
      {required ResultErrorCallback onError}) async {
    final result = await _dataRepository.addTodoItem(params);
    if (result is ResultError) {
      onError(result.error!);
    }
  }
}
