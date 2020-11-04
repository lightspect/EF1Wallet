/*import 'package:flutter/material.dart';

class ButtonModel with ChangeNotifier {
  List<String> seedArray = [];
  List<String> seedText = [];
  List<bool> clicked = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  String seedString = "";
  bool check = false;

  void checkClicked(List<String> array, String text, int pos) {
    seedArray = array;
    if (seedArray.contains(text) && seedText.contains(text)) {
      clicked[pos] = false;
    } else {
      clicked[pos] = true;
    }
    notifyListeners();
  }

  void changeArray(List<String> array, String text) {
    seedString = "";
    seedArray = array;
    if (seedArray.contains(text) && seedText.contains(text)) {
      seedText.remove(text);
    } else {
      seedText.add(text);
    }
    for (String seed in seedText) {
      seedString += seed + " ";
    }
    notifyListeners();
  }

  void checkArray(String text) {
    if (seedString.isNotEmpty) {
      seedString = seedString.substring(0, seedString.length - 1);
    }
    if (text == seedString) {
      check = true;
    } else {
      check = false;
    }
    notifyListeners();
  }
}*/

class ButtonModelTest {
  String buttonText;
  bool status;
  ButtonModelTest(this.buttonText, this.status);
}
