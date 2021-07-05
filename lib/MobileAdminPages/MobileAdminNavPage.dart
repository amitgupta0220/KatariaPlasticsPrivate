import 'dart:ui';
import 'package:KPPL/MobileAdminPages/MobileAdminCreateUser.dart';
import 'package:KPPL/MobileAdminPages/MobileAdminDashboard.dart';
import 'package:KPPL/MobileAdminPages/MobileConsignmentTab/MobileAdminConfirmedConsignment.dart';
import 'package:KPPL/MobileAdminPages/MobileConsignmentTab/MobileAdminCreateConsignment.dart';
import 'package:KPPL/MobileAdminPages/MobileConsignmentTab/MobileAdminDeliveredConsignment.dart';
import 'package:KPPL/MobileAdminPages/MobileConsignmentTab/MobileOpenConsignment.dart';
import 'package:KPPL/MobileAdminPages/MobileMarketerTab.dart/MobileAdminMarketingUser.dart';
import 'package:KPPL/MobileAdminPages/MobileTransporterTab/MobileAdminApprovedTransporter.dart';
import 'package:KPPL/MobileAdminPages/MobileTransporterTab/MobileAminPendingTransporter.dart';
import 'package:KPPL/authentication/authenticate.dart';
import 'package:KPPL/styles.dart';
import 'package:KPPL/views/NewLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MobileAdminNavigation extends StatefulWidget {
  @override
  _MobileAdminNavigationState createState() => _MobileAdminNavigationState();
}

class _MobileAdminNavigationState extends State<MobileAdminNavigation> {
  int selectedTab = 0;
  int subCategory = 0;
  String id;
  var _dashboardCardDisplayMobile,
      _adminOpenConsignmentCardMobile,
      _adminCompletedConsignmentCardMobile,
      _adminDeliveredConsignmentCardMobile,
      _adminCreateConsignmentCardMobile,
      _adminPendingTransporterMobile,
      _adminApprovedTransporterMobile,
      _adminMarketingUsersMobile,
      _adminCreateUserMobile;
  // bool isHoveredOnHomeTab = false, isHoveredOnProfileTab = false;
  @override
  void dispose() {
    super.dispose();
  }

