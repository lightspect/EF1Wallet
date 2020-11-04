import 'dart:async';

import 'package:flutter/material.dart';

class ContactModel with ChangeNotifier {
  AssetImage avatar;
  String address;
  String alias;
  ContactModel(this.avatar, this.address, this.alias);
}

List<ContactModel> searchList = [];
List<ContactModel> contactList = [
  ContactModel(
      AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Alex"),
  ContactModel(
      AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Alex"),
  ContactModel(
      AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Alex"),
  ContactModel(
      AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Alex"),
  ContactModel(
      AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Alex"),
  ContactModel(
      AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Alex"),
  ContactModel(AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Ben"),
  ContactModel(AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Ben"),
  ContactModel(AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Ben"),
  ContactModel(AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Ben"),
  ContactModel(AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Ben"),
  ContactModel(
      AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Cindy"),
  ContactModel(
      AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Cindy"),
  ContactModel(
      AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Cindy"),
  ContactModel(
      AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Cindy"),
  ContactModel(
      AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Adam"),
  ContactModel(AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Bob"),
  ContactModel(
      AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Candace"),
  ContactModel(
      AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Jack"),
];

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
