// RegisterDto 클래스는 사용자 등록 정보를 저장하는 데이터 전송 객체입니다.
class RegisterDto {
  // 사용자의 이메일 주소를 저장하는 필드입니다.
  final String email;

  // 사용자의 비밀번호를 저장하는 필드입니다.
  final String password;

  // 사용자의 이름을 저장하는 필드입니다.
  final String name;

  // RegisterDto 클래스의 생성자입니다.
  // 모든 필드는 필수로 받아야 하며, 'required' 키워드를 사용하여 이를 명시합니다.
  const RegisterDto({
    required this.email,
    required this.password,
    required this.name,
  });
}
