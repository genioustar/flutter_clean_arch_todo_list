import 'package:fastcam_firebase_example/domain/data_repository.dart';
import 'package:fastcam_firebase_example/domain/result.dart';
import 'package:fastcam_firebase_example/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

// @injectable 어노테이션을 사용하여 이 클래스가 의존성 주입을 지원하도록 합니다.
@injectable
class AddTodoItemUseCase implements UseCase<void, String> {
  // DataRepository 인스턴스를 저장하는 변수입니다.
  final DataRepository _dataRepository;

  // 생성자에서 DataRepository 인스턴스를 받아 초기화합니다.
  AddTodoItemUseCase(this._dataRepository);

  // call 메서드는 할 일 항목 추가 유스케이스를 실행합니다.
  @override
  Future<void> call(String params,
      {required ResultErrorCallback onError}) async {
    // DataRepository를 사용하여 할 일 항목 추가 작업을 수행합니다.
    final result = await _dataRepository.addTodoItem(params);
    // 할 일 항목 추가 결과가 오류인 경우 onError 콜백을 호출하여 예외를 전달합니다.
    if (result is ResultError) {
      onError(result.error!);
    }
  }
}
