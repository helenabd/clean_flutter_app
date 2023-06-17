import 'package:mocktail/mocktail.dart';

import '../presenter/stream_login_presenter_test.dart';

class ValidationSpy extends Mock implements Validation {
  ValidationSpy() {
    mockValidation('', '');
  }

  When mockValidationCall(String? field, String? value) => when(() => validate(
      field: field == null ? any(named: 'field') : field,
      value: any(named: 'value')));

  void mockValidation(String? field, String? value) =>
      mockValidationCall(field, value).thenReturn(null);
}
