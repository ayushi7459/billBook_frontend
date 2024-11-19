import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MySecureStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> writeEmailAndPassword(String email, String password) async {
    await _storage.write(key: 'email', value: email);
    await _storage.write(key: 'password', value: password);
  }

  Future<void> writeToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<String?> readEmail() async {
    return await _storage.read(key: 'email');
  }

  Future<String?> readPassword() async {
    return await _storage.read(key: 'password');
  }

  Future<String?> readToken() async {
    return await _storage.read(key: 'token');
  }

  Future<void> deleteEmailAndPassword() async {
    await _storage.delete(key: 'email');
    await _storage.delete(key: 'password');
  }

  Future<void> saveLocale(String locale) async {
    await _storage.write(key: 'locale', value: locale);
  }

  Future<String?> readLocale() async {
    return await _storage.read(key: 'locale');
  }

  Future<void> deleteLocale() async {
    await _storage.delete(key: 'locale');
  }


}
