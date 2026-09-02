import 'package:shared_preferences/shared_preferences.dart';

/// Abstract storage contract for key-value local persistence.
abstract class IStorageService {
  Future<void> init();
  Future<bool> setString(String key, String value);
  String? getString(String key);
  Future<bool> setBool(String key, bool value);
  bool? getBool(String key);
  Future<bool> setInt(String key, int value);
  int? getInt(String key);
  Future<bool> remove(String key);
  Future<bool> clear();
  bool hasKey(String key);
}

/// SharedPreferences based implementation of IStorageService.
class StorageService implements IStorageService {
  SharedPreferences? _prefs;
  final Map<String, dynamic> _memoryFallback = {};

  StorageService([this._prefs]);

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> setString(String key, String value) async {
    _memoryFallback[key] = value;
    if (_prefs != null) {
      return await _prefs!.setString(key, value);
    }
    return true;
  }

  @override
  String? getString(String key) {
    if (_prefs != null) {
      return _prefs!.getString(key);
    }
    return _memoryFallback[key] as String?;
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    _memoryFallback[key] = value;
    if (_prefs != null) {
      return await _prefs!.setBool(key, value);
    }
    return true;
  }

  @override
  bool? getBool(String key) {
    if (_prefs != null) {
      return _prefs!.getBool(key);
    }
    return _memoryFallback[key] as bool?;
  }

  @override
  Future<bool> setInt(String key, int value) async {
    _memoryFallback[key] = value;
    if (_prefs != null) {
      return await _prefs!.setInt(key, value);
    }
    return true;
  }

  @override
  int? getInt(String key) {
    if (_prefs != null) {
      return _prefs!.getInt(key);
    }
    return _memoryFallback[key] as int?;
  }

  @override
  Future<bool> remove(String key) async {
    _memoryFallback.remove(key);
    if (_prefs != null) {
      return await _prefs!.remove(key);
    }
    return true;
  }

  @override
  Future<bool> clear() async {
    _memoryFallback.clear();
    if (_prefs != null) {
      return await _prefs!.clear();
    }
    return true;
  }

  @override
  bool hasKey(String key) {
    if (_prefs != null) {
      return _prefs!.containsKey(key);
    }
    return _memoryFallback.containsKey(key);
  }
}
