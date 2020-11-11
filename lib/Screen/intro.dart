import 'package:flutter/material.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Common/styles.dart';

class IntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final int _numPage = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    list.add(Spacer());
    for (int i = 0; i < _numPage; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    list.add(_skipButton());
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isActive ? 36 : 8,
      decoration: BoxDecoration(
        color: colorBlue,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _skipButton() {
    return Expanded(
      child: FlatButton(
        child: Text(
          "SKIP",
          style: TextStyle(color: colorBlue),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/login');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 48),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            LoginLogo(
              width: MediaQuery.of(context).size.width / 2.5,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "EF1",
                    style: ef1TitleStyle,
                  ),
                  Text(
                    " WALLET",
                    style: ef1SubtitleStyle,
                  )
                ],
              ),
            ),
            Container(
              height: 450,
              child: PageView(
                physics: ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Image(
                          image: AssetImage('assets/images/bg_1.png'),
                        ),
                      ),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Text(
                          "COMPLETE PACKS",
                          style: loginTitleStyle,
                        ),
                      ))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Image(
                          image: AssetImage('assets/images/bg_2.png'),
                        ),
                      ),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Text(
                          "EARN COINS",
                          style: loginTitleStyle,
                        ),
                      ))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Image(
                          image: AssetImage('assets/images/bg_3.png'),
                        ),
                      ),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Text(
                          "REDEEM COINS",
                          style: loginTitleStyle,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
            //_currentPage != _numPage - 1 ? Expanded(child: Align(alignment: FractionalOffset.bottomRight,))
          ],
        ),
      ),
      bottomSheet: _currentPage == _numPage - 1
          ? Container(
              height: 100,
              width: double.infinity,
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: colorBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
