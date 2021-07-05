import 'package:KPPL/views/LoginViews/DesktopLoginView.dart';
import 'package:KPPL/views/LoginViews/MobileLoginView.dart';
import 'package:KPPL/views/LoginViews/TabletLoginView.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginPageTab extends StatefulWidget {
  @override
  _LoginPageTabState createState() => _LoginPageTabState();
}

class _LoginPageTabState extends State<LoginPageTab> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: DesktopLoginView(),
      tablet: TabletLoginView(),
      mobile: MobileLoginView(),
    );
  }
}
