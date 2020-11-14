import 'package:flutter/material.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Common/styles.dart';
import 'package:wallet_app_ef1/localizations.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  Color _buttonTextColor = Colors.white;
  bool passwordVisible = true;
  bool checkedValue = false;
  final _formKey = GlobalKey<FormState>();
  final _repasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _repasswordControllerFocus = FocusNode();
  final FocusNode _passwordControllerFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context).translate('termText')),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(AppLocalizations.of(context).translate('alertTermText')),
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
        return AppLocalizations.of(context).translate('passwordBlankText');
      } else if (password.length < 8) {
        return AppLocalizations.of(context).translate('passwordErrorText');
      }
      return null;
    }

    String checkRepassword(String repassword) {
      if (repassword.isEmpty) {
        return AppLocalizations.of(context).translate('repasswordBlankText');
      } else if (_passwordController.text != _repasswordController.text) {
        return AppLocalizations.of(context).translate('repasswordErrorText');
      }
      return null;
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
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              LoginLogo(width: MediaQuery.of(context).size.width / 2.5),
              Text(
                  AppLocalizations.of(context).translate('createPasswordTitle'),
                  style: loginTitleStyle),
              TextFormFieldWidget(
                hintText:
                    AppLocalizations.of(context).translate('passwordsHintText'),
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
              TextFormFieldWidget(
                hintText: AppLocalizations.of(context)
                    .translate('repasswordHintText'),
                obscureText: passwordVisible,
                textInputType: TextInputType.visiblePassword,
                actionKeyboard: TextInputAction.done,
                functionValidate: checkRepassword,
                controller: _repasswordController,
                focusNode: _repasswordControllerFocus,
                onSubmitField: () {},
              ),
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setBoxState) {
                return CheckboxListTile(
                  title: new RichText(
                    text: new TextSpan(
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: colorBlack,
                      ),
                      children: <TextSpan>[
                        new TextSpan(
                            text: AppLocalizations.of(context)
                                .translate('agreeTermText')),
                        new TextSpan(
                            text: " " +
                                AppLocalizations.of(context)
                                    .translate('termText'),
                            style: new TextStyle(color: colorBlue)),
                      ],
                    ),
                  ),
                  value: checkedValue,
                  onChanged: (newValue) {
                    setBoxState(() {
                      checkedValue = newValue;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                );
              }),
              LoginButton(
                text: AppLocalizations.of(context)
                    .translate('registrationButton'),
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
    );
  }
}
