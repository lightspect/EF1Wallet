import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Common/styles.dart';
import 'package:flutter/material.dart';

class TermService extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TermServiceState();
}

class _TermServiceState extends State<TermService> {
  @override
  Widget build(BuildContext context) {
    final String action = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        margin: EdgeInsets.only(top: 32),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            LoginLogo(width: MediaQuery.of(context).size.width / 2.5),
            Container(
              margin: EdgeInsets.only(bottom: 12.0),
              child:
                  Text("Help Us Improve EagleF1nance", style: loginTitleStyle),
            ),
            Container(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginButton(
                    minWidth: 160,
                    height: 48,
                    color: colorBG,
                    textColor: colorBlack,
                    text: "No thanks",
                    fontSize: 20,
                    borderColor: colorBlack,
                    borderRadius: 5,
                  ),
                  LoginButton(
                    minWidth: 160,
                    height: 48,
                    color: colorBlue,
                    textColor: Colors.white,
                    text: "I agree",
                    fontSize: 20,
                    borderColor: colorBlue,
                    borderRadius: 5,
                    onClick: () {
                      if (action == "create")
                        Navigator.pushNamed(context, '/seedCreate');
                      else
                        Navigator.pushNamed(context, '/seedImport');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
