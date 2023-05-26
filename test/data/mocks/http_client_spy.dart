import 'package:mocktail/mocktail.dart';

import '../usecases/remote_authentication_test.dart';

class HttpClientSpy extends Mock implements HttpClient {
  When mockRequestCall(String url, String method) => when(() => request(
        url: url,
        method: method,
      ));
  void mockRequest(String url, String method) =>
      mockRequestCall(url, method).thenAnswer((_) async => _);
  void mockRequestError(String url, String method) =>
      mockRequestCall(url, method).thenThrow(Exception());
}
