class CustomException implements Exception {
  final String? _prefix;
  final String? _message;

  CustomException([this._message, this._prefix]);

  @override
  String toString() => "$_prefix$_message";
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "Ошибка получения данных!\n\n");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Не верный адрес запроса!\n");
}
