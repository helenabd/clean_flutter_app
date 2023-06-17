import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

abstract class Validation {
  String validate({required String field, required String value});
}

class StreamLoginPresenter {
  final Validation validation;

  StreamLoginPresenter({required this.validation});

  void validateEmail(String email) {
    validation.validate(field: 'email', value: email);
  }
}

void main() {
  late StreamLoginPresenter sut;
  late ValidationSpy validation;
  late String email;

  When mockValidation(String email, String field) =>
      when(() => validation.validate(field: field, value: email));

  void mock(String email, String field) {
    mockValidation(email, field).thenAnswer((_) async => _);
  }

  setUp(() {
    email = faker.internet.email();
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    validation.mockValidation('email', email);
    mock(email, 'email');
  });

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);

    verify(() => validation.validate(field: 'email', value: email)).called(1);
  });
}
