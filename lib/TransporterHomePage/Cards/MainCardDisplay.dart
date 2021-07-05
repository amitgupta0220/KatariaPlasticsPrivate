import 'package:KPPL/TransporterHomePage/Cards/TransporterCard.dart';
import 'package:KPPL/TransporterHomePage/TransporterPageCards/TransporterOngoingCard.dart';
import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class MainCardDisplay extends StatefulWidget {
  @override
  _MainCardDisplayState createState() => _MainCardDisplayState();
}

class _MainCardDisplayState extends State<MainCardDisplay> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        height: size.height - size.height * 0.04 - size.height * 0.1,
        width: size.width - size.width * 0.3 - 120,
        margin: EdgeInsets.only(
          top: size.height * 0.04,
          right: 27,
          left: size.height * 0.035 + 147,
        ),
        color: Colors.transparent,
        child: SingleChildScrollView(
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
                            "Home",
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      final userData = snapshot.data.docs;
                      userData.forEach((consignment) {
                        var pickUpLocation =
                            consignment.data()["pickUpLocation"];
                        var dropLocation = consignment.data()["dropLocation"];
                        var consignmentCode = consignment.id;
                        var description = consignment.data()["description"];
                        var numberOfTruck = consignment.data()["numberOfTruck"];
                        var truckDetail = consignment.data()["truckDetail"];
                        var date = consignment.data()["date"];
                        var load = consignment.data()["load"];
                        var price = consignment.data()["price"];
                        bidWidget.add(TransporterCardWidget(
                          truckDetail: truckDetail,
                          price: price,
                          numberOfTruck: numberOfTruck,
                          date: date,
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
                      );
                    }
                    return Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class TransporterDisplayOngoingBids extends StatefulWidget {
  final String title, id, username;
  TransporterDisplayOngoingBids({this.title, this.id, this.username});
  @override
  _TransporterDisplayOngoingBidsState createState() =>
      _TransporterDisplayOngoingBidsState();
}

class _TransporterDisplayOngoingBidsState
    extends State<TransporterDisplayOngoingBids> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
        child: Container(
            height: size.height - size.height * 0.04 - size.height * 0.1,
            width: size.width - size.width * 0.3 - 120,
            margin: EdgeInsets.only(
              top: size.height * 0.04,
              right: 27,
              left: size.height * 0.035 + 147,
            ),
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Column(children: [
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
                              widget.title,
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
                Scrollbar(
                  thickness: 2,
                  child: SingleChildScrollView(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser.email)
                            .collection("myBids")
                            .orderBy(
                              'date',
                            )
                            .snapshots(),
                        builder: (context, snapshot) {
                          List<Widget> bidWidget = [];
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData) {
                            final userData = snapshot.data.docs;
                            userData.forEach((consignment) {
                              var pickUpLocation =
                                  consignment.data()["pickUpLocation"];
                              var dropLocation =
                                  consignment.data()["dropLocation"];
                              var consignmentCode = consignment.id;
                              var description =
                                  consignment.data()["description"];
                              var truckDetail =
                                  consignment.data()["truckDetail"];
                              var load = consignment.data()["load"];
                              var price = consignment.data()["price"];
                              bidWidget.add(TransporterOngoingCard(
                                truckDetail: truckDetail,
                                username: widget.username,
                                id: widget.id,
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
                              physics: NeverScrollableScrollPhysics(),
                            );
                          }
                          return Container();
                        }),
                  ),
                ),
              ]),
            )));
  }
}

class TransporterPersonalDetails extends StatefulWidget {
  final ValueChanged<int> onFieldUpdated;
  final String title;
  final int selectedTab;
  TransporterPersonalDetails(
      {this.title, @required this.selectedTab, this.onFieldUpdated});
  @override
  _TransporterPersonalDetailsState createState() =>
      _TransporterPersonalDetailsState();
}

