import 'package:flutter/material.dart';

class TransactionModel with ChangeNotifier {
  AssetImage avatar;
  String alias;
  String address;
  String status;
  DateTime dateTime;
  double amount;

  TransactionModel(this.avatar, this.alias, this.address, this.status,
      this.amount, this.dateTime);
}

class FilterModel with ChangeNotifier {
  int value;
  String type;

  FilterModel(this.value, this.type);
}

List<FilterModel> filterList = [
  FilterModel(1, "D"),
  FilterModel(7, "D"),
  FilterModel(1, "M"),
  FilterModel(3, "M"),
  FilterModel(1, "Y"),
  FilterModel(0, "All"),
];

List<TransactionModel> transactionList = [
  TransactionModel(AssetImage("assets/images/profile.jpg"), "Alex",
      "0xabcxxx...01", "Success", 10, DateTime.parse("2020-11-03 12:34:56")),
  TransactionModel(AssetImage("assets/images/profile.jpg"), "Adam",
      "0xabcxxx...01", "Pending", 10, DateTime.parse("2020-10-09 12:34:56")),
  TransactionModel(AssetImage("assets/images/profile.jpg"), "Ben",
      "0xabcxxx...01", "Drop", 10, DateTime.parse("2020-10-08 12:34:56")),
  TransactionModel(AssetImage("assets/images/profile.jpg"), "Bob",
      "0xabcxxx...01", "Success", 10, DateTime.parse("2020-10-07 12:34:56")),
  TransactionModel(AssetImage("assets/images/profile.jpg"), "Candace",
      "0xabcxxx...01", "Success", 10, DateTime.parse("2020-09-11 12:34:56")),
  TransactionModel(AssetImage("assets/images/profile.jpg"), "Cindy",
      "0xabcxxx...01", "Success", 10, DateTime.parse("2020-09-10 12:34:56")),
  TransactionModel(AssetImage("assets/images/profile.jpg"), "David",
      "0xabcxxx...01", "Pending", 10, DateTime.parse("2020-07-11 12:34:56")),
  TransactionModel(AssetImage("assets/images/profile.jpg"), "Dean",
      "0xabcxxx...01", "Drop", 10, DateTime.parse("2020-07-10 12:34:56")),
  TransactionModel(AssetImage("assets/images/profile.jpg"), "Emiya",
      "0xabcxxx...01", "Drop", 10, DateTime.parse("2019-10-10 12:34:56")),
  TransactionModel(AssetImage("assets/images/profile.jpg"), "Eddy",
      "0xabcxxx...01", "Success", 10, DateTime.parse("2018-10-10 12:34:56")),
  TransactionModel(AssetImage("assets/images/profile.jpg"), "Jack",
      "0xabcxxx...01", "Drop", 10, DateTime.parse("2017-10-10 12:34:56")),
];
