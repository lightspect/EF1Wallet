import 'package:flutter/material.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Common/styles.dart';

class SeedSuccessPage extends StatefulWidget {
  SeedSuccessPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SeedSuccessPageState createState() => _SeedSuccessPageState();
}

class _SeedSuccessPageState extends State<SeedSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBG,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        margin: EdgeInsets.only(top: 32),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            LoginLogo(
              width: MediaQuery.of(context).size.width / 3.5,
            ),
            Text(
              "Congratulation",
              style: loginTitleStyle,
            ),
            Container(
              margin: EdgeInsets.only(top: 16, bottom: 16),
              child: Column(),
            ),
            LoginButton(
              minWidth: 160,
              height: 48,
              color: colorBlue,
              textColor: Colors.white,
              text: "Continue",
              fontSize: 20,
              borderColor: colorBlue,
              borderRadius: 5,
              onClick: () {
                Navigator.pushNamed(context, '/registration');
              },
            ),
          ],
        ),
      ),
    );
  }
}