class _TransporterPersonalDetailsState
    extends State<TransporterPersonalDetails> {
  int selectedTab;
  DocumentSnapshot snap;
  bool gotDocument = false;
  @override
  void initState() {
    super.initState();
    getDocument();
  }

  getDocument() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.email)
        .get()
        .then((value) {
      snap = value;
      setState(() {
        gotDocument = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    selectedTab = widget.selectedTab;
    Size size = MediaQuery.of(context).size;
    return Expanded(
        child: Container(
            height: size.height - size.height * 0.04 - size.height * 0.1,
            width: size.width - size.width * 0.3 - 120,
            margin: EdgeInsets.only(
              top: size.height * 0.04,
              right: 27,
              left: size.height * 0.035 + 147,
            ),
            color: Colors.transparent,
            child: SingleChildScrollView(
                child: Row(children: [
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
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(7),
                      topLeft: Radius.circular(7),
                    )),
                width: size.width * 0.2,
                height: size.height * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Center(
                      child: Text(
                        "My Profile",
                        style: TextStyle(
                            color: MyColors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.onFieldUpdated(0);
                          selectedTab = 0;
                        });
                      },
                      child: Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 5,
                              height: 46,
                              decoration: BoxDecoration(
                                  color: selectedTab == 0
                                      ? MyColors.red
                                      : Colors.white),
                            ),
                            Container(
                              width: size.width * 0.2 - 5,
                              padding: EdgeInsets.only(
                                top: 12,
                                bottom: 12,
                                left: size.width * 0.03,
                              ),
                              decoration: BoxDecoration(
                                color: selectedTab == 0
                                    ? MyColors.secondaryNew
                                    : Colors.white,
                              ),
                              child: Text("Personal",
                                  style: TextStyle(
                                    color: MyColors.secondary,
                                    fontSize: 18,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.onFieldUpdated(1);
                          selectedTab = 1;
                        });
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 5,
                              height: 46,
                              decoration: BoxDecoration(
                                  color: selectedTab == 1
                                      ? MyColors.red
                                      : Colors.white),
                            ),
                            Container(
                              width: size.width * 0.2 - 5,
                              padding: EdgeInsets.only(
                                top: 12,
                                bottom: 12,
                                left: size.width * 0.03,
                              ),
                              decoration: BoxDecoration(
                                color: selectedTab == 1
                                    ? MyColors.secondaryNew
                                    : Colors.white,
                              ),
                              child: Text("Company",
                                  style: TextStyle(
                                    color: MyColors.secondary,
                                    fontSize: 18,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 8),
                  height: size.height * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(7),
                      bottomRight: Radius.circular(7),
                    ),
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
                  child: Container(
                    margin: EdgeInsets.only(
                      left: size.width * 0.025,
                      right: size.width * 0.025,
                      bottom: size.width * 0.025,
                      top: size.width * 0.015,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedTab == 0
                              ? "Personal Details"
                              : "Company Details",
                          style: TextStyle(
                              color: MyColors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        Divider(
                          thickness: 2,
                          color: MyColors.red,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.all(size.width * 0.015),
                          child: selectedTab == 0
                              ? personalDetails(size, snap, gotDocument)
                              : companyDetails(size, snap, gotDocument),
                        ))
                      ],
                    ),
                  ),
                ),
              )
            ]))));
  }
}

