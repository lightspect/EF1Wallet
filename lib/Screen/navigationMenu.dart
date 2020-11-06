import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Model/destination.dart';
import 'package:wallet_app_ef1/Model/navigationModel.dart';
import 'package:wallet_app_ef1/Screen/contact.dart';
import 'package:wallet_app_ef1/Screen/history.dart';
import 'package:wallet_app_ef1/Screen/profile.dart';
import 'package:wallet_app_ef1/Screen/send.dart';

import 'home.dart';

class NavigationMenu extends StatefulWidget {
  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu>
    with TickerProviderStateMixin<NavigationMenu> {
  String _title = "Home";
  //int _selectedNavIndex = 0;
  int _selectedDrawerIndex = 0;
  List<Widget> navItem = [
    HomePage(),
    ContactPage(),
    HistoryPage(),
    ProfilePage()
  ];
  Color _selectedColor = colorBlue;
  final _recepientController = TextEditingController();
  final _aliasController = TextEditingController();
  String _qrAction = "getAddress";

  Widget _getNavItemWidget(int pos) {
    if (0 <= pos && pos < navItem.length) {
      print(pos);
      return navItem[pos];
    } else {
      return Text("Error");
    }
  }

  Widget _sendWidget() {
    return SendPage();
  }

  Widget _callDialog() {
    return GestureDetector(
      onTap: () {
        _showMyDialog();
      },
      child: Icon(
        Icons.add,
        size: 26.0,
      ),
    );
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
                                _navigateAndReturnData();
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

  void _navigateAndReturnData() async {
    final result =
        await Navigator.pushNamed(context, '/qrscan', arguments: _qrAction);
    setState(() {
      _recepientController.text = result.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    PageController _myPage = PageController(initialPage: 0);
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavBarModel()),
        ChangeNotifierProvider(create: (context) => AppBarModel())
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: MyCustomAppBar(
            height: 75,
            title: _title,
            action: _callDialog(),
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: Container(
              height: 75,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    iconSize: 30.0,
                    padding: EdgeInsets.only(left: 28.0),
                    icon: Icon(Icons.home),
                    onPressed: () {
                      setState(() {
                        _myPage.jumpToPage(0);
                      });
                    },
                  ),
                  IconButton(
                    iconSize: 30.0,
                    padding: EdgeInsets.only(right: 28.0),
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        _myPage.jumpToPage(1);
                      });
                    },
                  ),
                  IconButton(
                    iconSize: 30.0,
                    padding: EdgeInsets.only(left: 28.0),
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      setState(() {
                        _myPage.jumpToPage(3);
                      });
                    },
                  ),
                  IconButton(
                    iconSize: 30.0,
                    padding: EdgeInsets.only(right: 28.0),
                    icon: Icon(Icons.list),
                    onPressed: () {
                      setState(() {
                        _myPage.jumpToPage(4);
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          body: PageView(
            controller: _myPage,
            onPageChanged: (int) {
              print('Page Changes to index $int');
            },
            children: <Widget>[
              HomePage(),
              ContactPage(),
              SendPage(
                pc: _myPage,
              ),
              HistoryPage(),
              ProfilePage()
            ],
            physics:
                NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
          ),
          floatingActionButton: Container(
            height: 65.0,
            width: 65.0,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  _myPage.jumpToPage(2);
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                // elevation: 5.0,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;
  final Widget action;

  const MyCustomAppBar(
      {Key key, @required this.height, @required this.title, this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NavBarModel>(
      builder: (context, provider, child) {
        return Container(
          child: AppBar(
            title: Text(
              title,
              style: TextStyle(color: colorBlack),
            ),
            elevation: 0,
            backgroundColor: colorBG,
            iconTheme: IconThemeData(color: colorBlack),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: provider.navIndex == 1
                    ? action
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
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
