import 'package:fastcam_firebase_example/domain/usecase/auth/dto/register_dto.dart';
import 'package:fastcam_firebase_example/page/widget/email_input.dart';
import 'package:fastcam_firebase_example/page/widget/password_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterValidator extends StateNotifier<RegisterFormState> {
  RegisterValidator() : super(RegisterFormState());

  void emailChanged(String email) {
    final emailInput = EmailInput.dirty(value: email);
    state = state.copyWith(email: email, isEmailValid: emailInput.isValid);
  }

  void nameChanged(String name) {
    final isNameValid = name.isNotEmpty;
    state = state.copyWith(name: name, isNameValid: isNameValid);
  }

  void passwordChanged(String password) {
    final passwordInput = PasswordInput.dirty(value: password);
    state = state.copyWith(
        password: password, isPasswordValid: passwordInput.isValid);
  }

  void confirmPasswordChanged(String confirmPassword) {
    final isConfirmPasswordValid = state.password == confirmPassword;
    state = state.copyWith(
        confirmPassword: confirmPassword,
        isConfirmPasswordValid: isConfirmPasswordValid);
  }

  RegisterDto getRegisterDto() {
    return RegisterDto(
        email: state.email, password: state.password, name: state.name);
  }
}

final registerValidatorProvider =
    StateNotifierProvider<RegisterValidator, RegisterFormState>(
        (_) => RegisterValidator());

class RegisterFormState {
  final String email;
  final String password;
  final String name;
  final String confirmPassword;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isNameValid;
  final bool isConfirmPasswordValid;

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

  bool get canSubmit =>
      isEmailValid && isNameValid && isPasswordValid && isConfirmPasswordValid;

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