  onTabChanged(List index) {
    setState(() {
      selectedTab = index[0];
      subCategory = index[1];
    });
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.email)
        .get()
        .then((value) {
      setState(() {
        id = value.data()["userID"];
      });
    });
    _dashboardCardDisplayMobile = MobileAdminDashboard();
    _adminCreateUserMobile = MobileAdminCreateUser();
    _adminOpenConsignmentCardMobile = MobileAdminOpenConsignment();
    _adminCreateConsignmentCardMobile = MobileAdminCreateConsignment();
    _adminPendingTransporterMobile = MobileAdminPendingTransporter();
    _adminApprovedTransporterMobile = MobileAdminApprovedTransporter();
    _adminMarketingUsersMobile = MobileAdminMarketingUser();
    _adminCompletedConsignmentCardMobile = MobileAdminConfirmedConsignment();
    _adminDeliveredConsignmentCardMobile = MobileAdminDeliveredConsignment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        backgroundColor: MyColors.backgroundNewPage,
        appBar: AppBar(
          shadowColor: MyColors.secondaryNew,
          elevation: 15,
          iconTheme: IconThemeData(color: MyColors.primaryNew),
          toolbarHeight: size.height * 0.1,
          backgroundColor: Colors.white,
          actions: [
            headerWidget(size),
          ],
        ),
        drawer: SideDrawer(
          selectedTab: selectedTab,
          onFieldUpdated: onTabChanged,
        ),
        body: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                Container(
                  height: size.height - size.height * 0.1,
                  child: selectedTab == 0
                      ? Container(
                          height: size.height -
                              size.height * 0.04 -
                              size.height * 0.1,
                          width: size.width - size.width * 0.3,
                          margin: EdgeInsets.only(
                            top: size.height * 0.04,
                            right: 27,
                            left: size.height * 0.035,
                          ),
                          color: Colors.transparent,
                          child: SingleChildScrollView(
                              child: _dashboardCardDisplayMobile),
                        )
                      : selectedTab == 1
                          ? subCategory == 0
                              ? Container(
                                  height: size.height -
                                      size.height * 0.04 -
                                      size.height * 0.1,
                                  width: size.width - size.width * 0.3,
                                  margin: EdgeInsets.only(
                                    top: size.height * 0.04,
                                    right: 27,
                                    left: size.height * 0.035,
                                  ),
                                  color: Colors.transparent,
                                  child: MaterialApp(
                                    debugShowCheckedModeBanner: false,
                                    home: Scaffold(
                                      backgroundColor: Colors.transparent,
                                      body: SingleChildScrollView(
                                          child:
                                              _adminPendingTransporterMobile),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: size.height -
                                      size.height * 0.04 -
                                      size.height * 0.1,
                                  width: size.width - size.width * 0.3,
                                  margin: EdgeInsets.only(
                                    top: size.height * 0.04,
                                    right: 27,
                                    left: size.height * 0.035,
                                  ),
                                  color: Colors.transparent,
                                  child: MaterialApp(
                                    debugShowCheckedModeBanner: false,
                                    home: Scaffold(
                                      backgroundColor: Colors.transparent,
                                      body: SingleChildScrollView(
                                          child:
                                              _adminApprovedTransporterMobile),
                                    ),
                                  ),
                                )
                          : selectedTab == 2
                              ? subCategory == 0
                                  ? Container(
                                      height: size.height -
                                          size.height * 0.04 -
                                          size.height * 0.1,
                                      width: size.width - size.width * 0.3,
                                      margin: EdgeInsets.only(
                                        top: size.height * 0.04,
                                        right: 27,
                                        left: size.height * 0.035,
                                      ),
                                      color: Colors.transparent,
                                      child: MaterialApp(
                                        debugShowCheckedModeBanner: false,
                                        home: Scaffold(
                                          backgroundColor: Colors.transparent,
                                          body: SingleChildScrollView(
                                              child:
                                                  _adminOpenConsignmentCardMobile),
                                        ),
                                      ),
                                    )
                                  : subCategory == 1
                                      ? Container(
                                          height: size.height -
                                              size.height * 0.04 -
                                              size.height * 0.1,
                                          width: size.width - size.width * 0.3,
                                          margin: EdgeInsets.only(
                                            top: size.height * 0.04,
                                            right: 27,
                                            left: size.height * 0.035,
                                          ),
                                          color: Colors.transparent,
                                          child: MaterialApp(
                                            debugShowCheckedModeBanner: false,
                                            home: Scaffold(
                                              backgroundColor:
                                                  Colors.transparent,
                                              body: SingleChildScrollView(
                                                  child:
                                                      _adminCompletedConsignmentCardMobile),
                                            ),
                                          ),
                                        )
                                      : subCategory == 2
                                          ? Container(
                                              height: size.height -
                                                  size.height * 0.04 -
                                                  size.height * 0.1,
                                              width:
                                                  size.width - size.width * 0.3,
                                              margin: EdgeInsets.only(
                                                top: size.height * 0.04,
                                                right: 27,
                                                left: size.height * 0.035,
                                              ),
                                              color: Colors.transparent,
                                              child: MaterialApp(
                                                debugShowCheckedModeBanner:
                                                    false,
                                                home: Scaffold(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  body: SingleChildScrollView(
                                                      child:
                                                          _adminDeliveredConsignmentCardMobile),
                                                ),
                                              ),
                                            )
                                          : subCategory == 3
                                              ? Container(
                                                  height: size.height -
                                                      size.height * 0.04 -
                                                      size.height * 0.1,
                                                  width: size.width -
                                                      size.width * 0.3,
                                                  margin: EdgeInsets.only(
                                                    top: size.height * 0.04,
                                                    right: 27,
                                                    left: size.height * 0.035,
                                                  ),
                                                  color: Colors.transparent,
                                                  child:
                                                      _adminCreateConsignmentCardMobile)
                                              : Container()
                              : selectedTab == 3
                                  ? subCategory == 0
                                      ? Container(
                                          height: size.height -
                                              size.height * 0.04 -
                                              size.height * 0.1,
                                          width: size.width - size.width * 0.3,
                                          margin: EdgeInsets.only(
                                            top: size.height * 0.04,
                                            right: 27,
                                            left: size.height * 0.035,
                                          ),
                                          color: Colors.transparent,
                                          child: MaterialApp(
                                            debugShowCheckedModeBanner: false,
                                            home: Scaffold(
                                              backgroundColor:
                                                  Colors.transparent,
                                              body: SingleChildScrollView(
                                                child:
                                                    _adminMarketingUsersMobile,
                                              ),
                                            ),
                                          ))
                                      : Container()
                                  : selectedTab == 4
                                      ? Container(
                                          height: size.height -
                                              size.height * 0.04 -
                                              size.height * 0.1,
                                          width: size.width - size.width * 0.3,
                                          margin: EdgeInsets.only(
                                            top: size.height * 0.04,
                                            right: 27,
                                            left: size.height * 0.035,
                                          ),
                                          color: Colors.transparent,
                                          child: _adminCreateUserMobile)
                                      : Container(),
                ),
              ],
            ),
            // sideTabBar(size),
            // logoutWidget(size),
          ],
        ),
      ),
    );
  }

  headerWidget(size) {
    return Container(
      margin: EdgeInsets.only(right: size.width * 0.055),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: MyColors.secondaryNew,
            child: Icon(Icons.person),
          ),
          SizedBox(
            width: 15,
          ),
          // Icon(Icons.notifications, color: MyColors.primaryNew)
        ],
      ),
    );
  }
}

