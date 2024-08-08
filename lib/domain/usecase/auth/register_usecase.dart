import 'package:fastcam_firebase_example/domain/data_repository.dart';
import 'package:fastcam_firebase_example/domain/entity/user_profile.dart';
import 'package:fastcam_firebase_example/domain/result.dart';
import 'package:fastcam_firebase_example/domain/usecase/auth/dto/register_dto.dart';
import 'package:fastcam_firebase_example/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase implements UseCase<UserProfile, RegisterDto> {
  final DataRepository _dataRepository;

  RegisterUseCase(this._dataRepository);

  @override
  Future<UserProfile> call(RegisterDto params,
      {required ResultErrorCallback onError}) async {
    final result = await _dataRepository.register(
        params.email, params.password, params.name);
    if (result is ResultError) {
      onError(result.error!);
    }
    return result.data!;
  }
}
