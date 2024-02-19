import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {
  When mockRequestCall(String key, String value) =>
      when(() => write(key: key, value: value));
  void mockRequest(String key, String value) =>
      mockRequestCall(key, value).thenAnswer((_) async => _);
  void mockRequestError(String key, String value) =>
      mockRequestCall(key, value).thenThrow(Exception());
}
