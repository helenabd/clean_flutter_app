import 'package:clean_flutter_app/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

class SaveCurrentAccountSpy extends Mock implements SaveCurrentAccount {
  When mockSaveCall() => when(() => save(any()));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);
  void mockSaveError() => mockSaveCall().thenThrow(DomainError.unexpected);
}
