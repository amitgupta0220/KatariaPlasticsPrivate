import 'dart:ui';
import 'package:KPPL/MobileAdminPages/MobileConsignmentTab/MobileConfirmedConsignment.dart';
import 'package:KPPL/MobileAdminPages/MobileConsignmentTab/MobileDeliveredConsignment.dart';
import 'package:KPPL/TransporterHomePage/Cards/Cards%20Mobile/TransporterCardOngoingMobile.dart';
import 'package:KPPL/TransporterHomePage/Cards/TransporterCardMobile.dart';
import 'package:KPPL/TransporterHomePage/MobileTransporterProfileTab/MobileTransporterPersonalDetail.dart';
import 'package:KPPL/TransporterHomePage/TabletTransporterPages/MobileTransporterDelivered.dart';
import 'package:KPPL/authentication/authenticate.dart';
import 'package:KPPL/styles.dart';
import 'package:KPPL/views/NewLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MobileTransporterHomeView extends StatefulWidget {
  @override
  _MobileTransporterHomeViewState createState() =>
      _MobileTransporterHomeViewState();
}

class _MobileTransporterHomeViewState extends State<MobileTransporterHomeView> {
  int selectedTab = 0;
  int subCategory = 0;
  String id, username;
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
        username = value.data()["username"];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   isHoveredOnProfileTab = false;
        //   isHoveredOnHomeTab = false;
        // });
      },
      child: Scaffold(
        backgroundColor: MyColors.backgroundNewPage,
        appBar: AppBar(
          shadowColor: MyColors.secondaryNew,
          elevation: 15, iconTheme: IconThemeData(color: MyColors.primaryNew),
          // leadingWidth: size.height * 0.15,
          toolbarHeight: size.height * 0.1,
          backgroundColor: Colors.white,
          // leading: Container(
          //   child: Image.asset(
          //     "assets/logo.png",
          //   ),
          // ),
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
                  height: size.height + size.width * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
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
                              child: selectedTab == 0
                                  ? SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              bottom: size.height * 0.01,
                                            ),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.08),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 13,
                                                  height: size.height * 0.08,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          MyColors.primaryNew,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(7),
                                                        bottomLeft:
                                                            Radius.circular(7),
                                                      )),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    // width: size.width - size.width * 0.3 - 140,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  7),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  7),
                                                        )),
                                                    height: size.height * 0.08,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: size.height *
                                                              0.05),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "Home",
                                                        style: TextStyle(
                                                            color: MyColors
                                                                .primaryNew,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('consignment')
                                                  .where("status",
                                                      isEqualTo: "open")
                                                  .orderBy(
                                                    'date',
                                                  )
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                List<Widget> bidWidget = [];
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                }
                                                if (snapshot.hasData) {
                                                  final userData =
                                                      snapshot.data.docs;
                                                  userData
                                                      .forEach((consignment) {
                                                    var pickUpLocation =
                                                        consignment.data()[
                                                            "pickUpLocation"];
                                                    var dropLocation =
                                                        consignment.data()[
                                                            "dropLocation"];
                                                    var consignmentCode =
                                                        consignment.id;
                                                    var description =
                                                        consignment.data()[
                                                            "description"];
                                                    var truckDetail =
                                                        consignment.data()[
                                                            "truckDetail"];
                                                    var load = consignment
                                                        .data()["load"];
                                                    var date = consignment
                                                        .data()["date"];
                                                    var numberOfTruck =
                                                        consignment.data()[
                                                            "numberOfTruck"];
                                                    var price = consignment
                                                        .data()["price"];
                                                    bidWidget.add(
                                                        TransporterCardMobile(
                                                      username: username,
                                                      id: id,
                                                      truckDetail: truckDetail,
                                                      price: price,
                                                      numberOfTruck:
                                                          numberOfTruck,
                                                      date: date,
                                                      load: load,
                                                      description: description,
                                                      consignmentCode:
                                                          consignmentCode,
                                                      pickUpLocation:
                                                          pickUpLocation,
                                                      dropLocation:
                                                          dropLocation,
                                                    ));
                                                  });
                                                  return ListView(
                                                    children: bidWidget,
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                  );
                                                }
                                                return Container();
                                              }),
                                        ],
                                      ),
                                    )
                                  : selectedTab == 1
                                      ? subCategory == 0
                                          ? SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      bottom:
                                                          size.height * 0.01,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.08),
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
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 13,
                                                          height: size.height *
                                                              0.08,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: MyColors
                                                                      .primaryNew,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            7),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            7),
                                                                  )),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            // width: size.width - size.width * 0.3 - 140,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              7),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              7),
                                                                    )),
                                                            height:
                                                                size.height *
                                                                    0.08,
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: size
                                                                              .height *
                                                                          0.05),
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                "Bid History",
                                                                style: TextStyle(
                                                                    color: MyColors
                                                                        .primaryNew,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  StreamBuilder<QuerySnapshot>(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection('users')
                                                          .doc(
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser
                                                                .email,
                                                          )
                                                          .collection("myBids")
                                                          .orderBy(
                                                            'date',
                                                          )
                                                          .snapshots(),
                                                      builder:
                                                          (context, snapshot) {
                                                        List<Widget> bidWidget =
                                                            [];
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        }
                                                        if (snapshot.hasData) {
                                                          final userData =
                                                              snapshot
                                                                  .data.docs;
                                                          userData.forEach(
                                                              (consignment) {
                                                            var pickUpLocation =
                                                                consignment
                                                                        .data()[
                                                                    "pickUpLocation"];
                                                            var dropLocation =
                                                                consignment
                                                                        .data()[
                                                                    "dropLocation"];
                                                            var consignmentCode =
                                                                consignment.id;
                                                            var description =
                                                                consignment
                                                                        .data()[
                                                                    "description"];
                                                            var truckDetail =
                                                                consignment
                                                                        .data()[
                                                                    "truckDetail"];
                                                            var load =
                                                                consignment
                                                                        .data()[
                                                                    "load"];
                                                            var price =
                                                                consignment
                                                                        .data()[
                                                                    "price"];
                                                            bidWidget.add(
                                                                TransporterCardOngoingMobile(
                                                              username:
                                                                  username,
                                                              id: id,
                                                              truckDetail:
                                                                  truckDetail,
                                                              price: price,
                                                              load: load,
                                                              description:
                                                                  description,
                                                              consignmentCode:
                                                                  consignmentCode,
                                                              pickUpLocation:
                                                                  pickUpLocation,
                                                              dropLocation:
                                                                  dropLocation,
                                                            ));
                                                          });
                                                          return ListView(
                                                            children: bidWidget,
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                          );
                                                        }
                                                        return Container();
                                                      }),
                                                ],
                                              ),
                                            )
                                          : subCategory == 1
                                              ? MobileTransporterCompleted()
                                              : MobileTransporterDelivered()
                                      : selectedTab == 2
                                          ? subCategory == 0
                                              ? MobileTransporterPersonalDetail(
                                                  selectedTab: 0)
                                              : MobileTransporterPersonalDetail(
                                                  selectedTab: 1)
                                          : Container(),
                            ),
                          ),
                          // notificationContainer(size),
                        ],
                      ),
                      footerWidget(size),
                    ],
                  ),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                id == null ? "" : id,
                style: TextStyle(
                    color: MyColors.primaryNew,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "User ID",
                style: TextStyle(
                    color: MyColors.secondary,
                    fontSize: 12,
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
          ),
          SizedBox(
            width: 15,
          ),
          // Icon(Icons.notifications, color: MyColors.primaryNew)
        ],
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
      height: 100,
      child: SingleChildScrollView(
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
                        fontSize: 14)),
                Text(
                    "34-44, Industrial Area Ratlam,\nIndustrial Area, Ratlam,\nMadhya Pradesh 457001",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: MyColors.secondary,
                        fontWeight: FontWeight.w400,
                        fontSize: 11)),
              ],
            ),
            Container(
              width: size.width * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "About Us",
                    style: TextStyle(
                      color: MyColors.secondary,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "Privacy Policy",
                    style: TextStyle(
                      color: MyColors.secondary,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "Terms and Conditions",
                    style: TextStyle(
                      color: MyColors.secondary,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    "Help",
                    style: TextStyle(
                      color: MyColors.secondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  notificationContainer(Size size) {
    return Positioned(
      top: 10,
      right: 10,
      child: Container(
        padding: EdgeInsets.all(size.width * 0.015),
        margin: EdgeInsets.only(
            top: size.height * 0.04, right: size.height * 0.035),
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
  bool isProfileTabShown = false, isBidTabShown = false;
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
                        width: 20,
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
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  tileColor: widget.selectedTab == 1
                      ? Color(0xfff1f1f1)
                      : Colors.transparent,
                  title: Container(
                    margin: EdgeInsets.only(left: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/transporterBid.png",
                          height: 35,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'My Bids',
                          style:
                              TextStyle(color: Color(0xff989898), fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      isProfileTabShown = false;
                      isBidTabShown = !isBidTabShown;
                    });
                  },
                ),
                isBidTabShown
                    ? Container(
                        margin: EdgeInsets.only(left: 64, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget.onFieldUpdated([1, 0]);
                                Navigator.of(context).pop();
                              },
                              child: Text("Bid History",
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
                              child: Text("Confirmed Consignment",
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
                                widget.onFieldUpdated([1, 2]);
                                Navigator.of(context).pop();
                              },
                              child: Text("Delivered Consignment",
                                  style: TextStyle(
                                      color: Color(0xff4d4d4d),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200)),
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
                      Image.asset(
                        "assets/transporterProfile.png",
                        height: 35,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Profile',
                        style:
                            TextStyle(color: Color(0xff989898), fontSize: 18),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      isBidTabShown = false;
                      isProfileTabShown = !isProfileTabShown;
                    });
                  },
                ),
                isProfileTabShown
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
                              child: Text("Personal Details",
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
                              child: Text("Company Details",
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