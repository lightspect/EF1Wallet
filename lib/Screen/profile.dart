import 'package:flutter/material.dart';
import 'package:wallet_app_ef1/Model/contactModel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

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
          ],
        ),
      ),
    );
  }
}
