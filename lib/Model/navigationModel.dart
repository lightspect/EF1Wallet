import 'package:flutter/material.dart';

class AppBarModel with ChangeNotifier {
  bool show = true;

  void hideAppBar(bool status) {
    show = status;
    notifyListeners();
  }
}
