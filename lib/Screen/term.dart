import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Common/styles.dart';
import 'package:flutter/material.dart';
import 'package:wallet_app_ef1/localizations.dart';

class TermService extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TermServiceState();
}

class _TermServiceState extends State<TermService> {
  @override
  Widget build(BuildContext context) {
    final String action = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBG,
        elevation: 0,
        leading: Container(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            LoginLogo(width: MediaQuery.of(context).size.width / 2.5),
            Container(
              margin: EdgeInsets.only(bottom: 12.0),
              child: Text(
                AppLocalizations.of(context).translate('termTitle'),
                style: loginTitleStyle,
                textAlign: TextAlign.center,
              ),
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
                    text: AppLocalizations.of(context)
                        .translate('nothanksButton'),
                    fontSize: 20,
                    borderColor: colorBlack,
                    borderRadius: 5,
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  LoginButton(
                    minWidth: 160,
                    height: 48,
                    color: colorBlue,
                    textColor: Colors.white,
                    text:
                        AppLocalizations.of(context).translate('iagreeButton'),
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
