// ignore_for_file: prefer_if_null_operators

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_flutter_app/presentation/presentation.dart';

import '../mocks/mocks.dart';

void main() {
  late StreamLoginPresenter sut;
  late ValidationSpy validation;
  late String email;
  late String password;

  When mockValidationCall(String? field) => when(() => validation.validate(
      field: field == null ? any(named: 'field') : field,
      value: any(named: 'value')));

  void mockValidation({String? field, String? value}) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    password = faker.internet.password();
    mockValidation();
  });

  test('Should call Validation with correct email', () {
    mockValidation(value: email);

    sut.validateEmail(email);

    verify(() => validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    mockValidation(value: 'error');

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')))
        .asFuture((_) {
      sut.isFormValidStream
          .listen(expectAsync1((isValid) => expect(isValid, false)));
    });

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit null if validation succeeds', () {
    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, '')))
        .asFuture((_) {
      sut.isFormValidStream
          .listen(expectAsync1((isValid) => expect(isValid, false)));
    });

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should call Validation with correct password', () {
    sut.validatePassword(password);

    verify(() => validation.validate(field: 'password', value: password))
        .called(1);
  });

  test('Should emit password error if validation fails', () {
    mockValidation(value: 'error');

    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')))
        .asFuture((_) {
      sut.isFormValidStream
          .listen(expectAsync1((isValid) => expect(isValid, false)));
    });

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit password null if validation succeeds', () {
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, '')))
        .asFuture((_) {
      sut.isFormValidStream
          .listen(expectAsync1((isValid) => expect(isValid, false)));
    });

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit form invalid event if any field is invalid', () {
    mockValidation(field: 'email', value: 'error');
    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')))
        .asFuture((_) {
      sut.passwordErrorStream
          .listen(expectAsync1((error) => expect(error, '')))
          .asFuture((_) {
        sut.isFormValidStream
            .listen(expectAsync1((isValid) => expect(isValid, false)));
      });
    });

    sut.validateEmail(email);
    sut.validatePassword(password);
  });
}
