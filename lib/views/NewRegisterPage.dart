import 'package:KPPL/views/RegisterViews/DesktopRegisterView.dart';
import 'package:KPPL/views/RegisterViews/MobileRegisterView.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RegisterPageTab extends StatefulWidget {
  @override
  _RegisterPageTabState createState() => _RegisterPageTabState();
}

class _RegisterPageTabState extends State<RegisterPageTab> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: DesktopRegisterPageTab(),
      tablet: MobileRegisterPageTab(),
      mobile: MobileRegisterPageTab(),
    );
  }
}
