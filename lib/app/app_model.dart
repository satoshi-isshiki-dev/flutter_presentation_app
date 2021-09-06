import 'package:flutter/material.dart';

class AppModel with ChangeNotifier {
  var _darkMode = false;
  bool get darkMode => _darkMode;

  var _gridMode = true;
  bool get gridMode => _gridMode;

  void changeAppTheme() {
    _darkMode = !_darkMode;
    notifyListeners();
  }

  void changeListView() {
    _gridMode = !_gridMode;
    notifyListeners();
  }
}
