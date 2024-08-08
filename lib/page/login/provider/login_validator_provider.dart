import 'package:fastcam_firebase_example/domain/usecase/auth/dto/login_dto.dart';
import 'package:fastcam_firebase_example/page/widget/email_input.dart';
import 'package:fastcam_firebase_example/page/widget/password_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

// LoginValidator 클래스는 로그인 폼의 상태를 관리하고 검증합니다.
class LoginValidator extends StateNotifier<LoginFormState> {
  // 초기 상태를 설정하는 생성자입니다.
  LoginValidator() : super(LoginFormState());

  // 이메일이 변경되었을 때 호출되는 메서드입니다.
  void emailChanged(String email) {
    // EmailInput 인스턴스를 생성하여 이메일 유효성을 검증합니다.
    final emailInput = EmailInput.dirty(value: email);
    // 상태를 복사하고, 이메일과 이메일 유효성 필드를 업데이트합니다.
    state = state.copyWith(email: email, isEmailValid: emailInput.isValid);
  }

  // 비밀번호가 변경되었을 때 호출되는 메서드입니다.
  void passwordChanged(String password) {
    // PasswordInput 인스턴스를 생성하여 비밀번호 유효성을 검증합니다.
    final passwordInput = PasswordInput.dirty(value: password);
    // 상태를 복사하고, 비밀번호와 비밀번호 유효성 필드를 업데이트합니다.
    state = state.copyWith(
        password: password, isPasswordValid: passwordInput.isValid);
  }

  // 현재 상태에서 이메일과 비밀번호를 포함하는 LoginDto 객체를 반환합니다.
  LoginDto getEmailAndPassword() {
    return LoginDto(email: state.email, password: state.password);
  }
}

// LoginValidatorProvider를 정의합니다.
// StateNotifierProvider를 사용하여 LoginValidator 인스턴스를 제공하고, 상태를 관리합니다.
final loginValidatorProvider =
    StateNotifierProvider<LoginValidator, LoginFormState>(
        (_) => LoginValidator());

// LoginFormState 클래스는 로그인 폼의 상태를 나타냅니다.
class LoginFormState {
  // 이메일 주소를 저장하는 필드입니다.
  final String email;

  // 비밀번호를 저장하는 필드입니다.
  final String password;

  // 이메일 주소의 유효성을 나타내는 필드입니다.
  final bool isEmailValid;

  // 비밀번호의 유효성을 나타내는 필드입니다.
  final bool isPasswordValid;

  // LoginFormState 클래스의 생성자입니다.
  // 모든 필드는 선택적으로 초기화할 수 있으며, 기본값을 제공합니다.
  LoginFormState({
    this.email = '',
    this.password = '',
    this.isEmailValid = false,
    this.isPasswordValid = false,
  });

// 로그인이 정상적으로 수행됐는지 확인하기 위한 getter
  bool get canSubmit => isEmailValid && isPasswordValid;

  // copyWith 메서드는 현재 상태를 복사하고, 선택적으로 특정 필드를 업데이트하여 새로운 상태를 반환합니다.
  LoginFormState copyWith({
    String? email,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
  }) =>
      LoginFormState(
        email: email ?? this.email,
        password: password ?? this.password,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      );
}
