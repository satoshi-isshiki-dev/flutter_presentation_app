import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorageKeys {
  static const String usersKey = 'GET_USERS_KEY';
  static const String postsKey = 'GET_POSTS_KEY';
  static const String albumsKey = 'GET_ALBUMS_KEY';
  static const String photosKey = 'GET_PHOTOS_KEY';
  static const String commentsKey = 'GET_COMMENTS_KEY';
}

class SharedPreferencesStorage {
  static SharedPreferencesStorage? _instance;
  SharedPreferencesStorage._();

  factory SharedPreferencesStorage.instance() {
    _instance ??= SharedPreferencesStorage._();
    return _instance!;
  }

  SharedPreferences? _pref;

  Future<SharedPreferences> get preferences async {
    _pref ??= await SharedPreferences.getInstance();
    return _pref!;
  }

  Future<void> saveData(String key, String data) async {
    (await preferences).setString(key, data);
  }

  Future<String?> readData(String key) async {
    return (await preferences).getString(key);
  }

  Future<void> removeData(String key) async {
    final _pref = await preferences;
    if (_pref.containsKey(key)) {
      _pref.remove(key);
    }
  }
}