Widget personalDetails(Size size, DocumentSnapshot snap, bool value) {
  return SingleChildScrollView(
      child: value
          ? Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: size.width * 0.085,
                      child: Text(
                        "User ID",
                        style:
                            TextStyle(color: MyColors.secondary, fontSize: 18),
                      ),
                    ),
                    Expanded(
                      // width: size.width * 0.2,
                      child: Text(
                        snap.data()["userID"],
                        style:
                            TextStyle(color: Color(0xff4d4d4d), fontSize: 18),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.055,
                ),
                Row(
                  children: [
                    Container(
                      width: size.width * 0.085,
                      child: Text(
                        "Name",
                        style:
                            TextStyle(color: MyColors.secondary, fontSize: 18),
                      ),
                    ),
                    Expanded(
                      // width: size.width * 0.2,
                      child: Text(
                        snap.data()["username"],
                        style:
                            TextStyle(color: Color(0xff4d4d4d), fontSize: 18),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.055,
                ),
                Row(
                  children: [
                    Container(
                      width: size.width * 0.085,
                      child: Text(
                        "Phone No.",
                        style:
                            TextStyle(color: MyColors.secondary, fontSize: 18),
                      ),
                    ),
                    Expanded(
                      // width: size.width * 0.2,
                      child: Text(
                        snap.data()["phone"],
                        style:
                            TextStyle(color: Color(0xff4d4d4d), fontSize: 18),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.055,
                ),
                Row(
                  children: [
                    Container(
                      width: size.width * 0.085,
                      child: Text(
                        "Email ID",
                        style:
                            TextStyle(color: MyColors.secondary, fontSize: 18),
                      ),
                    ),
                    Expanded(
                      // width: size.width * 0.2,
                      child: Text(
                        snap.id,
                        style:
                            TextStyle(color: Color(0xff4d4d4d), fontSize: 18),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
              ],
            )
          : CircularProgressIndicator());
}

Widget companyDetails(Size size, DocumentSnapshot snap, bool value) {
  return SingleChildScrollView(
      child: value
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: size.width * 0.1,
                          child: Text(
                            "Company Name",
                            style: TextStyle(
                                color: MyColors.secondary, fontSize: 18),
                          ),
                        ),
                        Expanded(
                          // width: size.width * 0.2,
                          child: Text(
                            snap.data()["companyName"],
                            style: TextStyle(
                                color: Color(0xff4d4d4d), fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.055,
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 0.1,
                          child: Text(
                            "Company Type",
                            style: TextStyle(
                                color: MyColors.secondary, fontSize: 18),
                          ),
                        ),
                        Expanded(
                          // width: size.width * 0.2,
                          child: Text(
                            snap.data()["companyType"],
                            style: TextStyle(
                                color: Color(0xff4d4d4d), fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.055,
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 0.1,
                          child: Text(
                            "Registration No.",
                            style: TextStyle(
                                color: MyColors.secondary, fontSize: 18),
                          ),
                        ),
                        Expanded(
                          // width: size.width * 0.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snap.data()["registrationNumber"],
                                style: TextStyle(
                                    color: Color(0xff4d4d4d), fontSize: 18),
                              ),
                              GestureDetector(
                                onTap: () {
                                  html.AnchorElement anchorElement =
                                      new html.AnchorElement(
                                          href: snap.data()["regUrl"]);
                                  anchorElement.download =
                                      snap.data()["regUrl"];
                                  anchorElement.target = "__blank";
                                  anchorElement.click();
                                },
                                child: Text(
                                  "View",
                                  style: TextStyle(
                                      color: MyColors.primaryNew, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.055,
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 0.1,
                          child: Text(
                            "PAN No.",
                            style: TextStyle(
                                color: MyColors.secondary, fontSize: 18),
                          ),
                        ),
                        Expanded(
                          // width: size.width * 0.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snap.data()["pan"],
                                style: TextStyle(
                                    color: Color(0xff4d4d4d), fontSize: 18),
                              ),
                              GestureDetector(
                                onTap: () {
                                  html.AnchorElement anchorElement =
                                      new html.AnchorElement(
                                          href: snap.data()["panUrl"]);
                                  anchorElement.download =
                                      snap.data()["panUrl"];
                                  anchorElement.target = "__blank";
                                  anchorElement.click();
                                },
                                child: Text(
                                  "View",
                                  style: TextStyle(
                                      color: MyColors.primaryNew, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Container(
                  child: Text(
                    "* To change your company details contact admin.",
                    style: TextStyle(
                      color: MyColors.red,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            )
          : CircularProgressIndicator());
}
