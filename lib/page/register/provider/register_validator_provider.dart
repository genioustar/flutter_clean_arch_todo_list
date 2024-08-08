import 'package:fastcam_firebase_example/domain/usecase/auth/dto/register_dto.dart';
import 'package:fastcam_firebase_example/page/widget/email_input.dart';
import 'package:fastcam_firebase_example/page/widget/password_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// RegisterValidator 클래스는 사용자 등록 양식의 상태를 관리하고 검증합니다.
class RegisterValidator extends StateNotifier<RegisterFormState> {
  // 초기 상태를 설정하는 생성자입니다.
  RegisterValidator() : super(RegisterFormState());

  // 이메일이 변경되었을 때 호출되는 메서드입니다.
  void emailChanged(String email) {
    final emailInput = EmailInput.dirty(value: email);
    state = state.copyWith(email: email, isEmailValid: emailInput.isValid);
  }

  // 이름이 변경되었을 때 호출되는 메서드입니다.
  void nameChanged(String name) {
    final isNameValid = name.isNotEmpty;
    state = state.copyWith(name: name, isNameValid: isNameValid);
  }

  // 비밀번호가 변경되었을 때 호출되는 메서드입니다.
  void passwordChanged(String password) {
    final passwordInput = PasswordInput.dirty(value: password);
    state = state.copyWith(
        password: password, isPasswordValid: passwordInput.isValid);
  }

  // 비밀번호 확인이 변경되었을 때 호출되는 메서드입니다.
  void confirmPasswordChanged(String confirmPassword) {
    final isConfirmPasswordValid = state.password == confirmPassword;
    state = state.copyWith(
        confirmPassword: confirmPassword,
        isConfirmPasswordValid: isConfirmPasswordValid);
  }

  // 현재 상태에서 RegisterDto 객체를 반환합니다.
  RegisterDto getRegisterDto() {
    return RegisterDto(
        email: state.email, password: state.password, name: state.name);
  }
}

// StateNotifierProvider를 사용하여 RegisterValidator 인스턴스를 제공하고 상태를 관리합니다.
final registerValidatorProvider =
    StateNotifierProvider<RegisterValidator, RegisterFormState>(
        (_) => RegisterValidator());

// RegisterFormState 클래스는 사용자 등록 양식의 상태를 나타냅니다.
class RegisterFormState {
  final String email; // 이메일 주소를 저장하는 필드입니다.
  final String password; // 비밀번호를 저장하는 필드입니다.
  final String name; // 이름을 저장하는 필드입니다.
  final String confirmPassword; // 비밀번호 확인을 저장하는 필드입니다.
  final bool isEmailValid; // 이메일 유효성을 나타내는 필드입니다.
  final bool isPasswordValid; // 비밀번호 유효성을 나타내는 필드입니다.
  final bool isNameValid; // 이름 유효성을 나타내는 필드입니다.
  final bool isConfirmPasswordValid; // 비밀번호 확인 유효성을 나타내는 필드입니다.

  // 기본 생성자입니다. 모든 필드는 기본값을 가집니다.
  RegisterFormState({
    this.email = '',
    this.password = '',
    this.name = '',
    this.confirmPassword = '',
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isNameValid = false,
    this.isConfirmPasswordValid = false,
  });

  // 모든 필드가 유효한지 여부를 반환하는 getter입니다.
  bool get canSubmit =>
      isEmailValid && isNameValid && isPasswordValid && isConfirmPasswordValid;

  // 현재 상태를 복사하고 선택적으로 특정 필드를 업데이트하여 새로운 상태를 반환합니다.
  RegisterFormState copyWith({
    String? email,
    String? password,
    String? name,
    String? confirmPassword,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isNameValid,
    bool? isConfirmPasswordValid,
  }) =>
      RegisterFormState(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        name: name ?? this.name,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isNameValid: isNameValid ?? this.isNameValid,
        isConfirmPasswordValid:
            isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      );
}
