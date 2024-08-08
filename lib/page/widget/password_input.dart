import 'package:formz/formz.dart';

// 비밀번호 입력의 오류 유형을 정의합니다.
enum PasswordInputError { isEmpty, invalid }

// PasswordInput 클래스는 FormzInput을 상속받아 비밀번호 검증을 수행합니다.
class PasswordInput extends FormzInput<String, PasswordInputError> {
  // 순수 상태의 비밀번호 입력을 초기화하는 생성자입니다.
  const PasswordInput.pure() : super.pure('');

  // 변경된 상태의 비밀번호 입력을 초기화하는 생성자입니다.
  const PasswordInput.dirty({String value = ''}) : super.dirty(value);

  // 비밀번호 유효성을 검증하는 메서드입니다.
  @override
  PasswordInputError? validator(String value) {
    // 비밀번호 조건을 정의합니다.
    bool hasMinLength = value.length >= 8; // 최소 길이 8자 이상
    bool hasUpperCase = value.contains(RegExp(r'[A-Z]')); // 대문자 포함
    bool hasLowerCase = value.contains(RegExp(r'[a-z]')); // 소문자 포함
    bool hasDigit = value.contains(RegExp(r'\d')); // 숫자 포함
    bool hasSpecialCharacter =
        value.contains(RegExp(r'[!@#$%^&*(){}|<>?,.]')); // 특수 문자 포함

    // 비밀번호가 비어 있는 경우 오류 반환
    if (value.isEmpty) return PasswordInputError.isEmpty;

    // 비밀번호가 조건을 만족하지 않는 경우 오류 반환
    if (!hasMinLength ||
        !hasUpperCase ||
        !hasLowerCase ||
        !hasDigit ||
        !hasSpecialCharacter) {
      return PasswordInputError.invalid;
    }

    // 모든 조건을 만족하면 null 반환 (유효성 검사 통과)
    return null;
  }
}
