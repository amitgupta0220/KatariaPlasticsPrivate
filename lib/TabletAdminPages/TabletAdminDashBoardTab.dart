import 'package:KPPL/styles.dart';
import 'package:flutter/material.dart';

class TabletAdminDashboard extends StatefulWidget {
  @override
  _TabletAdminDashboardState createState() => _TabletAdminDashboardState();
}

class _TabletAdminDashboardState extends State<TabletAdminDashboard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(children: [
      Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              blurRadius: 8,
              // spreadRadius: 0.01,
              offset: Offset(
                4,
                4,
              ),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 20,
              height: size.height * 0.1,
              decoration: BoxDecoration(
                  color: MyColors.primaryNew,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7),
                    bottomLeft: Radius.circular(7),
                  )),
            ),
            Expanded(
              child: Container(
                // width: size.width - size.width * 0.3 - 140,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(7),
                      bottomRight: Radius.circular(7),
                    )),
                height: size.height * 0.1,
                child: Container(
                  margin: EdgeInsets.only(left: size.height * 0.05),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Dashboard",
                    style: TextStyle(
                        color: MyColors.primaryNew,
                        fontSize: 26,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]));
  }
}
