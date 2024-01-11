import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geo_fresh/utils/constant_data.dart';

class UserRepository {
  FlutterSecureStorage flutterSecureStorage = new FlutterSecureStorage();

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await deleteAllSecureValue();
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await setSecureValue(TOKEN, token);
    return;
  }

  Future<void> persistId(String id) async {
    /// write to keystore/keychain
    await setSecureValue(USER_ID, id);
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    var value = await readSecureValue(TOKEN);
    if (value != null) {
      return true;
    }
    return false;
  }

  Future<bool> hasUserId() async {
    /// read from keystore/keychain
    var value = await readSecureValue(USER_ID);
    if (value != null) {
      return true;
    }
    return false;
  }

  Future<bool> hasRole() async {
    /// read from keystore/keychain
    var value = await readSecureValue(ROLE);
    if (value != null) {
      return true;
    }
    return false;
  }

  Future setSecureValue(String key, dynamic value) async {
    // Write value
    await flutterSecureStorage.write(key: key, value: value);
  }

  Future<dynamic> readSecureValue(String key) async {
    // Read value
    String value = await flutterSecureStorage.read(key: key);
    if (value != null) {
      return value;
    }
    return null;
  }

  Future deleteSecureValue(String key) async {
    // delete value
    await flutterSecureStorage.delete(key: key);
  }

  Future deleteAllSecureValue() async {
    // delete value
    await flutterSecureStorage.deleteAll();
  }
}
