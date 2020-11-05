import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Model/destination.dart';
import 'package:wallet_app_ef1/Screen/contact.dart';
import 'package:wallet_app_ef1/Screen/history.dart';
import 'package:wallet_app_ef1/Screen/profile.dart';

import 'home.dart';

class NavigationMenu extends StatefulWidget {
  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu>
    with TickerProviderStateMixin<NavigationMenu> {
  String _title = "Home";
  int _selectedNavIndex = 0;
  int _selectedDrawerIndex = 0;
  List<Widget> navItem = [
    HomePage(),
    ContactPage(),
    HistoryPage(),
    ProfilePage()
  ];

  void _selectedTab(int index) {
    setState(() {
      _selectedNavIndex = index;
      _title = bottomNavList[index].text;
    });
  }

  Widget _getNavItemWidget(int pos) {
    if (0 <= pos && pos < navItem.length) {
      return navItem[pos];
    } else {
      return Text("Error");
    }
  }

  void _onSelectItem(int index) {
    Navigator.of(context).pop(); // close the drawer
    _onDrawerTap(index);
  }

  void _onDrawerTap(int index) {
    switch (index) {
      case 1:
        Navigator.pushNamed(context, '/termCondition');
        break;
      case 2:
        Navigator.pushNamed(context, '/aboutUs');
        break;
      default:
    }
  }

  Future<void> _showMyDialog() async {
    final _recepientController = TextEditingController();
    final _aliasController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add To Address Book',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Add Recepient"),
                      Container(
                        margin: EdgeInsets.only(top: 12, bottom: 16),
                        child: TextFormField(
                          cursorColor: colorBlue,
                          style: TextStyle(
                            color: colorBlack,
                            fontSize: 12.0,
                            letterSpacing: 1.2,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.qr_code_scanner),
                              onPressed: () {
                                Navigator.pushNamed(context, '/qrscan');
                              },
                            ),
                            hintText: "Recepient",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorBlack),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorBlack),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: colorBlack),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              letterSpacing: 1.2,
                            ),
                            isDense: true,
                          ),
                          controller: _recepientController,
                          onFieldSubmitted: (value) {},
                        ),
                      ),
                      Text("Enter an Alias"),
                      Container(
                        padding: EdgeInsets.only(top: 12),
                        child: TextFormField(
                          cursorColor: colorBlue,
                          style: TextStyle(
                            color: colorBlack,
                            fontSize: 12.0,
                            letterSpacing: 1.2,
                          ),
                          decoration: InputDecoration(
                            hintText: "Alias",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorBlack),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorBlack),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: colorBlack),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              letterSpacing: 1.2,
                            ),
                            isDense: true,
                          ),
                          controller: _aliasController,
                          onFieldSubmitted: (value) {},
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LoginButton(
                  height: 40,
                  minWidth: 128,
                  color: colorBG,
                  borderColor: colorBlack,
                  borderRadius: 4,
                  text: "Cancel",
                  textColor: colorBlack,
                  onClick: () {
                    Navigator.of(context).pop();
                  },
                ),
                LoginButton(
                  height: 40,
                  minWidth: 128,
                  color: colorBlue,
                  borderColor: colorBlue,
                  borderRadius: 4,
                  text: "Save",
                  onClick: () {},
                )
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < drawerList.length; i++) {
      var d = drawerList[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: TextStyle(color: colorBlack),
        ),
        elevation: 0,
        backgroundColor: colorBG,
        iconTheme: IconThemeData(color: colorBlack),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: _selectedNavIndex == 1
                ? GestureDetector(
                    onTap: () {
                      _showMyDialog();
                    },
                    child: Icon(
                      Icons.add,
                      size: 26.0,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/qrscan');
                    },
                    child: Icon(
                      Icons.qr_code_scanner,
                      size: 26.0,
                    ),
                  ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 108,
              color: colorLightBlue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                          radius: 26,
                          backgroundImage:
                              AssetImage('assets/images/profile.jpg')),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("ID : 0xabcxxx...001"),
                        LoginButton(
                          height: 20,
                          minWidth: 80,
                          color: Colors.white,
                          text: 'Copy ID',
                          textColor: colorLightGreen,
                          borderRadius: 10,
                          fontSize: 12,
                          margin: EdgeInsets.all(0),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(children: drawerOptions)
          ],
        ),
      ),
      body: SafeArea(child: _getNavItemWidget(_selectedNavIndex)),
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.grey,
        selectedColor: colorBlue,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: bottomNavList,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Send',
        child: Transform.rotate(
          angle: -3.14 / 4,
          child: IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        ),
        elevation: 2.0,
      ),
    );
  }
}
