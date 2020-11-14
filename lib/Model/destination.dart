import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallet_app_ef1/localizations.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({this.iconData, this.text});
  IconData iconData;
  String text;
}

List<FABBottomAppBarItem> bottomNavList = [
  FABBottomAppBarItem(
      iconData: Icons.home,
      text: AppLocalizations.instance.translate('homeTitle')),
  FABBottomAppBarItem(
      iconData: Icons.group,
      text: AppLocalizations.instance.translate('contactTitle')),
  FABBottomAppBarItem(
      iconData: Icons.history,
      text: AppLocalizations.instance.translate('historyTitle')),
  FABBottomAppBarItem(
      iconData: Icons.qr_code,
      text: AppLocalizations.instance.translate('profileTitle')),
];

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

List<DrawerItem> drawerList = [
  DrawerItem(AppLocalizations.instance.translate('homeTitle'), Icons.home),
  DrawerItem(AppLocalizations.instance.translate('termText'),
      Icons.collections_bookmark),
  DrawerItem(AppLocalizations.instance.translate('aboutUs'), Icons.group),
  DrawerItem(
      AppLocalizations.instance.translate('logoutButton'), Icons.settings_power)
];
