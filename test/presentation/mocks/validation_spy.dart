import 'package:mocktail/mocktail.dart';

import '../presenter/stream_login_presenter_test.dart';

class ValidationSpy extends Mock implements Validation {
  // ValidationSpy(String email) {
  //   mockValidation('email', email);
  // }

  When mockValidationCall(String field, String value) =>
      when(() => validate(field: field, value: value));

  void mockValidation(String field, String value) =>
      mockValidationCall(field, value).thenReturn(value);
}
