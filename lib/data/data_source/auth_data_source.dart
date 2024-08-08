import 'package:fastcam_firebase_example/di/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@singleton
// AuthDataSource 클래스는 사용자 인증 관련 작업을 수행합니다.
class AuthDataSource {
  // FirebaseService 인스턴스를 저장하는 변수입니다.
  final FirebaseService _firebaseService;

  // 생성자에서 FirebaseService 인스턴스를 받아 초기화합니다.
  AuthDataSource(this._firebaseService);

  // 사용자를 등록하는 메서드입니다.
  Future<User> registerUser(String email, String password, String name) async {
    // 이메일과 비밀번호로 사용자 등록을 요청합니다.
    final UserCredential userCredential =
        await _firebaseService.auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // 등록된 사용자 정보를 가져옵니다.
    final User? user = userCredential.user;
    if (user != null) {
      // 사용자의 표시 이름을 업데이트하고, 사용자 정보를 새로고침합니다.
      await user.updateDisplayName(name);
      await user.reload();
      // 새로고침된 현재 사용자 정보를 가져옵니다.
      User? updatedUser = _firebaseService.auth.currentUser;

      // 업데이트된 사용자 정보가 null이 아니면 반환합니다.
      if (updatedUser == null) {
        throw Exception('UpdatedUser registration failed');
      }
      return updatedUser;
    } else {
      // 사용자 등록에 실패한 경우 예외를 던집니다.
      throw Exception('User registration failed');
    }
  }

  // 이메일과 비밀번호로 사용자 로그인을 수행하는 메서드입니다.
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    // 이메일과 비밀번호로 사용자 로그인을 요청합니다.
    final UserCredential userCredential = await _firebaseService.auth
        .signInWithEmailAndPassword(email: email, password: password);
    // 로그인된 사용자 정보를 가져옵니다.
    final User? user = userCredential.user;

    // 사용자 정보가 null이 아니면 반환합니다.
    if (user != null) {
      return user;
    } else {
      // 로그인에 실패한 경우 예외를 던집니다.
      throw Exception('User sign in failed');
    }
  }

  // 현재 로그인된 사용자 정보를 가져오는 메서드입니다.
  Future<User> getCurrentUser() async {
    final User? user = _firebaseService.auth.currentUser;
    if (user != null) {
      return user;
    } else {
      // 사용자가 로그인되어 있지 않은 경우 예외를 던집니다.
      throw Exception('User is not signed in');
    }
  }

  // 사용자가 로그인되어 있는지 확인하는 메서드입니다.
  Future<bool> isSignedIn() async {
    final User? user = _firebaseService.auth.currentUser;
    return user != null;
  }

  // 사용자를 로그아웃하는 메서드입니다.
  Future<void> signOut() => _firebaseService.auth.signOut();
}
