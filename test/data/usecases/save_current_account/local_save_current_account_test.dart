import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clean_flutter_app/data/usecases/usecases.dart';
import 'package:clean_flutter_app/domain/domain.dart';

import '../../mocks/save_secure_cache_storage_spy.dart';

void main() {
  late LocalSaveCurrentAccount sut;
  late SaveSecureCacheStorageSpy saveSecureCacheStorage;
  late AccountEntity account;

  When mockRequest() => when(() => saveSecureCacheStorage.saveSecure(
      key: any(named: 'key'), value: any(named: 'value')));

  void mockRequestError() => mockRequest().thenThrow(Exception());

  setUp(() {
    saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    account = AccountEntity(faker.guid.guid());
    sut =
        LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    saveSecureCacheStorage.mockRequest('token', account.token);
  });

  test('Should call SaveCacheStorage with correct values', () async {
    await sut.save(account);

    verify(() =>
        saveSecureCacheStorage.saveSecure(key: 'token', value: account.token));
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage ', () async {
    mockRequestError();
    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}
