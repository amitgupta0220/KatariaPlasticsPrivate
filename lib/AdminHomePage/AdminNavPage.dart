import 'dart:ui';
import 'package:KPPL/AdminConsignmentTab/AdminCompletedConsignment.dart';
import 'package:KPPL/AdminConsignmentTab/AdminCreateConsignment.dart';
import 'package:KPPL/AdminConsignmentTab/AdminDeliveredConsignment.dart';
import 'package:KPPL/AdminConsignmentTab/AdminOpenConsignment.dart';
import 'package:KPPL/AdminHomePage/AdminCreateUser.dart';
import 'package:KPPL/AdminMarketingTab/AdminMarketingUsers.dart';
import 'package:KPPL/AdminTransporterTab/AdminApprovedTransporter.dart';
import 'package:KPPL/AdminTransporterTab/AdminPendingTransporter.dart';
import 'package:KPPL/TransporterHomePage/Cards/DashboardAdmin.dart';
import 'package:KPPL/authentication/authenticate.dart';
import 'package:KPPL/styles.dart';
import 'package:KPPL/views/NewLogin.dart';
import 'package:flutter/material.dart';

class AdminNavPage extends StatefulWidget {
  @override
  _AdminNavPageState createState() => _AdminNavPageState();
}

class _AdminNavPageState extends State<AdminNavPage> {
  int selectedTab = 0, subCategory = 0;
  String id;
  bool clickedConsignment = false,
      clickedTransporter = false,
      clickedMarketing = false;
  bool isHoveredOnTransporter = false,
      isHoveredOnConsignmentTab = false,
      isHoveredOnMarketingTab = false;
  var dashboardCardDisplay,
      adminOpenConsignmentCard,
      adminCompletedConsignmentCard,
      adminDeliveredConsignmentCard,
      adminCreateConsignmentCard,
      adminPendingTransporter,
      adminApprovedTransporter,
      adminMarketingUsers;

