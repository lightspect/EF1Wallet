import 'package:flutter/material.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Common/styles.dart';

class LoginPage extends StatelessWidget {
  String action = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 48),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            LoginLogo(
              width: MediaQuery.of(context).size.width / 2.5,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "EF1",
                    style: ef1TitleStyle,
                  ),
                  Text(
                    " WALLET",
                    style: ef1SubtitleStyle,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 48),
              child: Column(
                children: [
                  LoginButton(
                    text: "Create Wallet",
                    onClick: () {
                      action = "create";
                      Navigator.pushNamed(context, '/term', arguments: action);
                    },
                  ),
                  LoginButton(
                    text: "Import Wallet",
                    onClick: () {
                      action = "import";
                      Navigator.pushNamed(context, '/term', arguments: action);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        child: AspectRatio(
          aspectRatio: 12 / 5,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.none,
                alignment: FractionalOffset(0.2, 0.1),
                image: AssetImage('assets/images/bottom_login.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
