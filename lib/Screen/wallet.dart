import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app_ef1/Model/navigationModel.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppBarModel>(
        create: (context) => AppBarModel(),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(),
            body: Container(),
          );
        }));
  }
}
