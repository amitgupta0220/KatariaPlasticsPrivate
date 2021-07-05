import 'dart:html' as html;
import 'dart:html';

import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DesktopTransporterDelivered extends StatefulWidget {
  @override
  _DesktopTransporterCompletedState createState() =>
      _DesktopTransporterCompletedState();
}

class _DesktopTransporterCompletedState
    extends State<DesktopTransporterDelivered> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: MyColors.backgroundNewPage,
        body: SingleChildScrollView(
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
                            "Delivered Orders",
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
                          .collection("myOrders")
                          .where("status", isEqualTo: "delivered")
                          .orderBy(
                            'date',
                            descending: true,
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
                            var date = consignment.data()["date"];
                            var bidPrice = consignment.data()["bidPrice"];
                            bidWidget.add(TransporterDeliveredCard(
                              consignmentCode: consignmentCode,
                              date: DateTime.fromMillisecondsSinceEpoch(
                                      double.parse(date).toInt())
                                  .toString()
                                  .split(" ")[0],
                              pickUpLocation: pickUpLocation,
                              dropLocation: dropLocation,
                              bidPrice: bidPrice,
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
            ],
          ),
        ),
      ),
    );
  }
}

class TransporterDeliveredCard extends StatefulWidget {
  final bidPrice, dropLocation, pickUpLocation, date, consignmentCode;
  TransporterDeliveredCard(
      {this.bidPrice,
      this.consignmentCode,
      this.date,
      this.dropLocation,
      this.pickUpLocation});
  @override
  _TransporterDeliveredCardState createState() =>
      _TransporterDeliveredCardState();
}

