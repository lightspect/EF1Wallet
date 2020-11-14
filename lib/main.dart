import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app_ef1/Screen/aboutUs.dart';
import 'package:wallet_app_ef1/Screen/intro.dart';
import 'package:wallet_app_ef1/Screen/login.dart';
import 'package:wallet_app_ef1/Screen/navMenu.dart';
import 'package:wallet_app_ef1/Screen/qrscan.dart';
import 'package:wallet_app_ef1/Screen/registration.dart';
import 'package:wallet_app_ef1/Screen/seedConfirm.dart';
import 'package:wallet_app_ef1/Screen/seedCreate.dart';
import 'package:wallet_app_ef1/Screen/seedImport.dart';
import 'package:wallet_app_ef1/Screen/seedSuccess.dart';
import 'package:wallet_app_ef1/Screen/send.dart';
import 'package:wallet_app_ef1/Screen/splash.dart';
import 'package:wallet_app_ef1/Screen/term.dart';
import 'package:wallet_app_ef1/Screen/termCondition.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'Model/languageModel.dart';
import 'localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(
    appLanguage: appLanguage,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AppLanguage appLanguage;

  MyApp({this.appLanguage});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => appLanguage,
      child: Consumer<AppLanguage>(builder: (context, model, child) {
        return MaterialApp(
          locale: model.appLocal,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('vi', 'VN')
          ],
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen(),
          initialRoute: '/',
          routes: {
            '/intro': (context) => IntroPage(),
            '/login': (context) => LoginPage(),
            '/term': (context) => TermService(),
            '/seedCreate': (context) => SeedCreatePage(),
            '/seedConfirm': (context) => SeedConfirmPage(),
            '/seedSuccess': (context) => SeedSuccessPage(),
            '/registration': (context) => RegistrationPage(),
            '/seedImport': (context) => SeedImportPage(),
            '/navigationMenu': (context) => NavMenu(),
            '/termCondition': (context) => TermConditionPage(),
            '/aboutUs': (context) => AboutUsPage(),
            '/qrscan': (context) => ScanScreen(),
            '/send': (context) => SendPage()
          },
        );
      }),
    );
  }
}
