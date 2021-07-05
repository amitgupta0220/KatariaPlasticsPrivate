import 'package:KPPL/AdminHomePage/AdminNavPage.dart';
import 'package:KPPL/MobileAdminPages/MobileAdminNavPage.dart';
import 'package:KPPL/TabletAdminPages/TabletAdminNavPage.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdminNavigation extends StatefulWidget {
  @override
  _AdminNavigationState createState() => _AdminNavigationState();
}

class _AdminNavigationState extends State<AdminNavigation> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      breakpoints: ScreenBreakpoints(tablet: 600, desktop: 1100, watch: 300),
      desktop: AdminNavPage(),
      tablet: TabletAdminNavigation(),
      mobile: MobileAdminNavigation(),
    );
  }
}
