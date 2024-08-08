// LoginDto 클래스는 사용자의 로그인 정보를 담는 데이터 전송 객체입니다.
class LoginDto {
  // 이메일을 저장하는 final 변수입니다.
  final String email;
  // 비밀번호를 저장하는 final 변수입니다.
  final String password;

  // LoginDto 생성자는 email과 password를 받아 초기화합니다.
  // 이 필드들은 반드시 필요한 값이므로 required 키워드를 사용합니다.
  const LoginDto({
    required this.email,
    required this.password,
  });
}
