import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminOpenConsignment extends StatefulWidget {
  @override
  _AdminOpenConsignmentState createState() => _AdminOpenConsignmentState();
}

class _AdminOpenConsignmentState extends State<AdminOpenConsignment> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
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
                          "Open Consignment",
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
            Container(
              height: size.height * 0.7,
              margin: EdgeInsets.only(
                top: size.height * 0.01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(7),
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
                color: Colors.white,
              ),
              padding: EdgeInsets.only(
                top: size.width * 0.03,
                bottom: size.width * 0.03,
                left: size.width * 0.02,
                right: size.width * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: size.width * 0.1,
                        child: Text(
                          "Consignment ID",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: MyColors.secondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.11,
                        child: Text(
                          "Pickup",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: MyColors.secondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.11,
                        child: Text(
                          "Drop",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: MyColors.secondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.13,
                        child: Text(
                          "Bid (L1)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: MyColors.secondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Divider(
                    color: MyColors.secondaryNew,
                    thickness: 2,
                    height: 1,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Expanded(
                    child: Scrollbar(
                      thickness: 2,
                      child: SingleChildScrollView(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('consignment')
                                // .where("status", isEqualTo: "open")
                                .orderBy('date', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              List<Widget> consignmentCard = [];
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.hasData) {
                                final consignmentData = snapshot.data.docs;
                                consignmentData.forEach((consignment) {
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
                                  var date = consignment.data()["date"];
                                  var numberOfTruck =
                                      consignment.data()["numberOfTruck"];
                                  var price = consignment.data()["price"];
                                  var currentMinBid =
                                      consignment.data()["currentMinBid"];
                                  if (consignment.data()["status"] == "open")
                                    consignmentCard
                                        .add(AdminOpenConsignmentCard(
                                      currentMinBid: currentMinBid,
                                      truckDetail: truckDetail,
                                      price: price,
                                      load: load,
                                      numberOfTruck: numberOfTruck,
                                      description: description,
                                      consignmentCode: consignmentCode,
                                      pickUpLocation: pickUpLocation,
                                      dropLocation: dropLocation,
                                      date: date,
                                    ));
                                });
                                return ListView(
                                  children: consignmentCard,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                );
                              }
                              return Container();
                            }),
                      ),
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
}

class AdminOpenConsignmentCard extends StatefulWidget {
  final String consignmentCode,
      price,
      pickUpLocation,
      dropLocation,
      numberOfTruck,
      description,
      load,
      currentMinBid,
      date,
      truckDetail;
  AdminOpenConsignmentCard({
    this.consignmentCode,
    this.price,
    this.numberOfTruck,
    this.load,
    this.truckDetail,
    this.date,
    this.dropLocation,
    this.pickUpLocation,
    this.description,
    this.currentMinBid,
  });
  @override
  _AdminOpenConsignmentCardState createState() =>
      _AdminOpenConsignmentCardState();
}

class _AdminOpenConsignmentCardState extends State<AdminOpenConsignmentCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        bottom: size.height * 0.05,
      ),
      child: Row(
        children: [
          Hero(
            tag: "adminOpenConsignmentCode" + widget.consignmentCode,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: size.width * 0.1,
                child: Text(
                  widget.consignmentCode,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: MyColors.secondary,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: size.width * 0.11,
            child: Hero(
              tag:
                  "adminOpenConsignmentPickUpLocation" + widget.consignmentCode,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  widget.pickUpLocation,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: MyColors.secondary,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: size.width * 0.11,
            child: Hero(
              tag: "adminOpenConsignmentDropLocation" + widget.consignmentCode,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  widget.dropLocation,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: MyColors.secondary,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: size.width * 0.13,
            child: Text(
              widget.currentMinBid,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: MyColors.secondary,
              ),
            ),
          ),
          Expanded(
            // width: size.width * 0.13,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ViewAdminOpenConsignment(
                          currentMinBid: widget.currentMinBid,
                          truckDetail: widget.truckDetail,
                          price: widget.price,
                          load: widget.load,
                          numberOfTruck: widget.numberOfTruck,
                          description: widget.description,
                          consignmentCode: widget.consignmentCode,
                          pickUpLocation: widget.pickUpLocation,
                          date: widget.date,
                          dropLocation: widget.dropLocation,
                        )));
              },
              child: Text(
                "View",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: MyColors.primaryNew,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ViewAdminOpenConsignment extends StatefulWidget {
  final String consignmentCode,
      price,
      pickUpLocation,
      dropLocation,
      description,
      load,
      numberOfTruck,
      date,
      currentMinBid,
      truckDetail;
  ViewAdminOpenConsignment({
    this.consignmentCode,
    this.price,
    this.numberOfTruck,
    this.load,
    this.date,
    this.truckDetail,
    this.dropLocation,
    this.pickUpLocation,
    this.description,
    this.currentMinBid,
  });
  @override
  _ViewAdminOpenConsignmentState createState() =>
      _ViewAdminOpenConsignmentState();
}

class _ViewAdminOpenConsignmentState extends State<ViewAdminOpenConsignment> {
  int currentTab = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.backgroundNewPage,
      body: Column(
        children: [
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
                Hero(
                  tag: "adminOpenConsignmentCode" + widget.consignmentCode,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "Consignment No. " + widget.consignmentCode,
                      style: TextStyle(
                        fontSize: 20,
                        color: MyColors.primaryNew,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Container()
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
                  width: 150,
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
                          "Bids",
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
                  height: size.height * 0.5,
                  width: size.width,
                  child: currentTab == 0 ? detailsCard(size) : bidCard(size),
                )
              ],
            )),
          ),
          SizedBox(height: size.height * 0.011),
          Container(
            height: size.height * 0.1,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(7),
                bottomRight: Radius.circular(7),
              ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    // width: size.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(7),
                      ),
                      color: MyColors.primaryNew,
                    ),
                    child: Center(
                        child: Text("Close Consignment",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ))),
                  ),
                ),
                Expanded(
                  child: Container(
                    // width: size.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(7),
                      ),
                      color: MyColors.primaryNew,
                    ),
                    child: Center(
                        child: Text("Export Details",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  detailsCard(Size size) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width * 0.15,
                child: Text(
                  widget.description,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.fade,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
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
                      Hero(
                        tag: "adminOpenConsignmentPickUpLocation" +
                            widget.consignmentCode,
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            widget.pickUpLocation,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
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
                      Hero(
                        tag: "adminOpenConsignmentDropLocation" +
                            widget.consignmentCode,
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            widget.dropLocation,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
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
                        widget.load,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
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
                    color: MyColors.red,
                  ),
                  SizedBox(
                    width: size.width * 0.015,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.truckDetail,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
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
                    color: MyColors.red,
                  ),
                  SizedBox(
                    width: size.width * 0.015,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.numberOfTruck,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
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
                children: [
                  Icon(Icons.date_range_outlined,
                      color: MyColors.red, size: 20),
                  SizedBox(
                    width: size.width * 0.024,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateTime.fromMillisecondsSinceEpoch(
                                double.parse(widget.date).toInt())
                            .toString()
                            .split(" ")[0],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
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
                  )
                ],
              ),
            ],
          ),
          // Container(
          //   margin: EdgeInsets.only(top: size.height * 0.05),
          //   color: Color.fromRGBO(230, 230, 230, 0.6),
          //   width: 3,
          //   height: size.height * 0.7,
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Opening Bid",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 10),
                  ),
                  Text(
                    "${widget.price}/-",
                    style: TextStyle(
                        color: Color(0xff4d4d4d),
                        fontWeight: FontWeight.w700,
                        fontSize: 24),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Minimum Bid (L1)",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 10),
                  ),
                  StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("consignment")
                          .doc(widget.consignmentCode)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: Container());
                        }
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${snapshot.data.data()["currentMinBid"]}/-",
                                textAlign: TextAlign.left,
                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: MyColors.primaryNew,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24),
                              ),
                              Container(
                                width: size.width * 0.076,
                                child: Text(
                                  "By " +
                                      snapshot.data.data()["currentMinBidByID"],
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color(0xff666666),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10),
                                ),
                              ),
                            ],
                          );
                        }
                        return Container();
                      }),
                ],
              ),
            ],
          ),
          Container()
        ],
      ),
    );
  }

  bidCard(Size size) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Container(
            width: size.width * 0.13,
            child: Text(
              "Bid By",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: MyColors.secondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            width: size.width * 0.13,
            child: Text(
              "Bid Price",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: MyColors.secondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: size.height * 0.03,
      ),
      Divider(
        color: MyColors.secondaryNew,
        thickness: 2,
        height: 1,
      ),
      SizedBox(
        height: size.height * 0.03,
      ),
      Expanded(
        child: Scrollbar(
            thickness: 1,
            radius: Radius.circular(4),
            child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("consignment")
                    .doc(widget.consignmentCode)
                    .collection("userBids")
                    .orderBy("bidPrice", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  List<Widget> bidWidget = [];
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    final userData = snapshot.data.docs;
                    userData.forEach((bid) {
                      var currentMinBidBy = bid.id;
                      var bidPrice = bid.data()["bidPrice"];
                      var username = bid.data()["username"];
                      var id = bid.data()["id"];
                      bidWidget.add(DisplayBidAdminOpenConsignment(
                        consignmentCode: widget.consignmentCode,
                        bidPrice: bidPrice,
                        username: username,
                        id: id,
                        currentMinBidBy: currentMinBidBy,
                      ));
                    });
                    return ListView(
                      children: bidWidget,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    );
                  }
                  return Container();
                },
              ),
            )),
      )
    ]);
  }
}

