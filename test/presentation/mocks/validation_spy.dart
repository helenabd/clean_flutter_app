import 'package:clean_flutter_app/presentation/presentation.dart';
import 'package:mocktail/mocktail.dart';

class ValidationSpy extends Mock implements Validation {
  // ValidationSpy(String email) {
  //   mockValidation('email', email);
  // }

  When mockValidationCall(String field, String value) =>
      when(() => validate(field: field, value: value));

  void mockValidation(String field, String value) =>
      mockValidationCall(field, value).thenReturn('');
}
