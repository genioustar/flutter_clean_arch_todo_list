import 'package:fastcam_firebase_example/page/register/provider/register_provider.dart';
import 'package:fastcam_firebase_example/page/register/provider/register_validator_provider.dart';
import 'package:fastcam_firebase_example/page/widget/flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerFormState = ref.watch(registerValidatorProvider);
    final registerState = ref.watch(registerNotifierProvider);
    final registerFormNotifier = ref.read(registerValidatorProvider.notifier);
    final registerNotifier = ref.read(registerNotifierProvider.notifier);

    ref.listen<RegisterState>(registerNotifierProvider, (_, registerState) {
      if (registerState.isSuccess) {
        Navigator.pop(context);
      } else if (registerState.errorMessage != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(registerState.errorMessage!)));
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (email) => registerFormNotifier.emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: '이메일',
                hintText: '이메일을 입력하세요',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              onChanged: (name) => registerFormNotifier.nameChanged(name),
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: '이름',
                hintText: '이름을 입력하세요',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              onChanged: (password) =>
                  registerFormNotifier.passwordChanged(password),
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '패스워드',
                hintText: '패스워드를 입력하세요',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              onChanged: (confirmPassword) =>
                  registerFormNotifier.confirmPasswordChanged(confirmPassword),
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '패스워드 확인',
                hintText: '패스워드를 다시 입력하세요',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            FlatButton(
              text: '회원가입',
              isActive: !registerState.isLoading && registerFormState.canSubmit,
              onPressed: () {
                final dto = registerFormNotifier.getRegisterDto();
                registerNotifier.register(dto);
              },
            ),
          ],
        ),
      ),
    );
  }
}
