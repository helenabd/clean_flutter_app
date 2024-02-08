import 'package:clean_flutter_app/domain/domain.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({required this.saveSecureCacheStorage});

  @override
  Future<void> save(AccountEntity account) async {
    try {
      await saveSecureCacheStorage.saveSecure(
          key: 'token', value: account.token);
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}

abstract class SaveSecureCacheStorage {
  Future<void> saveSecure({required String key, required String value});
}

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
  When mockRequestCall(String key, String value) =>
      when(() => saveSecure(key: key, value: value));
  void mockRequest(String key, String value) =>
      mockRequestCall(key, value).thenAnswer((_) async => _);
  void mockRequestError(String key, String value) =>
      mockRequestCall(key, value).thenThrow(Exception());
}

void main() {
  late LocalSaveCurrentAccount sut;
  late SaveSecureCacheStorageSpy saveSecureCacheStorage;
  late AccountEntity account;

  Map mockValidData() => {'key': 'token', 'value': faker.guid.guid()};

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
