import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class AdminDeliveredConsignment extends StatefulWidget {
  @override
  _AdminDeliveredConsignmentState createState() =>
      _AdminDeliveredConsignmentState();
}

class _AdminDeliveredConsignmentState extends State<AdminDeliveredConsignment> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(children: [
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
                            "Delivered Consignment",
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
                                "Final Bid",
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
                                      .where("status", isEqualTo: "delivered")
                                      // .orderBy('created_at', descending: true)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    List<Widget> consignmentCard = [];
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                    if (snapshot.hasData) {
                                      final consignmentData =
                                          snapshot.data.docs;
                                      consignmentData.forEach((consignment) {
                                        var pickUpLocation = consignment
                                            .data()["pickUpLocation"];
                                        var dropLocation =
                                            consignment.data()["dropLocation"];
                                        var consignmentCode = consignment.id;
                                        var description =
                                            consignment.data()["description"];
                                        var truckDetail =
                                            consignment.data()["truckDetail"];
                                        var load = consignment.data()["load"];
                                        var price = consignment.data()["price"];
                                        var numberOfTruck =
                                            consignment.data()["numberOfTruck"];
                                        var currentMinBid =
                                            consignment.data()["currentMinBid"];
                                        var date = consignment.data()["date"];
                                        var assignedTo =
                                            consignment.data()["assignedTo"];
                                        var assignedToID =
                                            consignment.data()["assignedToID"];
                                        var assignedToName = consignment
                                            .data()["assignedToName"];
                                        var url = consignment
                                            .data()["deliveredImageUrl"];
                                        consignmentCard
                                            .add(AdminDeliveredConsignmentCard(
                                          assignedTo: assignedTo,
                                          assignedToID: assignedToID,
                                          assignedToName: assignedToName,
                                          url: url,
                                          date: date,
                                          currentMinBid: currentMinBid,
                                          truckDetail: truckDetail,
                                          price: price,
                                          numberOfTruck: numberOfTruck,
                                          load: load,
                                          description: description,
                                          consignmentCode: consignmentCode,
                                          pickUpLocation: pickUpLocation,
                                          dropLocation: dropLocation,
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
                      ]))
            ])));
  }
}

class AdminDeliveredConsignmentCard extends StatefulWidget {
  final String consignmentCode,
      price,
      pickUpLocation,
      dropLocation,
      description,
      load,
      currentMinBid,
      assignedTo,
      assignedToID,
      assignedToName,
      url,
      numberOfTruck,
      date,
      truckDetail;
  AdminDeliveredConsignmentCard({
    this.consignmentCode,
    this.price,
    this.load,
    this.date,
    this.numberOfTruck,
    this.assignedTo,
    this.assignedToID,
    this.assignedToName,
    this.url,
    this.truckDetail,
    this.dropLocation,
    this.pickUpLocation,
    this.description,
    this.currentMinBid,
  });
  @override
  _AdminDeliveredConsignmentCardState createState() =>
      _AdminDeliveredConsignmentCardState();
}

class _AdminDeliveredConsignmentCardState
    extends State<AdminDeliveredConsignmentCard> {
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
            tag: "adminDeliveredConsignmentCode" + widget.consignmentCode,
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
              tag: "adminDeliveredConsignmentPickUpLocation" +
                  widget.consignmentCode,
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
              tag: "adminDeliveredConsignmentDropLocation" +
                  widget.consignmentCode,
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
                    builder: (_) => ViewAdminDeliveredConsignment(
                          currentMinBid: widget.currentMinBid,
                          truckDetail: widget.truckDetail,
                          price: widget.price,
                          load: widget.load,
                          description: widget.description,
                          consignmentCode: widget.consignmentCode,
                          pickUpLocation: widget.pickUpLocation,
                          dropLocation: widget.dropLocation,
                          assignedTo: widget.assignedTo,
                          numberOfTruck: widget.numberOfTruck,
                          assignedToID: widget.assignedToID,
                          assignedToName: widget.assignedToName,
                          date: widget.date,
                          url: widget.url,
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

class ViewAdminDeliveredConsignment extends StatefulWidget {
  final String consignmentCode,
      price,
      pickUpLocation,
      dropLocation,
      description,
      load,
      currentMinBid,
      assignedTo,
      assignedToID,
      date,
      numberOfTruck,
      assignedToName,
      url,
      truckDetail;
  ViewAdminDeliveredConsignment({
    this.consignmentCode,
    this.price,
    this.load,
    this.truckDetail,
    this.assignedTo,
    this.assignedToID,
    this.date,
    this.numberOfTruck,
    this.assignedToName,
    this.url,
    this.dropLocation,
    this.pickUpLocation,
    this.description,
    this.currentMinBid,
  });
  @override
  _ViewAdminDeliveredConsignmentState createState() =>
      _ViewAdminDeliveredConsignmentState();
}

class _ViewAdminDeliveredConsignmentState
    extends State<ViewAdminDeliveredConsignment> {
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
                  "Consignment ID : ${widget.consignmentCode}",
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
          Container(
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
                    SizedBox(height: size.height * 0.011),
                    Container(
                      padding: EdgeInsets.only(
                        left: size.width * 0.015,
                        right: size.width * 0.015,
                      ),
                      height: size.height * 0.6,
                      width: size.width,
                      child: detailTab(size),
                    )
                  ])))
        ]));
  }

  detailTab(Size size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: size.height * 0.01,
            // bottom: size.height * 0.01,
            left: size.height * 0.01,
            right: size.height * 0.01,
          ),
          width: size.width * 0.25,
          child: Container(
            height: size.height * 0.75,
            width: size.width * 0.25,
            padding: EdgeInsets.only(right: size.height * 0.02),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Text(
                    widget.description,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color(0xff4d4d4d), fontSize: 16),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
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
                            widget.dropLocation,
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
                            widget.load,
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
                        color: MyColors.red,
                        height: 25,
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
                                color: MyColors.primaryNew,
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
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.01,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "Assigned To",
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.w700,
                  //           color: Colors.black,
                  //           fontSize: 10),
                  //     ),
                  //     Text(
                  //       "${widget.assignedTo}",
                  //       style: TextStyle(
                  //           color: Color(0xff4d4d4d),
                  //           fontWeight: FontWeight.w700,
                  //           fontSize: 24),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: size.height * 0.01,
                  // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Assigned To ID",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 10),
                      ),
                      Text(
                        "${widget.assignedToID}",
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Assigned To Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 10),
                      ),
                      Text(
                        "${widget.assignedToName}",
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
                  StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(widget.assignedTo)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          final userData = snapshot.data;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Comapny Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontSize: 10),
                                  ),
                                  Text(
                                    "${userData.data()["companyName"]}",
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Phone Number",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontSize: 10),
                                  ),
                                  Text(
                                    "${userData.data()["phone"]}",
                                    style: TextStyle(
                                        color: Color(0xff4d4d4d),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                        return Container();
                      }),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Uploaded Receipt :",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          // html.window.open(widget.url, "new tab");
                          html.AnchorElement anchorElement =
                              new html.AnchorElement(href: widget.url);
                          anchorElement.download = widget.url;
                          anchorElement.target = "__blank";
                          anchorElement.click();
                        },
                        child: Text(
                          " View",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: MyColors.primaryNew,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