  @override
  void initState() {
    super.initState();
    adminOpenConsignmentCard = AdminOpenConsignment();
    dashboardCardDisplay = DashboardAdmin();
    adminCompletedConsignmentCard = AdminCompletedConsignment();
    adminDeliveredConsignmentCard = AdminDeliveredConsignment();
    adminCreateConsignmentCard = AdminCreateConsignment();
    adminPendingTransporter = AdminPendingTransporter();
    adminApprovedTransporter = AdminApprovedTransporter();
    adminMarketingUsers = AdminMarketingUsers();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          isHoveredOnConsignmentTab = false;
          isHoveredOnTransporter = false;
          isHoveredOnMarketingTab = false;
          clickedTransporter = false;
          clickedConsignment = false;
          clickedMarketing = false;
        });
      },
      child: Scaffold(
        backgroundColor: MyColors.backgroundNewPage,
        appBar: AppBar(
          shadowColor: MyColors.secondaryNew,
          elevation: 15,
          leadingWidth: size.height * 0.15,
          toolbarHeight: size.height * 0.1,
          backgroundColor: Colors.white,
          leading: Container(
            child: Image.asset(
              "assets/logo.png",
            ),
          ),
          actions: [
            headerWidget(size),
          ],
        ),
        body: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                Container(
                  height: size.height - size.height * 0.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // mainCardDisplay,
                          selectedTab == 0
                              ? Expanded(
                                  child: Container(
                                  height: size.height -
                                      size.height * 0.04 -
                                      size.height * 0.1,
                                  width: size.width - size.width * 0.3 - 120,
                                  margin: EdgeInsets.only(
                                    top: size.height * 0.04,
                                    right: 27,
                                    left: size.height * 0.035 + 147,
                                  ),
                                  child: dashboardCardDisplay,
                                ))
                              : selectedTab == 1
                                  ? subCategory == 0
                                      ? Expanded(
                                          child: Container(
                                          height: size.height -
                                              size.height * 0.04 -
                                              size.height * 0.1,
                                          width: size.width -
                                              size.width * 0.3 -
                                              120,
                                          margin: EdgeInsets.only(
                                            top: size.height * 0.04,
                                            right: 27,
                                            left: size.height * 0.035 + 147,
                                          ),
                                          child: adminPendingTransporter,
                                        ))
                                      : Expanded(
                                          child: Container(
                                          height: size.height -
                                              size.height * 0.04 -
                                              size.height * 0.1,
                                          width: size.width -
                                              size.width * 0.3 -
                                              120,
                                          margin: EdgeInsets.only(
                                            top: size.height * 0.04,
                                            right: 27,
                                            left: size.height * 0.035 + 147,
                                          ),
                                          child: adminApprovedTransporter,
                                        ))
                                  : selectedTab == 2
                                      ? subCategory == 0
                                          ? Expanded(
                                              child: Container(
                                              height: size.height -
                                                  size.height * 0.04 -
                                                  size.height * 0.1,
                                              width: size.width -
                                                  size.width * 0.3 -
                                                  120,
                                              margin: EdgeInsets.only(
                                                top: size.height * 0.04,
                                                right: 27,
                                                left: size.height * 0.035 + 147,
                                              ),
                                              child: adminOpenConsignmentCard,
                                            ))
                                          : subCategory == 1
                                              ? Expanded(
                                                  child: Container(
                                                  height: size.height -
                                                      size.height * 0.04 -
                                                      size.height * 0.1,
                                                  width: size.width -
                                                      size.width * 0.3 -
                                                      120,
                                                  margin: EdgeInsets.only(
                                                    top: size.height * 0.04,
                                                    right: 27,
                                                    left: size.height * 0.035 +
                                                        147,
                                                  ),
                                                  child:
                                                      adminCompletedConsignmentCard,
                                                ))
                                              : subCategory == 2
                                                  ? Expanded(
                                                      child: Container(
                                                      height: size.height -
                                                          size.height * 0.04 -
                                                          size.height * 0.1,
                                                      width: size.width -
                                                          size.width * 0.3 -
                                                          120,
                                                      margin: EdgeInsets.only(
                                                        top: size.height * 0.04,
                                                        right: 27,
                                                        left: size.height *
                                                                0.035 +
                                                            147,
                                                      ),
                                                      child:
                                                          adminDeliveredConsignmentCard,
                                                    ))
                                                  : Expanded(
                                                      child: Container(
                                                      height: size.height -
                                                          size.height * 0.04 -
                                                          size.height * 0.1,
                                                      width: size.width -
                                                          size.width * 0.3 -
                                                          120,
                                                      margin: EdgeInsets.only(
                                                        top: size.height * 0.04,
                                                        right: 27,
                                                        left: size.height *
                                                                0.035 +
                                                            147,
                                                      ),
                                                      child:
                                                          adminCreateConsignmentCard,
                                                    ))
                                      : selectedTab == 3
                                          ? subCategory == 0
                                              ? Expanded(
                                                  child: Container(
                                                  height: size.height -
                                                      size.height * 0.04 -
                                                      size.height * 0.1,
                                                  width: size.width -
                                                      size.width * 0.3 -
                                                      120,
                                                  margin: EdgeInsets.only(
                                                    top: size.height * 0.04,
                                                    right: 27,
                                                    left: size.height * 0.035 +
                                                        147,
                                                  ),
                                                  child: adminMarketingUsers,
                                                ))
                                              : Expanded(child: Container())
                                          : selectedTab == 4
                                              ? Expanded(
                                                  child: Container(
                                                    height: size.height -
                                                        size.height * 0.04 -
                                                        size.height * 0.1,
                                                    width: size.width -
                                                        size.width * 0.3 -
                                                        120,
                                                    margin: EdgeInsets.only(
                                                      top: size.height * 0.04,
                                                      right: 27,
                                                      left:
                                                          size.height * 0.035 +
                                                              147,
                                                    ),
                                                    child: AdminCreateUser(),
                                                  ),
                                                )
                                              : Expanded(child: Container()),
                          notificationContainer(size),
                        ],
                      ),
                      // footerWidget(size),
                    ],
                  ),
                ),
              ],
            ),
            sideTabBar(size),
            isHoveredOnTransporter ? showTransporterSideTab(size) : Container(),
            isHoveredOnConsignmentTab
                ? showConsignmentSideTab(size)
                : Container(),
            isHoveredOnMarketingTab ? showMarketingSideTab(size) : Container(),
            logoutWidget(size),
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
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       "788 XXX",
          //       style: TextStyle(
          //           color: MyColors.primaryNew,
          //           fontSize: 20,
          //           fontWeight: FontWeight.w700),
          //     ),
          //     Text(
          //       "not 788 XXX?",
          //       style: TextStyle(
          //           color: MyColors.secondary,
          //           fontSize: 14,
          //           fontWeight: FontWeight.w400),
          //     ),
          //   ],
          // ),
          SizedBox(
            width: size.width * 0.012,
          ),
          CircleAvatar(
            backgroundColor: MyColors.secondaryNew,
            child: Icon(Icons.person),
          )
        ],
      ),
    );
  }

  logoutWidget(Size size) {
    return Positioned(
      top: size.height * 0.04 + 505,
      left: size.height * 0.035,
      child: GestureDetector(
        onTap: () {
          AuthService().signOut();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => LoginPageTab()));
        },
        child: Container(
          width: 120,
          height: size.height * 0.05,
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
              color: Colors.red,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              )),
          child: Center(
            child: Text(
              "Log out",
              style: TextStyle(
                  // letterSpacing: 1.3,
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  sideTabBar(Size size) {
    return Positioned(
        top: size.height * 0.04,
        left: size.height * 0.035,
        child: Container(
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
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          height: 500,
          width: 120,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    selectedTab = 0;
                    clickedTransporter = false;
                    clickedConsignment = false;
                    isHoveredOnTransporter = false;
                    isHoveredOnConsignmentTab = false;
                    isHoveredOnMarketingTab = false;
                    clickedMarketing = false;
                  });
                },
                child: Container(
                  height: 100,
                  width: 120,
                  decoration: BoxDecoration(
                      color: selectedTab == 0
                          ? Color.fromRGBO(230, 230, 230, 0.5)
                          : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/transporterHome.png",
                            height: 25,
                            width: 25,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Home",
                              style: TextStyle(
                                color: MyColors.secondary,
                                fontSize: 12,
                              )),
                        ],
                      ),
                      selectedTab == 0
                          ? Container(
                              alignment: Alignment.bottomCenter,
                              child: Divider(
                                height: 1,
                                color: MyColors.red,
                                thickness: 2,
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              alignment: Alignment.bottomCenter,
                              child: Divider(
                                height: 1,
                                color: MyColors.secondaryNew,
                                thickness: 1,
                              ),
                            )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isHoveredOnConsignmentTab = false;
                    isHoveredOnMarketingTab = false;
                    clickedMarketing = false;
                    clickedConsignment = false;
                    isHoveredOnTransporter = !isHoveredOnTransporter;
                    clickedTransporter = !clickedTransporter;
                  });
                },
                onHover: (value) {
                  // if (value) {
                  //   setState(() {
                  //     isHoveredOnTransporter = true;
                  //   });
                  // }
                },
                child: Container(
                  height: 100,
                  width: 120,
                  decoration: BoxDecoration(
                    color: selectedTab == 1 || clickedTransporter
                        ? Color.fromRGBO(230, 230, 230, 0.5)
                        : Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/transporterTruck.png",
                            height: 30,
                            width: 30,
                            color: Color(0xff999999),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Transporter",
                              style: TextStyle(
                                color: MyColors.secondary,
                                fontSize: 12,
                              )),
                        ],
                      ),
                      selectedTab == 1
                          ? Container(
                              alignment: Alignment.bottomCenter,
                              child: Divider(
                                height: 1,
                                color: MyColors.red,
                                thickness: 2,
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              alignment: Alignment.bottomCenter,
                              child: Divider(
                                height: 1,
                                color: MyColors.secondaryNew,
                                thickness: 1,
                              ),
                            )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isHoveredOnTransporter = false;
                    clickedTransporter = false;
                    isHoveredOnMarketingTab = false;
                    clickedMarketing = false;
                    isHoveredOnConsignmentTab = !isHoveredOnConsignmentTab;
                    clickedConsignment = !clickedConsignment;
                  });
                },
                child: Container(
                  height: 100,
                  width: 120,
                  decoration: BoxDecoration(
                    color: selectedTab == 2 || clickedConsignment
                        ? Color.fromRGBO(230, 230, 230, 0.5)
                        : Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.pending_actions_outlined,
                            size: 30,
                            color: Color(0xff999999),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Consignment",
                              style: TextStyle(
                                color: MyColors.secondary,
                                fontSize: 12,
                              ))
                        ],
                      ),
                      selectedTab == 2
                          ? Container(
                              alignment: Alignment.bottomCenter,
                              child: Divider(
                                height: 1,
                                color: MyColors.red,
                                thickness: 2,
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              alignment: Alignment.bottomCenter,
                              child: Divider(
                                height: 1,
                                color: MyColors.secondaryNew,
                                thickness: 1,
                              ),
                            )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    // selectedTab = 3;
                    clickedTransporter = false;
                    clickedConsignment = false;
                    isHoveredOnTransporter = false;
                    isHoveredOnConsignmentTab = false;
                    isHoveredOnMarketingTab = !isHoveredOnMarketingTab;
                    clickedMarketing = !clickedMarketing;
                  });
                },
                child: Container(
                  height: 100,
                  width: 120,
                  decoration: BoxDecoration(
                    color: selectedTab == 3 || clickedMarketing
                        ? Color.fromRGBO(230, 230, 230, 0.5)
                        : Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_outline_outlined,
                            size: 30,
                            color: Color(0xff999999),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Marketing",
                              style: TextStyle(
                                color: MyColors.secondary,
                                fontSize: 12,
                              ))
                        ],
                      ),
                      selectedTab == 3
                          ? Container(
                              alignment: Alignment.bottomCenter,
                              child: Divider(
                                height: 1,
                                color: MyColors.red,
                                thickness: 2,
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              alignment: Alignment.bottomCenter,
                              child: Divider(
                                height: 1,
                                color: MyColors.secondaryNew,
                                thickness: 1,
                              ),
                            )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selectedTab = 4;
                    clickedTransporter = false;
                    clickedConsignment = false;
                    isHoveredOnTransporter = false;
                    isHoveredOnConsignmentTab = false;
                    isHoveredOnMarketingTab = false;
                    clickedMarketing = false;
                  });
                },
                child: Container(
                  height: 100,
                  width: 120,
                  decoration: BoxDecoration(
                    color: selectedTab == 4
                        ? Color.fromRGBO(230, 230, 230, 0.5)
                        : Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_add_alt_1_outlined,
                            size: 30,
                            color: Color(0xff999999),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Create User",
                              style: TextStyle(
                                color: MyColors.secondary,
                                fontSize: 12,
                              ))
                        ],
                      ),
                      selectedTab == 4
                          ? Container(
                              alignment: Alignment.bottomCenter,
                              child: Divider(
                                height: 1,
                                color: MyColors.red,
                                thickness: 2,
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  showConsignmentSideTab(Size size) {
    return Positioned(
      top: size.height * 0.04 + 200,
      left: size.height * 0.035 + 120,
      child: Container(
        // height: 350 / 3,
        width: 240,
        padding: EdgeInsets.only(
          // bottom: 16,
          left: 16,
          right: 32,
          top: 8,
          bottom: 8,
        ),
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
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(7),
            bottomRight: Radius.circular(7),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Consignment",
                style: TextStyle(
                    color: MyColors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w900)),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: MyColors.red,
              thickness: 2,
              height: 1,
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isHoveredOnConsignmentTab = false;
                  selectedTab = 2;
                  subCategory = 0;
                });
              },
              child: Text("Open",
                  style: TextStyle(
                      color: Color(0xff4d4d4d),
                      fontSize: 12,
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
                setState(() {
                  isHoveredOnConsignmentTab = false;
                  selectedTab = 2;
                  subCategory = 1;
                });
              },
              child: Text("Completed",
                  style: TextStyle(
                      color: Color(0xff4d4d4d),
                      fontSize: 12,
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
                setState(() {
                  isHoveredOnConsignmentTab = false;
                  selectedTab = 2;
                  subCategory = 2;
                });
              },
              child: Text("Delivered",
                  style: TextStyle(
                      color: Color(0xff4d4d4d),
                      fontSize: 12,
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
                setState(() {
                  isHoveredOnConsignmentTab = false;
                  selectedTab = 2;
                  subCategory = 3;
                });
              },
              child: Text("Create",
                  style: TextStyle(
                      color: Color(0xff4d4d4d),
                      fontSize: 12,
                      fontWeight: FontWeight.w200)),
            ),
            // Divider(
            //   color: Color(0xfff2f2f2),
            //   thickness: 2,
            //   height: 1,
            // ),
            // SizedBox(
            //   height: size.width * 0.005,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       isHoveredOnConsignmentTab = false;
            //       selectedTab = 2;
            //     });
            //   },
            //   child: Text("Bid History",
            //       style: TextStyle(
            //           color: Color(0xff4d4d4d),
            //           fontSize: 14,
            //           fontWeight: FontWeight.w200)),
            // ),
          ],
        ),
      ),
    );
  }

  showTransporterSideTab(Size size) {
    return Positioned(
      top: size.height * 0.04 + 100,
      left: size.height * 0.035 + 120,
      child: Container(
        height: 100,
        width: 240,
        padding: EdgeInsets.only(
          // bottom: 16,
          left: 16,
          right: 32,
          top: 8,
        ),
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
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(7),
            bottomRight: Radius.circular(7),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Transporter",
                style: TextStyle(
                    color: MyColors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w900)),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: MyColors.red,
              thickness: 2,
              height: 1,
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isHoveredOnTransporter = false;
                  selectedTab = 1;
                  subCategory = 0;
                });
              },
              child: Text("Pending",
                  style: TextStyle(
                      color: Color(0xff4d4d4d),
                      fontSize: 12,
                      fontWeight: FontWeight.w200)),
            ),
            SizedBox(
              height: 6,
            ),
            Divider(
              color: Color(0xfff2f2f2),
              thickness: 2,
              height: 1,
            ),
            SizedBox(
              height: 6,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isHoveredOnTransporter = false;
                  selectedTab = 1;
                  subCategory = 1;
                });
              },
              child: Text("Approved",
                  style: TextStyle(
                      color: Color(0xff4d4d4d),
                      fontSize: 12,
                      fontWeight: FontWeight.w200)),
            ),
            SizedBox(
              height: 6,
            ),
            // Divider(
            //   color: Color(0xfff2f2f2),
            //   thickness: 2,
            //   height: 1,
            // ),
            // SizedBox(
            //   height: 6,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       isHoveredOnTransporter = false;
            //       selectedTab = 1;
            //       subCategory = 2;
            //     });
            //   },
            //   child: Text("All",
            //       style: TextStyle(
            //           color: Color(0xff4d4d4d),
            //           fontSize: 12,
            //           fontWeight: FontWeight.w200)),
            // ),
          ],
        ),
      ),
    );
  }

  showMarketingSideTab(Size size) {
    return Positioned(
      top: size.height * 0.04 + 300,
      left: size.height * 0.035 + 120,
      child: Container(
        height: 120,
        width: 240,
        padding: EdgeInsets.only(
          // bottom: 16,
          left: 16,
          right: 32,
          top: 8,
        ),
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
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(7),
            bottomRight: Radius.circular(7),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Marketer",
                style: TextStyle(
                    color: MyColors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w900)),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: MyColors.red,
              thickness: 2,
              height: 1,
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isHoveredOnMarketingTab = false;
                  selectedTab = 3;
                  subCategory = 0;
                });
              },
              child: Text("Users",
                  style: TextStyle(
                      color: Color(0xff4d4d4d),
                      fontSize: 12,
                      fontWeight: FontWeight.w200)),
            ),
            SizedBox(
              height: 6,
            ),
            Divider(
              color: Color(0xfff2f2f2),
              thickness: 2,
              height: 1,
            ),
            SizedBox(
              height: 6,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isHoveredOnMarketingTab = false;
                  selectedTab = 3;
                  subCategory = 1;
                });
              },
              child: Text("Pending",
                  style: TextStyle(
                      color: Color(0xff4d4d4d),
                      fontSize: 12,
                      fontWeight: FontWeight.w200)),
            ),
            SizedBox(
              height: 6,
            ),
            Divider(
              color: Color(0xfff2f2f2),
              thickness: 2,
              height: 1,
            ),
            SizedBox(
              height: 6,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isHoveredOnMarketingTab = false;
                  selectedTab = 3;
                  subCategory = 2;
                });
              },
              child: Text("Approved",
                  style: TextStyle(
                      color: Color(0xff4d4d4d),
                      fontSize: 12,
                      fontWeight: FontWeight.w200)),
            ),
          ],
        ),
      ),
    );
  }

  notificationContainer(Size size) {
    return Container(
      padding: EdgeInsets.all(size.width * 0.015),
      margin:
          EdgeInsets.only(top: size.height * 0.04, right: size.height * 0.035),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.08),
          blurRadius: 8,
          // spreadRadius: 0.01,
          offset: Offset(
            4,
            4,
          ),
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(7)),
      height: size.height * 0.8,
      width: size.width * 0.23,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "Notifications",
                style: TextStyle(
                    color: MyColors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              Divider(
                thickness: 2,
                color: MyColors.red,
              ),
            ],
          ),
          Text(
            "You have no new\nnotifications",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: MyColors.secondary,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          Container(
            decoration: BoxDecoration(
                color: MyColors.primaryNew,
                borderRadius: BorderRadius.circular(8)),
            width: size.width * 0.1,
            height: size.height * 0.05,
            child: Center(
              child: Text("Need Help?",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ),
          )
        ],
      ),
    );
  }
}
