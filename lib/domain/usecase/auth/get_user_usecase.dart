import 'package:fastcam_firebase_example/domain/data_repository.dart';
import 'package:fastcam_firebase_example/domain/entity/user_profile.dart';
import 'package:fastcam_firebase_example/domain/result.dart';
import 'package:fastcam_firebase_example/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserUsecase implements UseCase<UserProfile, void> {
  final DataRepository _dataRepository;

  GetUserUsecase(this._dataRepository);

  @override
  Future<UserProfile> call(void params,
      {required ResultErrorCallback onError}) async {
    final result = await _dataRepository.getCurrentUser();
    if (result is ResultError) {
      onError(result.error!);
    }
    return result.data!;
  }
}
