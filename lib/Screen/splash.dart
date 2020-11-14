import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';

// This is the Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin /*, AfterLayoutMixin<SplashScreen> */ {
  AnimationController _animationController;
  Animation<double> _animation;
  bool _seen;

  Future<void> checkSetSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _seen = (prefs.getBool('seen') ?? false);

    await prefs.setBool('seen', true);
  }

  @override
  void initState() {
    super.initState();
    checkSetSeen();
    _animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _animation.addListener(() => this.setState(() {}));
    _animationController.forward();

    Timer(Duration(milliseconds: 1500), () {
      if (_seen) {
        Navigator.of(context).pushReplacementNamed('/login');
      } else {
        Navigator.pushReplacementNamed(context, '/intro');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LoginLogo(
                      width: 100.0,
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Text(
                      "EF1",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }

  /*Future checkFirstSeen() async {}

  @override
  void afterFirstLayout(BuildContext context) {
    checkFirstSeen();
  }*/
}
