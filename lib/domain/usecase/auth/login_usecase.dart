import 'package:fastcam_firebase_example/domain/data_repository.dart';
import 'package:fastcam_firebase_example/domain/entity/user_profile.dart';
import 'package:fastcam_firebase_example/domain/result.dart';
import 'package:fastcam_firebase_example/domain/usecase/auth/dto/login_dto.dart';
import 'package:fastcam_firebase_example/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase implements UseCase<UserProfile, LoginDto> {
  final DataRepository _dataRepository;

  LoginUseCase(this._dataRepository);
  // 위에나 아래나 똑같음!
  // LoginUsecase({required DataRepository dataRepository})
  //     : _dataRepository = dataRepository;

  @override
  Future<UserProfile> call(LoginDto params,
      {required void Function(Exception) onError}) async {
    final result = await _dataRepository.login(params.email, params.password);
    if (result is ResultError) {
      onError(result.error!);
    }
    return result.data!;
  }
}
