import 'package:flutter/material.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Common/styles.dart';

class TermConditionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Term and Condition",
          style: TextStyle(color: colorBlack),
        ),
        elevation: 0,
        backgroundColor: colorBG,
        iconTheme: IconThemeData(color: colorBlack),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        margin: EdgeInsets.only(top: 32),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            LoginLogo(width: MediaQuery.of(context).size.width / 2.5),
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
            Container(),
          ],
        ),
      ),
    );
  }
}
