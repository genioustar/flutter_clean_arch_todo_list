// 비동기 작업의 결과를 나타내는 sealed class Result<T>를 정의합니다.
sealed class Result<T> {
  final T? data; // 성공 시 반환되는 데이터
  final Exception? error; // 실패 시 발생하는 예외

  // Result 클래스의 생성자는 private으로 설정하여 직접 인스턴스화할 수 없게 합니다.
  // == Result({this.data, this.error}); 다만 private이므로 외부에서 접근 불가
  Result._({this.data, this.error});

  // 성공 결과를 나타내는 팩토리 생성자
  factory Result.success(T data) = ResultSuccess<T>;

  // 실패 결과를 나타내는 팩토리 생성자
  factory Result.error(Exception error) = ResultError<T>;

  // 작업이 성공했는지를 확인하는 getter
  bool get successed => this is ResultSuccess && data != null;
}

// 성공 결과를 나타내는 final class ResultSuccess<T>
final class ResultSuccess<T> extends Result<T> {
  // Result 생성자에서 success 값을 데이터를 설정합니다.
  ResultSuccess(T data) : super._(data: data);
}

// 실패 결과를 나타내는 final class ResultError<T>
final class ResultError<T> extends Result<T> {
  // Result 생성자에서 error 값을 설정합니다.
  ResultError(Exception error) : super._(error: error);
}

// 안전하게 비동기 작업을 실행하고, 결과를 Result로 반환하는 함수
Future<Result<T>> executeSafe<T>(Future<T> Function() operation) async {
  try {
    // 비동기 작업을 실행하고 결과를 받습니다.
    T result = await operation();
    // 작업이 성공하면 ResultSuccess를 반환합니다.
    return Result.success(result);
  } on Exception catch (e) {
    // 예외가 발생하면 ResultError를 반환합니다.
    return Result.error(e);
  }
}
