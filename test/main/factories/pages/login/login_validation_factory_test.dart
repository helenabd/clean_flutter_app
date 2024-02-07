import 'package:test/test.dart';

import 'package:clean_flutter_app/main/factories/factories.dart';
import 'package:clean_flutter_app/validation/validators/validators.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeLoginValidations();
    expect(validations, [
      const RequiredFieldValidation('email'),
      const EmailValidation('email'),
      const RequiredFieldValidation('password'),
    ]);
  });
}