class SideDrawer extends StatefulWidget {
  final int selectedTab;
  final ValueChanged<List> onFieldUpdated;
  SideDrawer({this.selectedTab, @required this.onFieldUpdated});
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  bool isConsignmentTabShow = false,
      isTransporterTabShow = false,
      isMarketingTabShow = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        color: Color(0xffffffff),
        // margin: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // Important: Remove any padding from the ListView.
          children: <Widget>[
            // DrawerHeader(
            //   child: Text(''),
            //   decoration: BoxDecoration(
            //     color: MyColors.secondary,
            //   ),
            // ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        margin: const EdgeInsets.all(8.0),
                        alignment: Alignment.topLeft,
                        child: Icon(Icons.close))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                ListTile(
                  tileColor: widget.selectedTab == 0
                      ? Color(0xfff1f1f1)
                      : Colors.transparent,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/transporterHome.png",
                        height: 30,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        'Home',
                        style:
                            TextStyle(color: Color(0xff989898), fontSize: 18),
                      ),
                    ],
                  ),
                  onTap: () {
                    widget.onFieldUpdated([0, 0]);
                    isConsignmentTabShow = false;
                    isTransporterTabShow = false;
                    isMarketingTabShow = false;
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  tileColor: widget.selectedTab == 1
                      ? Color(0xfff1f1f1)
                      : Colors.transparent,
                  title: Container(
                    // margin: EdgeInsets.only(left: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/transporterTruck.png",
                            height: 30, color: Color(0xff999999)),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Transporter',
                          style:
                              TextStyle(color: Color(0xff989898), fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      isConsignmentTabShow = false;
                      isMarketingTabShow = false;
                      isTransporterTabShow = !isTransporterTabShow;
                    });
                  },
                ),
                isTransporterTabShow
                    ? Container(
                        margin: EdgeInsets.only(left: 64, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.onFieldUpdated([1, 0]);
                                Navigator.of(context).pop();
                              },
                              child: Text("Pending",
                                  style: TextStyle(
                                      color: Color(0xff4d4d4d),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Divider(
                              color: Color(0xfff2f2f2),
                              thickness: 2,
                              height: 1,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.onFieldUpdated([1, 1]);
                                Navigator.of(context).pop();
                              },
                              child: Text("Approved",
                                  style: TextStyle(
                                      color: Color(0xff4d4d4d),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                ListTile(
                  tileColor: widget.selectedTab == 2
                      ? Color(0xfff1f1f1)
                      : Colors.transparent,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.pending_actions_outlined,
                        size: 30,
                        color: Color(0xff999999),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        'Consignment',
                        style:
                            TextStyle(color: Color(0xff989898), fontSize: 18),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      isTransporterTabShow = false;
                      isMarketingTabShow = false;
                      isConsignmentTabShow = !isConsignmentTabShow;
                    });
                  },
                ),
                isConsignmentTabShow
                    ? Container(
                        margin: EdgeInsets.only(left: 64, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget.onFieldUpdated([2, 0]);
                                Navigator.of(context).pop();
                              },
                              child: Text("Open",
                                  style: TextStyle(
                                      color: Color(0xff4d4d4d),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Divider(
                              color: Color(0xfff2f2f2),
                              thickness: 2,
                              height: 1,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.onFieldUpdated([2, 1]);
                                Navigator.of(context).pop();
                              },
                              child: Text("Completed",
                                  style: TextStyle(
                                      color: Color(0xff4d4d4d),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Divider(
                              color: Color(0xfff2f2f2),
                              thickness: 2,
                              height: 1,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.onFieldUpdated([2, 2]);
                                Navigator.of(context).pop();
                              },
                              child: Text("Delivered",
                                  style: TextStyle(
                                      color: Color(0xff4d4d4d),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Divider(
                              color: Color(0xfff2f2f2),
                              thickness: 2,
                              height: 1,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.onFieldUpdated([2, 3]);
                                Navigator.of(context).pop();
                              },
                              child: Text("Create",
                                  style: TextStyle(
                                      color: Color(0xff4d4d4d),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                ListTile(
                  tileColor: widget.selectedTab == 3
                      ? Color(0xfff1f1f1)
                      : Colors.transparent,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outline_outlined,
                        size: 30,
                        color: Color(0xff999999),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        'Marketing',
                        style:
                            TextStyle(color: Color(0xff989898), fontSize: 18),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      isTransporterTabShow = false;
                      isConsignmentTabShow = false;
                      isMarketingTabShow = !isMarketingTabShow;
                    });
                  },
                ),
                isMarketingTabShow
                    ? Container(
                        margin: EdgeInsets.only(left: 64, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget.onFieldUpdated([3, 0]);
                                Navigator.of(context).pop();
                              },
                              child: Text("Users",
                                  style: TextStyle(
                                      color: Color(0xff4d4d4d),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Divider(
                              color: Color(0xfff2f2f2),
                              thickness: 2,
                              height: 1,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.onFieldUpdated([3, 1]);
                                Navigator.of(context).pop();
                              },
                              child: Text("Pending",
                                  style: TextStyle(
                                      color: Color(0xff4d4d4d),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Divider(
                              color: Color(0xfff2f2f2),
                              thickness: 2,
                              height: 1,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.onFieldUpdated([3, 2]);
                                Navigator.of(context).pop();
                              },
                              child: Text("Approved",
                                  style: TextStyle(
                                      color: Color(0xff4d4d4d),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                ListTile(
                  tileColor: widget.selectedTab == 4
                      ? Color(0xfff1f1f1)
                      : Colors.transparent,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_add_alt_1_outlined,
                        size: 30,
                        color: Color(0xff999999),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        'Create User',
                        style:
                            TextStyle(color: Color(0xff989898), fontSize: 18),
                      ),
                    ],
                  ),
                  onTap: () {
                    isConsignmentTabShow = false;
                    isTransporterTabShow = false;
                    isMarketingTabShow = false;
                    widget.onFieldUpdated([4, 0]);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            GestureDetector(
                onTap: () {
                  AuthService().signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => LoginPageTab()));
                },
                child: Container(
                  decoration: BoxDecoration(color: MyColors.red),
                  height: size.height * 0.075,
                  child: Center(
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
