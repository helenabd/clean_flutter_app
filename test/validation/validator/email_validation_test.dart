import 'package:flutter_test/flutter_test.dart';

import 'package:clean_flutter_app/validation/validators/validators.dart';

void main() {
  late EmailValidation sut;

  setUp(() {
    sut = const EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate(null), null);
  });
  test('Should return null if email is valid', () {
    expect(sut.validate('helenabdias95@gmail.com'), null);
  });
  test('Should return error if email is invalid', () {
    expect(sut.validate('helenabdias95'), 'Campo inválido');
  });
}
