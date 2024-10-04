import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage({required this.name}) {
    storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
            encryptedSharedPreferences: false, sharedPreferencesName: name));
  }

  final String name;
  late final FlutterSecureStorage storage;

  writeData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  readData(String key) async {
    return await storage.read(key: key);
  }

  deleteData(String key) async {
    await storage.delete(key: key);
  }
}
