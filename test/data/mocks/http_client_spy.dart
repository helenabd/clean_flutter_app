import 'package:mocktail/mocktail.dart';

import '../usecases/remote_authentication_test.dart';

class HttpClientSpy extends Mock implements HttpClient {
  When mockRequestCall(String url) => when(() => request(url: url));
  void mockRequest(String url) =>
      mockRequestCall(url).thenAnswer((_) async => _);
  void mockRequestError(String url) =>
      mockRequestCall(url).thenThrow(Exception());
}
