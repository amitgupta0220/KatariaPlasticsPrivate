import 'package:KPPL/TransporterHomePage/TransporterHomeViews/DesktopTransporterHomeView.dart';
import 'package:KPPL/TransporterHomePage/TransporterHomeViews/MobileTransporterHomeView.dart';
import 'package:KPPL/TransporterHomePage/TransporterHomeViews/TabletTransporterHomeView.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TransporterNavPage extends StatefulWidget {
  @override
  _TransporterNavPageState createState() => _TransporterNavPageState();
}

class _TransporterNavPageState extends State<TransporterNavPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      breakpoints: ScreenBreakpoints(tablet: 600, desktop: 1100, watch: 300),
      desktop: DesktopTransporterHomeView(),
      tablet: TabletTransporterHomeView(),
      mobile: MobileTransporterHomeView(),
    );
  }
}
