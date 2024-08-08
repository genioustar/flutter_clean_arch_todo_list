import 'package:fastcam_firebase_example/di/firebase_service.dart';
import 'package:injectable/injectable.dart';

// @module 어노테이션을 사용하여 이 클래스를 모듈로 정의합니다.
@module
abstract class AppModule {
  // @preResolve 어노테이션을 사용하여 비동기 초기화 메서드를 정의합니다.
  @preResolve
  Future<FirebaseService> get firebaseService => FirebaseService.init();
}
