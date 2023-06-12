abstract class LoginPresenter {
  Stream<String> emailErrorStream();
  Stream<String> passwordErrorStream();
  Stream<bool> isFormValidStream();
  Stream<bool> isLoadingStream();

  void validateEmail(String email);
  void validatePassword(String password);
  void auth();
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

  @override
  Stream<String> passwordErrorStream() {
    // TODO: implement passwordErrorStream
    throw UnimplementedError();
  }

  @override
  Stream<bool> isFormValidStream() {
    // TODO: implement isFormValidStream
    throw UnimplementedError();
  }

  @override
  void auth() {
    // TODO: implement auth
  }

  @override
  Stream<bool> isLoadingStream() {
    // TODO: implement isLoadingStream
    throw UnimplementedError();
  }
}
