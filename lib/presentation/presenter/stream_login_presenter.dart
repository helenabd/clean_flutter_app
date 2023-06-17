import 'dart:async';

import '../presentation.dart';

class LoginState {
  late String emailError;
  bool get isFormValid => false;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>();

  final _state = LoginState();

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError).distinct();
  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  StreamLoginPresenter({required this.validation});

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _controller.add(_state);
  }
}
