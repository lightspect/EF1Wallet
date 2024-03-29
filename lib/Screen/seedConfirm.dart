import 'package:flutter/material.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Common/styles.dart';
import 'package:wallet_app_ef1/Model/buttonModel.dart';

import '../localizations.dart';

class SeedConfirmPage extends StatefulWidget {
  SeedConfirmPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SeedConfirmPageState createState() => _SeedConfirmPageState();
}

class _SeedConfirmPageState extends State<SeedConfirmPage> {
  @override
  Widget build(BuildContext context) {
    final String seed = ModalRoute.of(context).settings.arguments;
    List<String> seedArray = seed.split(" ")..shuffle();
    //Test Button Model without Change Notifier
    List<ButtonModelTest> buttonList = [];
    List<String> seedList = [];
    String seedString = "";
    for (int i = 0; i < seedArray.length; i++) {
      buttonList.add(ButtonModelTest(seedArray[i], false));
    }

    void setSeedString(String seed) {
      seedString = "";
      if (seedList.contains(seed)) {
        seedList.remove(seed);
      } else {
        seedList.add(seed);
      }
      for (int i = 0; i < seedList.length; i++) {
        seedString += seedList[i] + " ";
      }
    }

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Secret Phrase Test'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'You have entered the wrong Key Phrase.\nPlease try again.',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Try Again'),
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
        backgroundColor: colorBG,
        leading: BackButton(color: colorBlue),
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate('backButton'),
          style: TextStyle(color: colorBlue),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Column(
          children: <Widget>[
            LoginLogo(
              width: MediaQuery.of(context).size.width / 3.5,
            ),
            Container(
              margin: EdgeInsets.only(top: 16, bottom: 4),
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                AppLocalizations.of(context).translate('confirmSeedTitle'),
                style: loginTitleStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              AppLocalizations.of(context).translate('confirmSeedText'),
              style: TextStyle(
                fontSize: 12,
                color: colorBlack,
              ),
              textAlign: TextAlign.justify,
            ),
            StatefulBuilder(
                builder: (BuildContext context, StateSetter setButtonState) {
              return Column(
                children: [
                  Container(
                    height: 120,
                    padding: EdgeInsets.all(32.0),
                    margin: EdgeInsets.only(top: 28, bottom: 28),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: colorBlack),
                    child: Center(
                        child: Text(
                      seedString,
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 144,
                    child: GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 5),
                      children: <Widget>[
                        for (var i = 0; i < seedArray.length; i++)
                          MaterialButton(
                            color: buttonList[i].status
                                ? colorBlack
                                : colorLightBlue,
                            textColor:
                                buttonList[i].status ? Colors.white : colorBlue,
                            minWidth: MediaQuery.of(context).size.width,
                            height: 32,
                            child: Text(
                              buttonList[i].buttonText,
                              style: TextStyle(fontSize: 12),
                            ),
                            onPressed: () {
                              setButtonState(() {
                                buttonList[i].status = !buttonList[i].status;
                                setSeedString(buttonList[i].buttonText);
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              );
            }),
            LoginButton(
              margin: EdgeInsets.only(top: 0),
              minWidth: 160,
              height: 48,
              color: colorBlue,
              textColor: Colors.white,
              text: AppLocalizations.of(context).translate('nextButton'),
              fontSize: 20,
              borderColor: colorBlue,
              borderRadius: 5,
              onClick: () {
                if (seedString.isNotEmpty) {
                  if (seed == seedString.substring(0, seedString.length - 1)) {
                    Navigator.pushNamed(context, '/seedSuccess');
                  } else {
                    _showMyDialog();
                  }
                } else {
                  _showMyDialog();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
