import 'package:flutter/material.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Common/styles.dart';
import 'package:wallet_app_ef1/localizations.dart';

class SeedCreatePage extends StatefulWidget {
  SeedCreatePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SeedCreatePageState createState() => _SeedCreatePageState();
}

class _SeedCreatePageState extends State<SeedCreatePage> {
  bool reveal = false;
  String seed =
      "Your seed phrase makes it easy to back up and restore account.";
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text(AppLocalizations.of(context).translate('seedCreateTitle')),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(AppLocalizations.of(context).translate('alertSeedText')),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          leading: BackButton(color: colorBlue),
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate('backButton'),
            style: TextStyle(color: colorBlue),
          ),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: <Widget>[
                LoginLogo(
                  width: MediaQuery.of(context).size.width / 3.5,
                ),
                Text(
                  AppLocalizations.of(context).translate('seedCreateTitle'),
                  style: loginTitleStyle,
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)
                              .translate('aboutSeedText'),
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .translate('warningSeedText'),
                        ),
                      ],
                    )),
                Ink(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colorBlack),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          reveal = true;
                        });
                      },
                      child: Container(
                        height: 120,
                        padding: EdgeInsets.all(32.0),
                        child: Center(
                          child: Column(
                            children: [
                              Visibility(
                                visible: !reveal,
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                reveal
                                    ? seed
                                    : AppLocalizations.of(context)
                                        .translate('revealSeedText'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: reveal ? 14 : 12),
                              )
                            ],
                          ),
                        ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Ink(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Color(0xff121519),
                            width: 1,
                            style: BorderStyle.solid),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName('/login'));
                        },
                        child: Container(
                          height: 48,
                          width: 160,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('remindButton'),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    LoginButton(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      minWidth: 172,
                      height: 48,
                      color: colorBlue,
                      textColor: Colors.white,
                      text:
                          AppLocalizations.of(context).translate('nextButton'),
                      fontSize: 20,
                      borderColor: colorBlue,
                      borderRadius: 5,
                      onClick: () {
                        reveal
                            ? Navigator.pushNamed(context, '/seedConfirm',
                                arguments: seed)
                            : _showMyDialog();
                      },
                    )
                  ],
                ),
                Text(
                  AppLocalizations.of(context)
                      .translate('tipSeedText')
                      .replaceAll("\\n", "\n"),
                  style: TextStyle(color: colorBlack, fontSize: 12),
                ),
                Text(
                  AppLocalizations.of(context).translate('downloadSeedText'),
                  style: TextStyle(color: colorBlack, fontSize: 12),
                ),
              ],
            )));
  }
}
