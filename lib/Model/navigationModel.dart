import 'package:flutter/material.dart';

class AppBarModel with ChangeNotifier {
  bool show = true;

  void hideAppBar(bool status) {
    show = status;
    notifyListeners();
  }
}

class NavBarModel with ChangeNotifier {
  int navIndex = 0;
  bool send = false;

  void changeIndex(int newIndex) {
    navIndex = newIndex;
    notifyListeners();
  }

  void changeSend(bool status) {
    send = status;
    notifyListeners();
  }
}
