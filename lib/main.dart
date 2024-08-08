import 'package:fastcam_firebase_example/injector.dart';
import 'package:fastcam_firebase_example/page/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  // Flutter 프레임워크와의 상호작용을 보장하기 위해 Flutter 바인딩을 초기화합니다.
  WidgetsFlutterBinding.ensureInitialized();

  // 의존성 주입을 설정합니다.
  await configureDependencies();
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    ),
  );
}
