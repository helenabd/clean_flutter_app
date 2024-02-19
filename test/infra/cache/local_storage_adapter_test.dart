import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:clean_flutter_app/data/cache/cache.dart';

import '../mocks/mocks.dart';

void main() {
  late LocalStorageAdapter sut;
  late FlutterSecureStorageSpy secureStorage;
  late String key;
  late String value;

  When mockRequest({required String key, required String value}) =>
      when(() => secureStorage.write(key: key, value: value));

  void mockRequestError({required String key, required String value}) =>
      mockRequest(key: key, value: value).thenThrow(Exception());

  setUp(() {
    secureStorage = FlutterSecureStorageSpy();
    sut = LocalStorageAdapter(secureStorage: secureStorage);
    key = faker.lorem.word();
    value = faker.guid.guid();
    secureStorage.mockRequest(key, value);
  });

  test('Should call save secure with correct values', () async {
    await sut.saveSecure(key: key, value: value);

    verify(() => secureStorage.write(key: key, value: value));
  });
}