class _TransporterDeliveredCardState extends State<TransporterDeliveredCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      width: size.width - size.width * 0.3 - 120,
      height: size.height * 0.35,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              blurRadius: 5,
              spreadRadius: 0.01,
              offset: Offset(
                4,
                4,
              ),
            ),
          ],
          borderRadius: BorderRadius.circular(7)),
      child: Row(
        children: [
          Container(
            height: size.height * 0.35,
            width: (size.width - size.width * 0.3 - 120) / 3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      "https://st.depositphotos.com/2683099/3278/i/600/depositphotos_32782991-stock-photo-modern-warehouse.jpg",
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                )),
          ),
          Container(
            padding: EdgeInsets.all(size.width * 0.01),
            height: size.height * 0.35,
            width: (size.width - size.width * 0.3 - 200) / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/transporterPickUp.png",
                      height: 25,
                    ),
                    SizedBox(
                      width: size.width * 0.023,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.pickUpLocation,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Pickup Location",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/transporterDrop.png",
                      height: 25,
                    ),
                    SizedBox(
                      width: size.width * 0.027,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.dropLocation,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Drop Location",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  "Assigned On",
                  style: TextStyle(color: MyColors.secondary, fontSize: 12),
                ),
                Text(
                  "${widget.date}",
                  style: TextStyle(
                      color: Color(0xff4d4d4d),
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: size.width * 0.015,
                    left: size.width * 0.015,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "# ${widget.consignmentCode}",
                        style: TextStyle(
                            color: Color(0xff4d4d4d),
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                      Text(
                        "Consignment No.",
                        style:
                            TextStyle(color: MyColors.secondary, fontSize: 12),
                      ),
                      SizedBox(
                        height: size.width * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Final Price",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 10),
                          ),
                          Text(
                            "${widget.bidPrice}/-",
                            style: TextStyle(
                                color: Color(0xff4d4d4d),
                                fontWeight: FontWeight.w700,
                                fontSize: 24),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ViewTransporterDeliveredDesktop(
                              code: widget.consignmentCode,
                            )));
                  },
                  child: Container(
                    height: size.height * 0.065,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(7)),
                        color: MyColors.primaryNew),
                    child: Center(
                      child: Text("Details",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ViewTransporterDeliveredDesktop extends StatefulWidget {
  final String code;
  ViewTransporterDeliveredDesktop({this.code});
  @override
  _ViewTransporterDeliveredDesktopState createState() =>
      _ViewTransporterDeliveredDesktopState();
}

class _ViewTransporterDeliveredDesktopState
    extends State<ViewTransporterDeliveredDesktop> {
  int currentTab = 0;
  bool gotDocument = false;
  File fileDoc;
  DocumentSnapshot snap;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("consignment")
        .doc(widget.code)
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MyColors.backgroundNewPage,
        body: Column(children: [
          Container(
            height: size.height * 0.075,
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
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.keyboard_arrow_left_outlined,
                    color: MyColors.primaryNew,
                    size: 35,
                  ),
                ),
                // Hero(
                //   tag: "adminOpenConsignmentCode" + widget.consignmentCode,
                // child: Material(
                //   color: Colors.transparent,
                // child:
                Text(
                  "Consignment ID : ${widget.code}",
                  style: TextStyle(
                    fontSize: 20,
                    color: MyColors.primaryNew,
                    fontWeight: FontWeight.w700,
                  ),
                  //   ),
                  // ),
                ),
                Container()
              ],
            ),
          ),
          SizedBox(height: size.height * 0.011),
          gotDocument
              ? Container(
                  padding: EdgeInsets.only(
                    left: size.width * 0.015,
                    right: size.width * 0.015,
                  ),
                  height: size.height * 0.7,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Container(
                          width: 180,
                          height: size.height * 0.075,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentTab = 0;
                                  });
                                },
                                child: Text(
                                  "Detail",
                                  style: TextStyle(
                                    color: currentTab == 0
                                        ? MyColors.red
                                        : MyColors.secondaryNew,
                                    fontSize: currentTab == 0 ? 24 : 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentTab = 1;
                                  });
                                },
                                child: Text(
                                  "Delivery",
                                  style: TextStyle(
                                    color: currentTab == 1
                                        ? MyColors.red
                                        : MyColors.secondaryNew,
                                    fontSize: currentTab == 1 ? 24 : 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.011),
                        Container(
                          padding: EdgeInsets.only(
                            left: size.width * 0.015,
                            right: size.width * 0.015,
                          ),
                          height: size.height * 0.6,
                          width: size.width,
                          child: currentTab == 0
                              ? detailTab(size, snap)
                              : deliveryTab(size, snap),
                        )
                      ])))
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ]));
  }

  detailTab(Size size, DocumentSnapshot snap) {
    return Container(
      padding: EdgeInsets.only(
        top: size.height * 0.01,
        // bottom: size.height * 0.01,
        left: size.height * 0.01,
        right: size.height * 0.01,
      ),
      // width: size.width * 0.65,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // height: size.height * 0.65,
              width: size.width * 0.25,
              padding: EdgeInsets.only(right: size.height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    snap.data()["description"],
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color(0xff4d4d4d), fontSize: 16),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/transporterPickUp.png",
                        height: 25,
                      ),
                      SizedBox(
                        width: size.width * 0.023,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snap.data()["pickUpLocation"],
                            style: TextStyle(
                                color: MyColors.primaryNew,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Pickup Location",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/transporterDrop.png",
                        height: 26,
                      ),
                      SizedBox(
                        width: size.width * 0.027,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snap.data()["dropLocation"],
                            style: TextStyle(
                                color: MyColors.primaryNew,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Drop Location",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/trasnporterLoad.png",
                        height: 25,
                      ),
                      SizedBox(
                        width: size.width * 0.024,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snap.data()["load"],
                            style: TextStyle(
                                color: MyColors.primaryNew,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Load",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/transporterTruck.png",
                        height: 25,
                      ),
                      SizedBox(
                        width: size.width * 0.015,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snap.data()["truckDetail"],
                            style: TextStyle(
                                color: MyColors.primaryNew,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Truck Details",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/transporterTruck.png",
                        height: 25,
                      ),
                      SizedBox(
                        width: size.width * 0.015,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snap.data()["numberOfTruck"],
                            style: TextStyle(
                                color: MyColors.primaryNew,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Number Of Truck",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.date_range_outlined,
                        color: MyColors.red,
                        size: 25,
                      ),
                      SizedBox(
                        width: size.width * 0.024,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateTime.fromMillisecondsSinceEpoch(
                                    double.parse(snap.data()["date"]).toInt())
                                .toString()
                                .split(" ")[0],
                            style: TextStyle(
                                color: MyColors.primaryNew,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Date",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  deliveryTab(Size size, DocumentSnapshot snap) {
    return Container(
        padding: EdgeInsets.only(
          top: size.height * 0.01,
          bottom: size.height * 0.01,
          left: size.height * 0.01,
          right: size.height * 0.01,
        ),
        width: size.width * 0.65,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(8),
                height: size.width * 0.2,
                width: size.width,
                child: Image.network(
                  snap.data()["deliveredImageUrl"],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            GestureDetector(
              onTap: () {
                html.AnchorElement anchorElement = new html.AnchorElement(
                    href: snap.data()["deliveredImageUrl"]);
                anchorElement.download = snap.data()["deliveredImageUrl"];
                anchorElement.target = "__blank";
                anchorElement.click();
              },
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: MyColors.primaryNew,
                      borderRadius: BorderRadius.circular(2)),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "View",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
            )
          ]),
        ));
  }
}
