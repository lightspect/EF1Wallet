import 'package:flutter/material.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Common/styles.dart';

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
            title: Text('Seed Phrase'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Please click on the Secret Phrase to reveal it before proceeding.'),
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
            "Back",
            style: TextStyle(color: colorBlue),
          ),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                LoginLogo(
                  width: MediaQuery.of(context).size.width / 2,
                ),
                Text(
                  "Secret Backup Phrase",
                  style: loginTitleStyle,
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        Text(
                          "Your secret backup phrase makes it easy to back up and restore your account.",
                        ),
                        Text(
                          "WARNING: Never disclose your backup phrase. Anyone with this phrase can take your Ether forever.",
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
                                    : "Click here to reveal secret words",
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
                        onTap: () {},
                        child: Container(
                          height: 48,
                          width: 160,
                          child: Center(
                            child: Text(
                              'Remind me later',
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
                      text: "Next",
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
                  'Tips: \nStore this phrase in a password manager like 1Password. Write this phrase on a piece of paper and store in a secure location. If you want even more security, write it down on multiple pieces of paper and store each in 2 - 3 different locations. \nMemorize this phrase',
                  style: TextStyle(color: colorBlack, fontSize: 12),
                ),
                Text(
                  "Download this Secret Backup Phrase and keep it stored safely on an external encrypted hard drive or storage medium.",
                  style: TextStyle(color: colorBlack, fontSize: 12),
                ),
              ],
            )));
  }
}
