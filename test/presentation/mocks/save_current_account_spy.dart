import 'package:clean_flutter_app/domain/entities/entities.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_flutter_app/domain/usecases/usecases.dart';

class SaveCurrentAccountSpy extends Mock implements SaveCurrentAccount {
  When mockValidationCall(AccountEntity entity) => when(() => save(entity));

  void mockValidation(AccountEntity entity) =>
      mockValidationCall(entity).thenAnswer((_) async => entity);
}
