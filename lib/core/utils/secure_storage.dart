import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  const SecureStorage._();

  static final SecureStorage instance = const SecureStorage._();

  static final Map<String, String> _syncData = {};

  // initialization
  static final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  /// Reads a value associated with the given `key` from flutter secure storage asynchronously.
  Future<String?> read(String key) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (_) {
      log('failed to read data');
      return null;
    }
  }

  ///Reads a value associated with the given `key` from the in-memory synchronized map.
  String? readSync(String key) => _syncData[key];

  ///Writes a `[key]`-`[value]` pair to secure storage and updates the in-memory synchronized map.
  Future<void> write(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
      _syncData.update(key, (_) => value, ifAbsent: () => value);
    } catch (_) {
      log('failed to write data');
    }
  }

  ///Deletes a key-value pair from secure storage and removes it from the in-memory synchronized map.
  Future<void> delete(String key) async {
    try {
      await _secureStorage.delete(key: key);
      _syncData.remove(key);
    } catch (_) {
      log('failed to delete data');
    }
  }

  ///Reads all key-value pairs from secure storage and updates the in-memory synchronized map.
  Future<Map<String, String>> readAll() async {
    try {
      final allData = await _secureStorage.readAll();
      _syncData.addAll(allData);
      return allData;
    } catch (_) {
      log('failed to read all data');
      return {};
    }
  }

  ///Deletes all key-value pairs from secure storage and clears the in-memory synchronized map.
  Future<void> deleteAll() async {
    try {
      await _secureStorage.deleteAll();
      _syncData.clear();
    } catch (_) {
      log('failed to delete data');
    }
  }
}
