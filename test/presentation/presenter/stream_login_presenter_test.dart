import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

abstract class Validation {
  String validate({required String field, required String value});
}

class LoginState {
  String? emailError;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>();

  var _state = LoginState();

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError!);

  StreamLoginPresenter({required this.validation});

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _controller.add(_state);
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

  test('Should emit email error if validation fails', () {
    when(
      () => validation.validate(
          field: any(named: 'field'), value: any(named: 'value')),
    ).thenReturn('error');

    expectLater(sut.emailErrorStream, emits('error'));

    sut.validateEmail(email);
  });
}
