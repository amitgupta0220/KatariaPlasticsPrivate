import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';

class TransporterDelivered extends StatefulWidget {
  @override
  _TransporterDeliveredState createState() => _TransporterDeliveredState();
}

class _TransporterDeliveredState extends State<TransporterDelivered> {
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
                          margin: EdgeInsets.only(left: size.height * 0.05),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Delivered Orders",
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
              Scrollbar(
                thickness: 2,
                child: SingleChildScrollView(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser.email)
                          .collection("myOrders")
                          .where("status", isEqualTo: "delivered")
                          .orderBy('date', descending: true)
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
      margin: EdgeInsets.only(bottom: size.width * 0.02),
      width: size.width,
      // height: size.height * 0.5,
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
      child: Column(
        children: [
          Container(
            height: size.height * 0.18,
            // width: (size.width - 120),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      "https://st.depositphotos.com/2683099/3278/i/600/depositphotos_32782991-stock-photo-modern-warehouse.jpg",
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                )),
          ),
          Container(
            // height: size.height * 0.35,
            width: (size.width - 120),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: size.height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/transporterPickUp.png",
                        height: 15,
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
                                fontSize: 11,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Pickup Location",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 8,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  ),
                  // SizedBox(
                  //   height: size.height * 0.01,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/transporterDrop.png",
                        height: 15,
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
                                fontSize: 11,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Drop Location",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 8,
                                fontWeight: FontWeight.w400),
                          )
                        ],
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
                    "assets/images/rupee.png",
                    height: 13,
                    color: MyColors.red,
                  ),
                  SizedBox(
                    width: size.width * 0.025,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.bidPrice,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Final Price",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 8,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ],
              ),
            ]),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ViewTransporterDelivered(
                        code: widget.consignmentCode,
                      )));
            },
            child: Container(
              height: size.height * 0.065,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(7),
                    bottomLeft: Radius.circular(7),
                  ),
                  color: MyColors.primaryNew),
              child: Center(
                child: Text("View Details",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ViewTransporterDelivered extends StatefulWidget {
  final String code;
  ViewTransporterDelivered({this.code});
  @override
  _ViewTransporterDeliveredState createState() =>
      _ViewTransporterDeliveredState();
}

class _ViewTransporterDeliveredState extends State<ViewTransporterDelivered> {
  int currentTab = 0;
  bool gotDocument = false;
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
      if (mounted)
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
                    fontSize: 16,
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
                  // height: size.height * 0.6,
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
                          width: 135,
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
                                    fontSize: currentTab == 0 ? 16 : 14,
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
                                  "Document",
                                  style: TextStyle(
                                    color: currentTab == 1
                                        ? MyColors.red
                                        : MyColors.secondaryNew,
                                    fontSize: currentTab == 1 ? 16 : 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: size.width * 0.015,
                            right: size.width * 0.015,
                          ),
                          height: size.height * 0.65,
                          width: size.width,
                          child: currentTab == 0
                              ? detailTab(size, snap)
                              : documentTab(size, snap),
                        )
                      ])))
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ]));
  }

  detailTab(Size size, DocumentSnapshot snap) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: size.height * 0.01,
          left: size.height * 0.01,
        ),
        width: size.width,
        child: Row(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: Text(
                      snap.data()["description"],
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Color(0xff4d4d4d), fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/transporterPickUp.png",
                        height: 15,
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
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Pickup Location",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
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
                        "assets/images/transporterDrop.png",
                        height: 20,
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
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Drop Location",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
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
                        "assets/images/trasnporterLoad.png",
                        height: 20,
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
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Load",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
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
                        "assets/images/transporterTruck.png",
                        height: 15,
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
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Truck Details",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
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
                    children: [
                      Image.asset(
                        "assets/images/transporterTruck.png",
                        height: 15,
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
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Number Of Trucks",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 11,
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
                      Icon(
                        Icons.calendar_today_outlined,
                        color: MyColors.red,
                        size: 18,
                      ),
                      SizedBox(
                        width: size.width * 0.027,
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
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Date",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
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

  documentTab(Size size, DocumentSnapshot snap) {
    return Container(
        padding: EdgeInsets.only(
          top: size.height * 0.01,
          bottom: size.height * 0.01,
          left: size.height * 0.01,
          right: size.height * 0.01,
        ),
        width: size.width * 0.65,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(
            height: size.height * 0.35,
            width: size.width,
            child: Image.network(
              snap.data()["deliveredImageUrl"],
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          GestureDetector(
            onTap: () async {
              await ImageDownloader.downloadImage(
                  snap.data()["deliveredImageUrl"]);
            },
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: MyColors.primaryNew,
                    borderRadius: BorderRadius.circular(2)),
                padding: EdgeInsets.all(8),
                child: Text(
                  "Download Image",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
          ),
        ]));
  }
}
