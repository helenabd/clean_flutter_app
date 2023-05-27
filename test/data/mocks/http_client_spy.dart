import 'package:mocktail/mocktail.dart';

import 'package:clean_flutter_app/data/http/http.dart';
import 'package:clean_flutter_app/domain/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {
  When mockRequestCall(
          String url, String method, AuthenticationParams params) =>
      when(() => request(url: url, method: method, body: params.toJson()));
  void mockRequest(String url, String method, AuthenticationParams params) =>
      mockRequestCall(url, method, params).thenAnswer((_) async => _);
  void mockRequestError(
          String url, String method, AuthenticationParams params) =>
      mockRequestCall(url, method, params).thenThrow(Exception());
}
