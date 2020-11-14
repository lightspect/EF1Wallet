import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Model/contactModel.dart';

import '../localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  static const route = '/profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ContactModel user = new ContactModel(
      AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Kobe");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: user.avatar,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                user.address,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Flexible(
              child: Container(
                alignment: Alignment.center,
                height: 240,
                width: 240,
                decoration: BoxDecoration(
                    border: Border.all(color: colorBlue, width: 4.0)),
                child: QrImage(
                  data: user.address,
                ),
              ),
            ),
            LoginButton(
              text: "Copy QR",
              minWidth: 160,
              height: 48,
              borderRadius: 4,
              margin: EdgeInsets.symmetric(vertical: 16),
            ),
            TextFormFieldWidget(
              hintText: AppLocalizations.instance.translate('changepassButton'),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
