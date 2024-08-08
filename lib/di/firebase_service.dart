import 'package:fastcam_firebase_example/firebase_options.dart'; // Firebase 설정 파일을 가져옵니다.
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication 패키지를 가져옵니다.
import 'package:firebase_core/firebase_core.dart'; // Firebase Core 패키지를 가져옵니다.
import 'package:firebase_database/firebase_database.dart'; // Firebase Realtime Database 패키지를 가져옵니다.

class FirebaseService {
  // FirebaseService를 초기화하는 정적 메서드입니다.
  static Future<FirebaseService> init() async {
    // Firebase를 초기화합니다. 설정 옵션은 플랫폼에 따라 다르게 적용됩니다.
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // 초기화가 완료되면 FirebaseService 인스턴스를 반환합니다.
    return FirebaseService();
  }

  // FirebaseAuth 인스턴스를 반환하는 getter입니다.
  FirebaseAuth get auth => FirebaseAuth.instance;

  // FirebaseDatabase 인스턴스를 반환하는 getter입니다.
  FirebaseDatabase get database => FirebaseDatabase.instance;
}
