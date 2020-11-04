import 'package:flutter/material.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Common/styles.dart';

class SeedImportPage extends StatefulWidget {
  SeedImportPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SeedImportPageState createState() => _SeedImportPageState();
}

class _SeedImportPageState extends State<SeedImportPage> {
  Color _buttonTextColor = Colors.white;
  bool passwordVisible = true;
  bool seedPhraseVisible = true;
  bool checkedValue = false;
  final _formKey = GlobalKey<FormState>();
  final _repasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _seedPhraseController = TextEditingController();
  final FocusNode _repasswordControllerFocus = FocusNode();
  final FocusNode _passwordControllerFocus = FocusNode();
  final FocusNode _seedPhraseControllerFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Term of Use'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Please agree to our Term of Use to proceed.'),
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

    String checkPassword(String password) {
      if (password.isEmpty) {
        return 'Please enter Password';
      } else if (password.length < 8) {
        return 'Password length must be 8 characters or longer';
      }
      return null;
    }

    String checkRepassword(String repassword) {
      if (repassword.isEmpty) {
        return 'Please re-enter Password';
      } else if (_passwordController.text != _repasswordController.text) {
        return 'Re-enter password must be the same';
      }
      return null;
    }

    String checkSeedPhrase(String seed) {
      if (seed.isEmpty ||
          ![12, 15, 18, 21, 24].contains(seed.split(" ").length)) {
        return 'Seed phrases contain 12, 15, 18, 21, or 24 words';
      }
      return null;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBG,
        leading: BackButton(color: colorBlue),
        elevation: 0,
        title: Text(
          "Back",
          style: TextStyle(color: colorBlue),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  LoginLogo(),
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 4),
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: Text(
                      "Import an account with seed phrase",
                      style: loginTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextFormFieldWidget(
                    hintText: "Seed phrase",
                    obscureText: seedPhraseVisible,
                    textInputType: TextInputType.visiblePassword,
                    actionKeyboard: TextInputAction.next,
                    functionValidate: checkSeedPhrase,
                    controller: _seedPhraseController,
                    focusNode: _seedPhraseControllerFocus,
                    onSubmitField: () {
                      changeFocus(context, _seedPhraseControllerFocus,
                          _passwordControllerFocus);
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        !seedPhraseVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          seedPhraseVisible = !seedPhraseVisible;
                        });
                      },
                    ),
                  ),
                  TextFormFieldWidget(
                    hintText: "Passwords (Minimum of 8 characters)",
                    obscureText: passwordVisible,
                    textInputType: TextInputType.visiblePassword,
                    actionKeyboard: TextInputAction.next,
                    functionValidate: checkPassword,
                    controller: _passwordController,
                    focusNode: _passwordControllerFocus,
                    onSubmitField: () {
                      changeFocus(context, _passwordControllerFocus,
                          _repasswordControllerFocus);
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        !passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                  TextFormFieldWidget(
                    hintText: "Re-enter Passwords",
                    obscureText: passwordVisible,
                    textInputType: TextInputType.visiblePassword,
                    actionKeyboard: TextInputAction.done,
                    functionValidate: checkRepassword,
                    controller: _repasswordController,
                    focusNode: _repasswordControllerFocus,
                    onSubmitField: () {},
                  ),
                  StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return CheckboxListTile(
                      title: new RichText(
                        text: new TextSpan(
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: colorBlack,
                          ),
                          children: <TextSpan>[
                            new TextSpan(text: 'I have read and agree to the'),
                            new TextSpan(
                                text: ' Term of Use',
                                style: new TextStyle(color: colorBlue)),
                          ],
                        ),
                      ),
                      value: checkedValue,
                      onChanged: (newValue) {
                        setState(() {
                          checkedValue = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    );
                  }),
                  LoginButton(
                    text: "Registration",
                    color: colorBlue,
                    borderRadius: 5,
                    highlightColor: colorBlue,
                    onClick: () {
                      var validate = _formKey.currentState.validate();
                      if (!validate) {
                      } else if (!checkedValue) {
                        _showMyDialog();
                      } else {
                        _formKey.currentState.save();
                        Navigator.pushNamed(context, '/navigationMenu');
                      }
                    },
                    borderColor: colorBlue,
                    textColor: _buttonTextColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
