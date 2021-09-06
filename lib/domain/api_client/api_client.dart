import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '/domain/entity/base_entity_model.dart';
import '/domain/api_client/api_client_exception.dart';
import '/domain/services/local_storage_service.dart';
import '/domain/entity/entities.dart';

class ApiClient {
  static const _host = 'https://jsonplaceholder.typicode.com';
  late final SharedPreferencesStorage localStorageManager;

  static ApiClient? _instance;

  ApiClient._() {
    localStorageManager = SharedPreferencesStorage.instance();
  }

  factory ApiClient.instance() {
    _instance ??= ApiClient._();
    return _instance!;
  }

  // ! Working with SharedPreferences data
  /* -------------------------------------------------------------------------- */
  Future<void> _removeLocalStorageData(String key) async =>
      await localStorageManager.removeData(key);
  Future<String?> _getLocalStorageData(String key) async =>
      await localStorageManager.readData(key);
  Future<void> _saveLocalStorageData(String key, String data) async =>
      await localStorageManager.saveData(key, data);
  /* -------------------------------------------------------------------------- */

  // ! Network helpers
  /* -------------------------------------------------------------------------- */
  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    return parameters != null ? uri.replace(queryParameters: parameters) : uri;
  }

  // ? HTTP GET
  Future<List<T>> _get<T>(
    String path,
    T Function(dynamic json) parser, {
    bool? isCaching,
    String localStorageKey = 'key',
    Map<String, dynamic>? parameters,
  }) async {
    if (isCaching == false) await _removeLocalStorageData(localStorageKey);

    final localData = await _getLocalStorageData(localStorageKey);
    if (localData != null && localData.isNotEmpty) {
      return _jsonParser<T>(localData, parser);
    }

    final url = _makeUri(path, parameters);

    try {
      final response = await http.get(url);
      final resultData = response.body;
      return await _response<T>(
          response, resultData, isCaching, parser, localStorageKey);
    } on SocketException {
      throw FetchDataException(
          '😲 Однако интернета нет!\nПроверьте, пожалуйста! 👆');
    }
  }

  // ? HTTP POST
  Future<List<T>> _post<T extends BaseModel>(
    String path,
    T entity,
    T Function(dynamic json) parser, {
    bool? isCaching,
    String localStorageKey = 'key',
    Map<String, dynamic>? urlParameters,
  }) async {
    try {
      final response = await http.post(
        _makeUri(path, urlParameters),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(entity.toJson()),
      );

      // ! Ну вот если бы, API делал не фейковый POST, то тогда нормальная логика работы была бы
      // ! А сейчас вот 🤷‍♂️ 🤷‍♂️ 🤷‍♂️ ... (так как в ТЗ написано, что сохранять в LocalStorage с генерированным ID)
      // Т.е. POST запрос делается, просто так, чтобы был (он ничего не возвращает всегда одни и те же данные)
      // А данные сохраняю в стораж сгенерированные ...

      String resultData = jsonEncode(entity.toJson());
      // String resultData = response.body;

      if (isCaching == true) {
        resultData = await updateLocalStorageData(localStorageKey, resultData);
      }

      return await _response<T>(
          response, resultData, isCaching, parser, localStorageKey);
    } on SocketException {
      throw FetchDataException('Однако интернета нет. Проверьте, пожалуйста!');
    }
  }

  /* -------------------------------------------------------------------------- */
  // todo Переделать (скорей всего через дата-классы)
  //* Здесь немного "дичи" на скорую руку, обновление строки путем конкатенации
  Future<String> updateLocalStorageData(
      String localStorageKey, String response) async {
    final localData = await _getLocalStorageData(localStorageKey);
    final resultData = localData == null
        ? '[response]'
        : localData.replaceRange(
            localData.length - 1, localData.length, ', $response]');
    return resultData;
  }
  // ! Вышла ещё большая дичь ... :(
  // Future<String> updateLocalStorageData<T extends BaseModel>(
  //   String localStorageKey, response, parser) async {
  // final localData = await _getLocalStorageData(localStorageKey);
  // final json = jsonDecode(localData!);
  // final List<T> result = json.map(parser).cast<T>().toList();
  // result.add(response);
  // return '[${result.map((T obj) => obj.toJson()).join(',')}]';
  // }
  /* -------------------------------------------------------------------------- */

  Future<List<T>> _response<T>(
    http.Response response,
    String resultData,
    bool? isCaching,
    Function(dynamic json) parser,
    String localStorageKey,
  ) async {
    switch (response.statusCode) {
      case 200:
      case 201:
        if (isCaching == true) {
          await _saveLocalStorageData(localStorageKey, resultData);
        }
        return _jsonParser<T>(resultData, parser);
      case 400:
        throw BadRequestException(resultData.toString());
      case 500:
      default:
        throw FetchDataException('Что-то пошло ни так: ${response.statusCode}');
    }
  }

  List<T> _jsonParser<T>(String data, Function(dynamic json) parser) {
    final json = jsonDecode(data);
    if (json is List) {
      return json.map(parser).cast<T>().toList();
    } else if (json is Map) {
      return [parser(json)];
    } else {
      return [];
    }
  }
  /* -------------------------------------------------------------------------- */

  // ! GET data from net
  /* -------------------------------------------------------------------------- */
  Future<List<User>> getUsers({isCaching}) => _get(
        '/users/',
        (json) => User.fromJson(json),
        isCaching: isCaching ?? true,
        localStorageKey: SharedPreferencesStorageKeys.usersKey,
      );
  Future<List<Post>> getUserPosts(int userId, {isCaching}) => _get(
        '/users/$userId/posts',
        (json) => Post.fromJson(json),
        isCaching: isCaching ?? true,
        localStorageKey: '${SharedPreferencesStorageKeys.postsKey}_$userId',
      );
  Future<List<Album>> getUserAlbums(int userId, {isCaching}) => _get(
        '/users/$userId/albums',
        (json) => Album.fromJson(json),
        isCaching: isCaching ?? true,
        localStorageKey: '${SharedPreferencesStorageKeys.albumsKey}_$userId',
      );
  Future<List<Comment>> getPostComments(int postId, {isCaching}) => _get(
        '/posts/$postId/comments',
        (json) => Comment.fromJson(json),
        isCaching: isCaching ?? true,
        localStorageKey: '${SharedPreferencesStorageKeys.commentsKey}_$postId',
      );
  Future<List<Photo>> getAlbumPhotos(int albumId, {isCaching}) => _get(
        '/albums/$albumId/photos',
        (json) => Photo.fromJson(json),
        isCaching: isCaching ?? true,
        localStorageKey: '${SharedPreferencesStorageKeys.photosKey}_$albumId',
      );
  /* -------------------------------------------------------------------------- */

  // ! POST data to net
  /* -------------------------------------------------------------------------- */
  Future<List<Comment>> addPostComment({required Comment comment, isCaching}) {
    return _post<Comment>(
      '/posts/${comment.postId}/comments',
      comment,
      (json) => Comment.fromJson(json),
      isCaching: isCaching ?? true,
      localStorageKey:
          '${SharedPreferencesStorageKeys.commentsKey}_${comment.postId}',
    );
  }
  /* -------------------------------------------------------------------------- */
}
