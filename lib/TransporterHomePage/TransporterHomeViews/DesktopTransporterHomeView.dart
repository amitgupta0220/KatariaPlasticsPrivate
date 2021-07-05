import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:KPPL/TransporterHomePage/Cards/MainCardDisplay.dart';
import 'package:KPPL/TransporterHomePage/OngoingCards/DesktopTransporterCompleted.dart';
import 'package:KPPL/authentication/authenticate.dart';
import 'package:KPPL/styles.dart';
import 'package:KPPL/views/NewLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:KPPL/TransporterHomePage/OngoingCards/DesktopTransporterDelivered.dart';
import 'package:http/http.dart' as http;

class DesktopTransporterHomeView extends StatefulWidget {
  @override
  _DesktopTransporterHomeViewState createState() =>
      _DesktopTransporterHomeViewState();
}

class _DesktopTransporterHomeViewState
    extends State<DesktopTransporterHomeView> {
  int selectedTab = 0, subCategory = 0;
  String id, username;
  bool clickedProfile = false, clickedBid = false;
  bool isHoveredOnHomeTab = false, isHoveredOnProfileTab = false;
  var mainCardDisplay, onGoingCard, completedCard, deliveredCard;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.email)
        .get()
        .then((value) {
      if (mounted)
        setState(() {
          id = value.data()["userID"];
          username = value.data()["username"];
          onGoingCard = TransporterDisplayOngoingBids(
            id: id,
            username: username,
            title: "Bid History",
          );
        });
    });
    if (mounted) {
      mainCardDisplay = MainCardDisplay();
      completedCard = DesktopTransporterCompleted();
      deliveredCard = DesktopTransporterDelivered();
    }
  }

  onTabChanged(int index) {
    setState(() {
      subCategory = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          isHoveredOnProfileTab = false;
          isHoveredOnHomeTab = false;
          clickedBid = false;
          clickedProfile = false;
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
                  height: size.height + size.width * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          selectedTab == 0
                              ? mainCardDisplay
                              : selectedTab == 1
                                  ? subCategory == 0
                                      ? onGoingCard
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
                                                left: size.height * 0.035 + 147,
                                              ),
                                              color: Colors.transparent,
                                              child: completedCard,
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
                                              color: Colors.transparent,
                                              child: deliveredCard,
                                            ))
                                  : selectedTab == 2
                                      ? subCategory == 0
                                          ? TransporterPersonalDetails(
                                              title: "Personal Details",
                                              selectedTab: 0,
                                              onFieldUpdated: onTabChanged,
                                            )
                                          : TransporterPersonalDetails(
                                              title: "Company Details",
                                              selectedTab: 1,
                                              onFieldUpdated: onTabChanged,
                                            )
                                      : Expanded(child: Container()),
                          notificationContainer(size),
                        ],
                      ),
                      footerWidget(size),
                    ],
                  ),
                ),
              ],
            ),
            sideTabBar(size),
            isHoveredOnHomeTab ? showHomeSideTab(size) : Container(),
            isHoveredOnProfileTab ? showProfileSideTab(size) : Container(),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                id == null ? "" : id,
                style: TextStyle(
                    color: MyColors.primaryNew,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "User ID",
                style: TextStyle(
                    color: MyColors.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
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
      top: size.height * 0.04 + 355,
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
          height: 350,
          width: 120,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    selectedTab = 0;
                    clickedBid = false;
                    clickedProfile = false;
                    isHoveredOnHomeTab = false;
                    isHoveredOnProfileTab = false;
                  });
                },
                child: Container(
                  height: 117,
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
                            height: 30,
                            width: 30,
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
                    isHoveredOnProfileTab = false;
                    clickedProfile = false;
                    isHoveredOnHomeTab = !isHoveredOnHomeTab;
                    clickedBid = !clickedBid;
                  });
                },
                onHover: (value) {
                  // if (value) {
                  //   setState(() {
                  //     isHoveredOnHomeTab = true;
                  //   });
                  // }
                },
                child: Container(
                  height: 117,
                  width: 120,
                  decoration: BoxDecoration(
                    color: selectedTab == 1 || clickedBid
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
                            "assets/transporterBid.png",
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("My Bids",
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
                    isHoveredOnHomeTab = false;
                    clickedBid = false;
                    isHoveredOnProfileTab = !isHoveredOnProfileTab;
                    clickedProfile = !clickedProfile;
                  });
                },
                child: Container(
                  height: 116,
                  width: 120,
                  decoration: BoxDecoration(
                    color: selectedTab == 2 || clickedProfile
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
                            "assets/transporterProfile.png",
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Profile",
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
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  showProfileSideTab(Size size) {
    return Positioned(
      top: size.height * 0.04 + (350 - (350 / 3)),
      left: size.height * 0.035 + 120,
      child: Container(
        height: 350 / 3,
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
            Text("Profile",
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
                  isHoveredOnProfileTab = false;
                  selectedTab = 2;
                  subCategory = 0;
                });
              },
              child: Text("Personal Details",
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
                  isHoveredOnProfileTab = false;
                  selectedTab = 2;
                  subCategory = 1;
                });
              },
              child: Text("Company Details",
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
            //       isHoveredOnProfileTab = false;
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

  showHomeSideTab(Size size) {
    return Positioned(
      top: size.height * 0.04 + (350 / 3),
      left: size.height * 0.035 + 120,
      child: Container(
        height: 350 / 3,
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
            Text("My Bids",
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
                  isHoveredOnHomeTab = false;
                  selectedTab = 1;
                  subCategory = 0;
                });
              },
              child: Text("Bid History",
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
                  isHoveredOnHomeTab = false;
                  selectedTab = 1;
                  subCategory = 1;
                });
              },
              child: Text("Confirmed Bid",
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
                  isHoveredOnHomeTab = false;
                  selectedTab = 1;
                  subCategory = 2;
                });
              },
              child: Text("Delivered Consignment",
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

  footerWidget(Size size) {
    return Container(
      padding: EdgeInsets.all(size.width * 0.03),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: size.width * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Kataria Plastics",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: MyColors.primaryNew,
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
              Text(
                  "34-44, Industrial Area Ratlam,\nIndustrial Area, Ratlam,\nMadhya Pradesh 457001",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: MyColors.secondary,
                      fontWeight: FontWeight.w400,
                      fontSize: 14)),
            ],
          ),
          Container(
            width: size.width * 0.45,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "About Us",
                  style: TextStyle(
                    color: MyColors.secondary,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Privacy Policy",
                  style: TextStyle(
                    color: MyColors.secondary,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Terms and Conditions",
                  style: TextStyle(
                    color: MyColors.secondary,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Help",
                  style: TextStyle(
                    color: MyColors.secondary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        ],
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
          Column(
            children: [
              Text(
                "You have no new\nnotifications",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MyColors.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                "Bid Now?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MyColors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
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
