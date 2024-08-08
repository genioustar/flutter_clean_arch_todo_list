import 'package:fastcam_firebase_example/domain/data_repository.dart';
import 'package:fastcam_firebase_example/domain/result.dart';
import 'package:fastcam_firebase_example/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUsecase implements UseCase<void, void> {
  final DataRepository _dataRepository;

  LogoutUsecase(this._dataRepository);

  @override
  Future<void> call(void params, {required ResultErrorCallback onError}) async {
    final result = await _dataRepository.logout();
    if (result is ResultError) {
      onError(result.error!);
    }
  }
}
