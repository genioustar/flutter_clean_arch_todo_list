// ResultErrorCallback 타입 정의: 예외가 발생할 때 호출되는 콜백 함수의 타입입니다.
typedef ResultErrorCallback = void Function(Exception error);

// UseCase 추상 클래스 정의: 다양한 사용 사례(Use Case)를 구현하기 위한 기본 클래스입니다.
abstract class UseCase<Type, Params> {
  // call 메서드 정의: 구체적인 사용 사례를 구현할 때 오버라이드해야 하는 메서드입니다.
  // Params 타입의 매개변수를 받아서 Future<Typem> 타입의 결과를 반환합니다.
  // 에러가 발생할 경우 onError 콜백을 호출합니다.
  Future<Type> call(Params params, {required ResultErrorCallback onError});
}
