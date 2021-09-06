import 'package:flutter/widgets.dart';
import 'package:flutter_presentation_app/domain/api_client/api_client.dart';
import 'package:flutter_presentation_app/domain/api_client/api_client_exception.dart';
import 'package:flutter_presentation_app/domain/entity/entities.dart';

class PostDetailsViewModel with ChangeNotifier {
  final _apiClient = ApiClient.instance();

  String? _errorMessage;
  String? get errorMesage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isDone = false;
  bool get isDone => _isDone;

  List<Comment> _comments = [];
  List<Comment> get comments => [..._comments.reversed];

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final bodyTextController = TextEditingController();
  String? _validationErrorMessage;
  String? get validationErrorMessage => _validationErrorMessage;

  Future<void> fetchComments(int postId) async {
    _updateViewWithLoadingData();
    try {
      _comments = await _apiClient.getPostComments(postId);
    } on FetchDataException catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } on BadRequestException catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
    _updateViewWithDoneData();
  }

  Future<void> addComment(int postId, BuildContext context) async {
    final name = nameTextController.text.trim();
    final email = emailTextController.text.trim();
    final body = bodyTextController.text.trim();

    // Simple D... Validation Form
    if (name.isEmpty || email.isEmpty || body.isEmpty) {
      _validationErrorMessage =
          'Заполните все обязательные поля:\n\n* Имя пользователя\n* E-mail\n* Комментарий\n';
      notifyListeners();
      return;
    }

    // nameTextController.addListener(() {
    //   if (name.isEmpty) {
    //     _validationErrorMessage = null;
    //     notifyListeners();
    //   }
    // });

    Navigator.pop(context);
    _updateViewWithLoadingData();
    _clearTextFields();

    Comment comment = _createCommentByPostId(postId, name, email, body);
    try {
      // ? Поскольку местный API не обновляет списки после отправки POST
      // ! Пришлось (опять ...) извращаться
      // Т.е. сначала дернули из сети все комменты, "закэшировали" их, а потом бахнули комментарий и "прикэшировали" его к полученному уже списку
      if (_comments.isEmpty) {
        await _apiClient.getPostComments(comment.postId);
      }
      _comments = await _apiClient.addPostComment(comment: comment);
    } on FetchDataException catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } on BadRequestException catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
    _updateViewWithDoneData();
  }

  /* -------------------------------------------------------------------------- */
  void _clearTextFields() {
    nameTextController.text = '';
    emailTextController.text = '';
    bodyTextController.text = '';
  }

  Comment _createCommentByPostId(
      int postId, String name, String email, String body) {
    int commentId = _comments.isNotEmpty ? _comments.last.id : 1;
    Comment comment = Comment(
      postId: postId,
      id: ++commentId,
      name: name,
      email: email,
      body: body,
    );
    return comment;
  }

  void _updateViewWithLoadingData() {
    _validationErrorMessage = null;
    _errorMessage = null;
    _isLoading = true;
    _isDone = false;
    notifyListeners();
  }

  void _updateViewWithDoneData() {
    _isLoading = false;
    _isDone = true;
    notifyListeners();
  }
  /* -------------------------------------------------------------------------- */
}
