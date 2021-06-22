import 'package:KPPL/Cards/TransorterConfirm.dart';
import 'package:KPPL/Cards/TransporterCard.dart';
import 'package:KPPL/Cards/TransporterCardMobile.dart';
import 'package:KPPL/Cards/TransporterDelivered.dart';
import 'package:KPPL/Views/PrivacyPolicy.dart';
import 'package:KPPL/Views/TermsAndConditions.dart';
import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:KPPL/Views/TransporterPersonalDetails.dart';
import 'package:KPPL/Cards/TransporterOngoinCard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int clickedTab = 0, selectedTab = 0;
  String username, id;
  String email = '';
  bool gotId = false;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.email)
        .get()
        .then((value) {
      setState(() {
        id = value.data()["userID"];
        username = value.data()["username"];
        gotId = true;
      });
    });
    email = FirebaseAuth.instance.currentUser.email;
    // tempFunction();
  }

  onTabChanged(List index) {
    setState(() {
      selectedTab = index[0];
      clickedTab = index[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MyColors.backgroundNewPage,
        appBar: AppBar(
          // actions: [
          //   GestureDetector(
          //     child: Container(
          //         padding: EdgeInsets.all(3), child: Icon(Icons.more_vert)),
          //   ),
          // ],
          iconTheme: IconThemeData(color: MyColors.primaryNew),
          elevation: 0,
          backgroundColor: MyColors.backgroundNewPage,
        ),
        drawer: SideDrawer(
          onFieldUpdated: onTabChanged,
          selectedTab: selectedTab,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  top: size.width * 0.05,
                ),
                child: gotId
                    ? selectedTab == 0
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
                                        height: size.height * 0.08,
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
                                          height: size.height * 0.08,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: size.height * 0.05),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Home",
                                              style: TextStyle(
                                                  color: MyColors.primaryNew,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
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
                                        .where("status", isEqualTo: "open")
                                        .orderBy(
                                          'date',
                                        )
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      List<Widget> bidWidget = [];
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                      if (snapshot.hasData) {
                                        final userData = snapshot.data.docs;
                                        userData.forEach((consignment) {
                                          var pickUpLocation = consignment
                                              .data()["pickUpLocation"];
                                          var dropLocation = consignment
                                              .data()["dropLocation"];
                                          var consignmentCode = consignment.id;
                                          var description =
                                              consignment.data()["description"];
                                          var truckDetail =
                                              consignment.data()["truckDetail"];
                                          var load = consignment.data()["load"];
                                          var date = consignment.data()["date"];
                                          var numberOfTruck = consignment
                                              .data()["numberOfTruck"];
                                          var price =
                                              consignment.data()["price"];
                                          bidWidget.add(TransporterCardMobile(
                                            numberOfTruck: numberOfTruck,
                                            username: username,
                                            id: id,
                                            date: date,
                                            truckDetail: truckDetail,
                                            price: price,
                                            load: load,
                                            description: description,
                                            consignmentCode: consignmentCode,
                                            pickUpLocation: pickUpLocation,
                                            dropLocation: dropLocation,
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
                            ? clickedTab == 0
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
                                                width: 20,
                                                height: size.height * 0.08,
                                                decoration: BoxDecoration(
                                                    color: MyColors.primaryNew,
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
                                                            Radius.circular(7),
                                                        bottomRight:
                                                            Radius.circular(7),
                                                      )),
                                                  height: size.height * 0.08,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left:
                                                            size.height * 0.05),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Bid History",
                                                      style: TextStyle(
                                                          color: MyColors
                                                              .primaryNew,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(
                                                  FirebaseAuth.instance
                                                      .currentUser.email,
                                                )
                                                .collection("myBids")
                                                .orderBy(
                                                  'date',
                                                  descending: true,
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
                                                userData.forEach((consignment) {
                                                  var pickUpLocation =
                                                      consignment.data()[
                                                          "pickUpLocation"];
                                                  var dropLocation = consignment
                                                      .data()["dropLocation"];
                                                  var consignmentCode =
                                                      consignment.id;
                                                  var description = consignment
                                                      .data()["description"];
                                                  var truckDetail = consignment
                                                      .data()["truckDetail"];
                                                  var load = consignment
                                                      .data()["load"];

                                                  var price = consignment
                                                      .data()["price"];
                                                  bidWidget.add(
                                                      TransporterCardOngoingMobile(
                                                    username: username,
                                                    id: id,
                                                    truckDetail: truckDetail,
                                                    price: price,
                                                    load: load,
                                                    description: description,
                                                    consignmentCode:
                                                        consignmentCode,
                                                    pickUpLocation:
                                                        pickUpLocation,
                                                    dropLocation: dropLocation,
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
                                : clickedTab == 1
                                    ? Column(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              color: Colors.transparent,
                                              child: TransporterConfirm(),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              color: Colors.transparent,
                                              child: TransporterDelivered(),
                                            ),
                                          ),
                                        ],
                                      )
                            : selectedTab == 2
                                ? clickedTab == 0
                                    ? TransporterPersonalDetail(selectedTab: 0)
                                    : TransporterPersonalDetail(selectedTab: 1)
                                : selectedTab == 3
                                    ? PrivacyPolicy()
                                    : selectedTab == 4
                                        ? TermsAndConditions()
                                        : Container()
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ],
        ));
  }
}
