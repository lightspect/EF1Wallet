import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Model/navigationModel.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key key, this.title}) : super(key: key);

  final String title;

  static const route = '/home/wallet';

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
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
                                      minWidth: 80,
                                      color: colorRed,
                                      borderColor: colorRed,
                                      text: 'Copy',
                                      textColor: Colors.white,
                                      borderRadius: 10,
                                      fontSize: 12,
                                      margin: EdgeInsets.all(0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
