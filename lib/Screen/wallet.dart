import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Model/coinModel.dart';
import 'package:wallet_app_ef1/Model/navigationModel.dart';
import 'package:wallet_app_ef1/localizations.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key key, this.title}) : super(key: key);

  final String title;

  static const route = '/home/wallet';

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NavigationProvider>(
        create: (context) => NavigationProvider(),
        child: Builder(builder: (context) {
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.symmetric(vertical: 32),
                    child: Container(
                      height: 200,
                      padding: EdgeInsets.fromLTRB(28, 16, 28, 28),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: AssetImage('assets/images/wallet_card.png'),
                            fit: BoxFit.cover),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "EF1",
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.white),
                                    ),
                                    Text(
                                      "EagleFinance",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Image(
                                image: AssetImage("assets/images/coin_ef1.png"),
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    color: colorLightBlue,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "0xabcxxx...01",
                                      style: TextStyle(color: colorBlue),
                                    ),
                                    LoginButton(
                                      height: 20,
                                      minWidth: 40,
                                      color: colorRed,
                                      borderColor: colorRed,
                                      text: 'Copy',
                                      textColor: Colors.white,
                                      borderRadius: 10,
                                      fontSize: 12,
                                      margin: EdgeInsets.only(left: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "6,789.000 EF1",
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.white),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "+0.15 USD/ EF1",
                                          style: TextStyle(
                                              fontSize: 12, color: colorGreen),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_up,
                                          color: colorGreen,
                                        ),
                                        Text(
                                          "1.23%",
                                          style: TextStyle(
                                              fontSize: 12, color: colorGreen),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                r"$ 16,789.000",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      AppLocalizations.of(context).translate('24hChangeText'),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Flexible(
                    child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image: coinModel[index].icon,
                                    width: 40,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        coinModel[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        r"$ " +
                                            coinModel[index]
                                                .lastPrice
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(coinModel[index].price.toString()),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            coinModel[index].price >=
                                                    coinModel[index].lastPrice
                                                ? Icons.arrow_drop_up
                                                : Icons.arrow_drop_down,
                                            color: coinModel[index].price >=
                                                    coinModel[index].lastPrice
                                                ? colorGreen
                                                : colorRed,
                                          ),
                                          Text(
                                            roundDouble(
                                                        (coinModel[index]
                                                                        .lastPrice -
                                                                    coinModel[
                                                                            index]
                                                                        .price)
                                                                .abs() /
                                                            100,
                                                        2)
                                                    .toString() +
                                                " %",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: coinModel[index].price >=
                                                      coinModel[index].lastPrice
                                                  ? colorGreen
                                                  : colorRed,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  LoginButton(
                                    minWidth: 52,
                                    height: 20,
                                    text: "View",
                                    textColor: Colors.white,
                                    borderRadius: 10,
                                    borderColor: colorGreen,
                                    color: colorGreen,
                                    fontSize: 10,
                                  )
                                ],
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemCount: coinModel.length),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
