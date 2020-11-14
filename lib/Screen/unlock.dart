import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Common/styles.dart';
import 'package:flutter/material.dart';

class UnlockPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UnlockPageState();
}

class _UnlockPageState extends State<UnlockPage> {
  Color _buttonTextColor = Colors.white;
  bool passwordVisible = true;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final FocusNode _passwordControllerFocus = FocusNode();

  String checkPassword(String password) {
    if (password.isEmpty) {
      return 'Please enter Password';
    } else if (password.length < 8) {
      return 'Password length must be 8 characters or longer';
    }
    return null;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: "Error",
          icon: Icon(
            Icons.error,
            color: colorRed,
          ),
          bodySubtitle: "Password provided is incorrect",
          bodyAction: [
            LoginButton(
              margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
              color: colorBlue,
              borderColor: colorBlue,
              borderRadius: 4,
              text: "Try Again",
              onClick: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool checkedValue() {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              LoginLogo(),
              Text("Create a Password", style: loginTitleStyle),
              TextFormFieldWidget(
                hintText: "Passwords (Minimum of 8 characters)",
                obscureText: passwordVisible,
                textInputType: TextInputType.visiblePassword,
                actionKeyboard: TextInputAction.next,
                functionValidate: checkPassword,
                controller: _passwordController,
                focusNode: _passwordControllerFocus,
                suffixIcon: IconButton(
                  icon: Icon(
                    !passwordVisible ? Icons.visibility : Icons.visibility_off,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
              ),
              LoginButton(
                text: "Unlock",
                color: colorBlue,
                borderRadius: 5,
                highlightColor: colorBlue,
                onClick: () {
                  var validate = _formKey.currentState.validate();
                  if (!validate) {
                  } else if (checkedValue()) {
                    _showMyDialog();
                  } else {
                    _formKey.currentState.save();
                    Navigator.pushNamed(context, '/navigationMenu');
                  }
                },
                borderColor: colorBlue,
                textColor: _buttonTextColor,
              ),
              Container(
                height: 64,
                margin: EdgeInsets.only(top: 40),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundColor: colorBlack,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          radius: 8,
                        ),
                        CircleAvatar(
                          backgroundColor: colorBlack,
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          radius: 8,
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Create Wallet"),
                          Text("Import Wallet"),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
