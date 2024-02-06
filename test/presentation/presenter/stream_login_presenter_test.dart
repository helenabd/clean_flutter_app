// ignore_for_file: prefer_if_null_operators

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_flutter_app/domain/domain.dart';
import 'package:clean_flutter_app/presentation/presentation.dart';

import '../../domain/domain.dart';
import '../mocks/mocks.dart';

void main() {
  late StreamLoginPresenter sut;
  late ValidationSpy validation;
  late AuthenticationSpy authentication;
  late String email;
  late String password;

  When mockValidationCall(String? field) => when(() => validation.validate(
      field: field == null ? any(named: 'field') : field,
      value: any(named: 'value')));

  void mockValidation({String? field, String? value}) {
    mockValidationCall(field).thenReturn(value);
  }

  When mockAuthenticationCall() => when(() => authentication.auth(any()));

  void mockAuthentication() {
    registerFallbackValue(AuthenticationParams(email: email, secret: password));
    mockAuthenticationCall()
        .thenAnswer((_) async => AccountEntity(faker.guid.guid()));
  }

  void mockAuthenticationError(DomainError error) {
    mockAuthenticationCall().thenThrow(error);
  }

  setUp(() {
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    sut = StreamLoginPresenter(
        validation: validation, authentication: authentication);
    email = faker.internet.email();
    password = faker.internet.password();
    mockValidation();
    mockAuthentication();
  });

  test('Should call Validation with correct email', () {
    mockValidation(value: email);

    sut.validateEmail(email);

    verify(() => validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    mockValidation(value: 'error');

    sut.emailErrorStream
        ?.listen(expectAsync1((error) => expect(error, 'error')))
        .asFuture((_) {
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));
    });

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit null if validation succeeds', () {
    sut.emailErrorStream
        ?.listen(expectAsync1((error) => expect(error, '')))
        .asFuture((_) {
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));
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
        ?.listen(expectAsync1((error) => expect(error, 'error')))
        .asFuture((_) {
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));
    });

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit password null if validation succeeds', () {
    sut.passwordErrorStream
        ?.listen(expectAsync1((error) => expect(error, '')))
        .asFuture((_) {
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));
    });

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit form invalid event if any field is invalid', () {
    mockValidation(field: 'email', value: 'error');
    sut.emailErrorStream
        ?.listen(expectAsync1((error) => expect(error, 'error')))
        .asFuture((_) {
      sut.passwordErrorStream
          ?.listen(expectAsync1((error) => expect(error, '')))
          .asFuture((_) {
        sut.isFormValidStream
            ?.listen(expectAsync1((isValid) => expect(isValid, false)));
      });
    });

    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test('Should emit form valid event if form is valid', () async {
    sut.emailErrorStream
        ?.listen(expectAsync1((error) => expect(error, '')))
        .asFuture((_) {
      sut.passwordErrorStream
          ?.listen(expectAsync1((error) => expect(error, '')))
          .asFuture((_) {
        // sut.isFormValidStream
        //     .listen(expectAsync1((isValid) => expect(isValid, true)));
        expectLater(sut.isFormValidStream, emitsInOrder([false, true]));
      });
    });

    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('Should call authentication with correct values', () async {
    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);

    await sut.auth();

    verify(() => authentication
        .auth(AuthenticationParams(email: email, secret: password))).called(1);
  });

  test('Should emit correct events on Authentication success', () async {
    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    await sut.auth();
  });

  test('Should emit correct events on InvalidCredentialError', () async {
    mockAuthenticationError(DomainError.invalidCredentials);
    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);

    sut.mainErrorStream
        ?.listen(
            expectAsync1((error) => expect(error, 'Credenciais inválidas')))
        .asFuture((_) {
      expectLater(sut.isLoadingStream, emits(false));
    });

    await sut.auth();
  });

  test('Should emit correct events on UnexpectedError', () async {
    mockAuthenticationError(DomainError.unexpected);
    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);

    sut.mainErrorStream
        ?.listen(expectAsync1((error) =>
            expect(error, 'Algo errado aconteceu. Tente novamente em breve')))
        .asFuture((_) {
      expectLater(sut.isLoadingStream, emits(false));
    });

    await sut.auth();
  });

  test('Should not emit after dispose', () async {
    expectLater(sut.emailErrorStream, neverEmits(null));

    sut.validateEmail(email);
    sut.dispose();

    // await sut.auth();
  });
}
