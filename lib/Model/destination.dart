import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({this.iconData, this.text});
  IconData iconData;
  String text;
}

List<FABBottomAppBarItem> bottomNavList = [
  FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
  FABBottomAppBarItem(iconData: Icons.group, text: 'Contact'),
  FABBottomAppBarItem(iconData: Icons.history, text: 'History'),
  FABBottomAppBarItem(iconData: Icons.qr_code, text: 'Profile'),
];

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

List<DrawerItem> drawerList = [
  DrawerItem("Home", Icons.home),
  DrawerItem("Term of Use", Icons.collections_bookmark),
  DrawerItem("About Us", Icons.group),
  DrawerItem("Logout", Icons.settings_power)
];
