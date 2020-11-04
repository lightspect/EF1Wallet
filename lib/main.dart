import 'package:flutter/material.dart';
import 'package:wallet_app_ef1/Screen/aboutUs.dart';
import 'package:wallet_app_ef1/Screen/intro.dart';
import 'package:wallet_app_ef1/Screen/login.dart';
import 'package:wallet_app_ef1/Screen/navigationMenu.dart';
import 'package:wallet_app_ef1/Screen/qrscan.dart';
import 'package:wallet_app_ef1/Screen/registration.dart';
import 'package:wallet_app_ef1/Screen/seedConfirm.dart';
import 'package:wallet_app_ef1/Screen/seedCreate.dart';
import 'package:wallet_app_ef1/Screen/seedImport.dart';
import 'package:wallet_app_ef1/Screen/seedSuccess.dart';
import 'package:wallet_app_ef1/Screen/term.dart';
import 'package:wallet_app_ef1/Screen/termCondition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IntroPage(),
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginPage(),
        '/term': (context) => TermService(),
        '/seedCreate': (context) => SeedCreatePage(),
        '/seedConfirm': (context) => SeedConfirmPage(),
        '/seedSuccess': (context) => SeedSuccessPage(),
        '/registration': (context) => RegistrationPage(),
        '/seedImport': (context) => SeedImportPage(),
        '/navigationMenu': (context) => NavigationMenu(),
        '/termCondition': (context) => TermConditionPage(),
        '/aboutUs': (context) => AboutUsPage(),
        '/qrscan': (context) => ScanScreen(),
      },
    );
  }
}
