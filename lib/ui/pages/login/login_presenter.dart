abstract class LoginPresenter {
  Stream<String> emailErrorStream();
  Stream<String> passwordErrorStream();
  Stream<bool> isFormValidStream();
  Stream<bool> isLoadingStream();
  Stream<String> mainErrorStream();

  void validateEmail(String email);
  void validatePassword(String password);
  Future<void>? auth();
  void dispose();
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
  Stream<bool> isLoadingStream() {
    // TODO: implement isLoadingStream
    throw UnimplementedError();
  }

  @override
  Stream<String> mainErrorStream() {
    // TODO: implement mainErrorStream
    throw UnimplementedError();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<void>? auth() {
    // TODO: implement auth
    throw UnimplementedError();
  }
}