class DisplayBidAdminOpenConsignment extends StatefulWidget {
  final String consignmentCode, bidPrice, currentMinBidBy, username, id;
  DisplayBidAdminOpenConsignment({
    this.bidPrice,
    this.consignmentCode,
    this.currentMinBidBy,
    this.username,
    this.id,
  });
  @override
  _DisplayBidAdminOpenConsignmentState createState() =>
      _DisplayBidAdminOpenConsignmentState();
}

class _DisplayBidAdminOpenConsignmentState
    extends State<DisplayBidAdminOpenConsignment> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: size.width * 0.13,
                child: Text(
                  widget.username,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: MyColors.secondary,
                  ),
                ),
              ),
              Container(
                width: size.width * 0.13,
                child: Text(
                  widget.bidPrice,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: MyColors.secondary,
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              FirebaseFirestore.instance
                  .collection("consignment")
                  .doc(widget.consignmentCode)
                  .update({
                "assignedTo": widget.currentMinBidBy,
                "assignedToName": widget.username,
                "assignedToID": widget.id,
                "status": "ongoing"
              });
              FirebaseFirestore.instance
                  .collection("consignment")
                  .doc(widget.consignmentCode)
                  .get()
                  .then((value) {
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(widget.currentMinBidBy)
                    .collection("myOrders")
                    .doc(widget.consignmentCode)
                    .set({
                  "bidPrice": widget.bidPrice,
                  "date": DateTime.now().millisecondsSinceEpoch.toString(),
                  "deliveredImageUrl": null,
                  "dropLocation": value.data()["dropLocation"],
                  "pickUpLocation": value.data()["pickUpLocation"],
                  "username": widget.currentMinBidBy,
                  "status": "ongoing"
                });
              });
              Navigator.of(context).pop();
            },
            child: Container(
              height: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: MyColors.primaryNew,
                  borderRadius: BorderRadius.circular(3)),
              width: size.width * 0.075,
              child: Text(
                "Confirm",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
