import 'package:fastcam_firebase_example/domain/data_repository.dart';
import 'package:fastcam_firebase_example/domain/result.dart';
import 'package:fastcam_firebase_example/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckIsLoginUsecase implements UseCase<bool, void> {
  final DataRepository _dataRepository;

  const CheckIsLoginUsecase(this._dataRepository);

  @override
  Future<bool> call(void params, {required ResultErrorCallback onError}) async {
    final result = await _dataRepository.isLogin();
    if (result is ResultError) {
      onError(result
          .error!); //onError 함수가 호촐되도록 UseCase 클래스에서 정의되어 있기 때문에 이렇게 사용할 수 있음.
    }
    return result.data!;
  }
}
