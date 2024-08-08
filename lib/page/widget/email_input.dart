import 'package:formz/formz.dart';

enum EmailInputError { empty, invalid }

final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

class EmailInput extends FormzInput<String, EmailInputError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty({String value = ''}) : super.dirty(value);

  @override
  EmailInputError? validator(String value) {
    if (value.isEmpty) {
      return EmailInputError.empty;
    }

    // Corrected logic
    return emailRegExp.hasMatch(value) ? null : EmailInputError.invalid;
  }
}
