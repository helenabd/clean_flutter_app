// ignore_for_file: prefer_final_fields, unnecessary_null_comparison

import 'package:clean_flutter_app/domain/domain.dart';
import 'package:clean_flutter_app/ui/pages/login/login.dart';
import 'package:get/get.dart';

import '../presentation.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;

  late String? _email;
  late String? _password;
  var _emailError = RxString('');
  var _passwordError = RxString('');
  var _mainError = RxString('');
  var _isFormValid = false.obs;
  var _isLoading = false.obs;

  @override
  Stream<String?>? get emailErrorStream => _emailError.stream;
  @override
  Stream<String?>? get passwordErrorStream => _passwordError.stream;
  @override
  Stream<String?>? get mainErrorStream => _mainError.stream;
  @override
  Stream<bool>? get isFormValidStream => _isFormValid.stream;
  @override
  Stream<bool>? get isLoadingStream => _isLoading.stream;

  GetxLoginPresenter({required this.validation, required this.authentication});

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = validation.validate(field: 'email', value: email) ?? '';
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value =
        validation.validate(field: 'password', value: password) ?? '';
    _validateForm();
  }

  void _validateForm() {
    _isFormValid.value = _emailError.value == '' &&
        _passwordError.value == '' &&
        _email != null &&
        _password != null;
  }

  @override
  Future<void> auth() async {
    _isLoading.value = true;
    try {
      await authentication
          .auth(AuthenticationParams(email: _email!, secret: _password!));
    } on DomainError catch (error) {
      _mainError.value = error.description;
    }
    _isLoading.value = false;
  }
}
