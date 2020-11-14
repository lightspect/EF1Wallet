import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Model/destination.dart';
import 'package:wallet_app_ef1/Model/navigationModel.dart';
import 'package:wallet_app_ef1/Screen/send.dart';

class NavMenu extends StatefulWidget {
  @override
  _NavMenuState createState() => _NavMenuState();
}

class _NavMenuState extends State<NavMenu>
    with TickerProviderStateMixin<NavMenu> {
  int _selectedDrawerIndex = 0;
  final _recepientController = TextEditingController();
  final _aliasController = TextEditingController();
  String _qrAction = "getAddress";

  Widget _sendWidget() {
    return SendPage(
      callDialog: _showMyDialog,
      setRecepient: _setRecepient,
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
    _recepientController.text = "";
    _aliasController.text = "";
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
    if (result.toString() != "null") {
      _setRecepient(result.toString());
    }
  }

  void _setRecepient(String recepient) {
    setState(() {
      _recepientController.text = recepient;
    });
  }

  List<Widget> _drawerOptions() {
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
    return drawerOptions;
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: Builder(
        builder: (context) {
          return Consumer<NavigationProvider>(
            builder: (context, provider, child) {
              // Initialize [Navigator] instance for each screen.
              final screens = provider.screens
                  .map(
                    (screen) => TickerMode(
                      enabled: screen == provider.currentScreen,
                      child: Offstage(
                        offstage: screen != provider.currentScreen,
                        child: Navigator(
                          key: screen.navigatorState,
                          onGenerateRoute: screen.onGenerateRoute,
                        ),
                      ),
                    ),
                  )
                  .toList();
              bool _backButtonVisible =
                  provider.currentScreen.navigatorState.currentState != null &&
                          !provider.sendPage
                      ? provider.currentScreen.navigatorState.currentState
                          .canPop()
                      : provider.appBarVisible;
              return WillPopScope(
                onWillPop: () async => provider.onWillPop(context),
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(
                      provider.childTitle.isNotEmpty && provider.title.isEmpty
                          ? provider.childTitle
                          : provider.title,
                      style: TextStyle(color: colorBlack),
                    ),
                    elevation: 0,
                    backgroundColor: colorBG,
                    iconTheme: IconThemeData(color: colorBlack),
                    leading: _backButtonVisible
                        ? IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () => provider.onWillPop(context),
                          )
                        : null,
                    actions: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child:
                            provider.currentTabIndex == 1 && !provider.sendPage
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
                          padding: EdgeInsets.only(top: 20),
                          height: 148,
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
                                      backgroundImage: AssetImage(
                                          'assets/images/profile.jpg')),
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
                                      onClick: () {
                                        Clipboard.setData(
                                            new ClipboardData(text: ""));
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(children: _drawerOptions()),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(right: 16, bottom: 16),
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "preview v0.01",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                  body: SafeArea(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          child: child,
                          opacity: animation,
                        );
                      },
                      child: provider.sendPage
                          ? _sendWidget()
                          : FadeIndexedStack(
                              children: screens,
                              index: provider.currentTabIndex,
                            ),
                    ),
                  ),
                  bottomNavigationBar: FABBottomAppBar(
                    selectedIndex: provider.currentTabIndex,
                    color: Colors.grey,
                    selectedColor: provider.selectedColor,
                    notchedShape: CircularNotchedRectangle(),
                    onTabSelected: (index) {
                      provider.setTab(index);
                      provider.setSelectedColor(colorBlue);
                      provider.setTitle(provider.currentScreen.title);
                    },
                    items: bottomNavList,
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: Visibility(
                    visible: !keyboardIsOpened,
                    child: FloatingActionButton(
                      onPressed: () {
                        provider.setSendPage(true);
                        provider.setSelectedColor(Colors.grey);
                        provider.setAppBar(false);
                        provider.setChildTitle("");
                      },
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
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
