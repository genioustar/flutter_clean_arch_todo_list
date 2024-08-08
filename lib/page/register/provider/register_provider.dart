import 'package:fastcam_firebase_example/domain/usecase/auth/dto/register_dto.dart';
import 'package:fastcam_firebase_example/domain/usecase/auth/register_usecase.dart';
import 'package:fastcam_firebase_example/injector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// RegisterNotifier 클래스는 사용자 등록을 관리하는 상태 관리 클래스입니다.
class RegisterNotifier extends StateNotifier<RegisterState> {
  // 초기 상태를 설정하는 생성자입니다.
  RegisterNotifier() : super(RegisterState.initial());

  // 사용자 등록을 수행하는 메서드입니다.
  Future<void> register(RegisterDto dto) async {
    // 로딩 상태로 업데이트합니다.
    state = RegisterState.loading();

    // RegisterUseCase 인스턴스를 가져옵니다.
    final registerUseCase = locator<RegisterUseCase>();

    // RegisterUseCase를 호출하여 사용자 등록을 수행합니다.
    await registerUseCase(dto, onError: (error) {
      // 오류가 발생하면 상태를 오류 상태로 업데이트합니다.
      state = RegisterState.error(error.toString());
    });

    // 성공적으로 등록이 완료되면 상태를 성공 상태로 업데이트합니다.
    state = RegisterState.success();
  }
}

// StateNotifierProvider를 사용하여 RegisterNotifier 인스턴스를 제공하고 상태를 관리합니다.
final registerNotifierProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>(
        (ref) => RegisterNotifier());

// RegisterState 클래스는 사용자 등록의 상태를 나타냅니다.
class RegisterState {
  final bool isLoading; // 로딩 상태를 나타내는 필드입니다.
  final bool isSuccess; // 성공 상태를 나타내는 필드입니다.
  final String? errorMessage; // 오류 메시지를 저장하는 필드입니다.

  // 기본 생성자입니다.
  RegisterState(
      {this.isLoading = false, this.isSuccess = false, this.errorMessage});

  // 초기 상태를 반환하는 팩토리 생성자입니다.
  factory RegisterState.initial() => RegisterState();

  // 로딩 상태를 반환하는 팩토리 생성자입니다.
  factory RegisterState.loading() => RegisterState(isLoading: true);

  // 성공 상태를 반환하는 팩토리 생성자입니다.
  factory RegisterState.success() => RegisterState(isSuccess: true);

  // 오류 상태를 반환하는 팩토리 생성자입니다.
  factory RegisterState.error(String errorMessage) =>
      RegisterState(errorMessage: errorMessage);
}
