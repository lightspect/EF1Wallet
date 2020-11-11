import 'package:flutter/material.dart';

class CoinModel with ChangeNotifier {
  String name;
  double price;
  double lastPrice;
  AssetImage icon;
  CoinModel(this.name, this.price, this.lastPrice, this.icon);
}

List<CoinModel> coinModel = [
  CoinModel(
    "EF1",
    123.456,
    126.444,
    AssetImage('assets/images/coin_ef1.png'),
  ),
  CoinModel(
    "ETH",
    123.456,
    126.444,
    AssetImage('assets/images/coin_eth.png'),
  ),
  CoinModel(
    "BTC",
    126.456,
    123.444,
    AssetImage('assets/images/coin_eth.png'),
  ),
  CoinModel(
    "USDT",
    126.456,
    123.444,
    AssetImage('assets/images/coin_ef1.png'),
  ),
];

class FeesModel {
  String text;
  double value;

  FeesModel(this.text, this.value);
}
