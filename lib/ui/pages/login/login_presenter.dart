abstract class LoginPresenter {
  Stream<String> emailErrorStream();

  void validateEmail(String email);
  void validatePassword(String password);
}

class Login implements LoginPresenter {
  @override
  // TODO: implement emailErrorStream
  Stream<String> emailErrorStream() => throw UnimplementedError();

  @override
  void validateEmail(String email) {
    // TODO: implement validateEmail
  }

  @override
  void validatePassword(String password) {
    // TODO: implement validatePassword
  }
}
