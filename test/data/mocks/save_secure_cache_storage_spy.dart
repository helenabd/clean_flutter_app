import 'package:clean_flutter_app/data/cache/cache.dart';
import 'package:mocktail/mocktail.dart';

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
  When mockRequestCall(String key, String value) =>
      when(() => saveSecure(key: key, value: value));
  void mockRequest(String key, String value) =>
      mockRequestCall(key, value).thenAnswer((_) async => _);
  void mockRequestError(String key, String value) =>
      mockRequestCall(key, value).thenThrow(Exception());
}
