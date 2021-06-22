import 'dart:ui';

import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransporterCardMobile extends StatefulWidget {
  final String consignmentCode,
      username,
      id,
      numberOfTruck,
      price,
      pickUpLocation,
      date,
      dropLocation,
      description,
      load,
      truckDetail;
  TransporterCardMobile(
      {this.consignmentCode,
      this.id,
      this.username,
      this.numberOfTruck,
      this.price,
      this.load,
      this.date,
      this.truckDetail,
      this.dropLocation,
      this.pickUpLocation,
      this.description});
  @override
  _TransporterCardMobileState createState() => _TransporterCardMobileState();
}

class _TransporterCardMobileState extends State<TransporterCardMobile> {
  String code, load, truckDetail, drop, pickUp, description, price;
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String email, myBidPrice = "", currentMinBid;
  bool isBidDone = false;

  getIsBidDone() async {
    await FirebaseFirestore.instance
        .collection("consignment")
        .doc(widget.consignmentCode)
        .collection("userBids")
        .doc(email)
        .get()
        .then((value) {
      isBidDone = value.exists;
      if (value.exists) {
        myBidPrice = value.data()["bidPrice"];
      }
    });
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser.email;
    getIsBidDone();
    code = widget.consignmentCode;
    load = widget.load;
    truckDetail = widget.truckDetail;
    drop = widget.dropLocation;
    pickUp = widget.pickUpLocation;
    description = widget.description;
    price = widget.price;
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: size.width * 0.02),
      width: size.width - 120,
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
            height: size.height * 0.2,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   description,
                //   textAlign: TextAlign.left,
                //   overflow: TextOverflow.fade,
                //   style: TextStyle(color: Colors.black, fontSize: 12),
                // ),
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
                              pickUp,
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
                              drop,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/trasnporterLoad.png",
                          height: 15,
                        ),
                        SizedBox(
                          width: size.width * 0.024,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              load,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Load",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 8,
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
                              truckDetail,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Truck Details",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: isBidDone
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Text(
              //       "$price/-",
              //       style: TextStyle(
              //           color: Color(0xff4d4d4d),
              //           fontWeight: FontWeight.w700,
              //           fontSize: 13),
              //     ),
              //     Text(
              //       "Opening Bid",
              //       style: TextStyle(
              //           fontWeight: FontWeight.w700,
              //           color: Colors.black,
              //           fontSize: 8),
              //     ),
              //   ],
              // ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("consignment")
                            .doc(code)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: Container());
                          }
                          if (snapshot.hasData) {
                            currentMinBid =
                                snapshot.data.data()["currentMinBid"];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  snapshot.data.data()["currentMinBidByID"] ==
                                          widget.id
                                      ? "By You"
                                      : "By " +
                                          snapshot.data
                                              .data()["currentMinBidByID"],
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Color(0xff666666),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 8),
                                ),
                                Text(
                                  "${snapshot.data.data()["currentMinBid"]}/-",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: MyColors.primaryNew,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13),
                                ),
                              ],
                            );
                          }
                          return Container();
                        }),
                    Text(
                      "Minimum Bid (L1)",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 8),
                    ),
                  ]),
              isBidDone
                  ? StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(email)
                          .collection("myBids")
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
                                "${snapshot.data.data()["bidPrice"]}/-",
                                style: TextStyle(
                                    color: MyColors.primaryNew,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13),
                              ),
                              Text(
                                "Your Bid",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontSize: 8),
                              ),
                            ],
                          );
                        }
                        return Container();
                      })
                  : Container(),
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          isBidDone
              ? StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      final userData = snapshot.data;
                      return GestureDetector(
                        onTap: () {
                          if (userData.data()["verifiedUser"] == true) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => DisplayDetailsCard(
                                      onClick: onClick,
                                      username: widget.username,
                                      isBidDone: isBidDone,
                                      id: widget.id,
                                      truckDetail: truckDetail,
                                      price: price,
                                      load: load,
                                      description: description,
                                      consignmentCode: widget.consignmentCode,
                                      pickUpLocation: widget.pickUpLocation,
                                      dropLocation: widget.dropLocation,
                                      numberOfTruck: widget.numberOfTruck,
                                      date: widget.date,
                                      myBidPrice: myBidPrice,
                                    )));
                          } else {
                            showAlertDialog(context);
                          }
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
                            child: Text("Modify Bid",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),
                      );
                    }
                    return Container();
                  })
              : StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      final userData = snapshot.data;
                      return GestureDetector(
                        onTap: () {
                          if (userData.data()["verifiedUser"] == true) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => DisplayDetailsCard(
                                      onClick: onClick,
                                      myBidPrice: myBidPrice,
                                      isBidDone: isBidDone,
                                      username: widget.username,
                                      id: widget.id,
                                      truckDetail: truckDetail,
                                      date: widget.date,
                                      numberOfTruck: widget.numberOfTruck,
                                      price: price,
                                      load: load,
                                      description: description,
                                      consignmentCode: widget.consignmentCode,
                                      pickUpLocation: widget.pickUpLocation,
                                      dropLocation: widget.dropLocation,
                                    )));
                          } else {
                            showAlertDialog(context);
                          }
                        },
                        child: Container(
                          height: size.height * 0.065,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(7),
                                bottomLeft: Radius.circular(7),
                              ),
                              color: MyColors.green),
                          child: Center(
                            child: Text("Bid",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),
                      );
                    }
                    return Container();
                  })
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Attention"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              "Your account is pending approval. Once approved you will be able to Bid."),
          SizedBox(height: 20),
          Text(
              "आपका खाता अनुमोदन के लिए लंबित हैं। स्वीकृति मिलते ही आप बोली लगा सकेंगे।"),
        ],
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  onClick(String a) {
    setState(() {
      myBidPrice = a;
      isBidDone = true;
      getIsBidDone();
    });
  }
}

class DisplayDetailsCard extends StatefulWidget {
  final ValueChanged<String> onClick;
  final String consignmentCode,
      username,
      id,
      price,
      pickUpLocation,
      dropLocation,
      myBidPrice,
      description,
      numberOfTruck,
      load,
      date,
      truckDetail;
  final bool isBidDone;
  DisplayDetailsCard({
    this.consignmentCode,
    this.id,
    this.username,
    this.price,
    this.date,
    this.isBidDone,
    this.load,
    this.truckDetail,
    this.dropLocation,
    this.numberOfTruck,
    this.pickUpLocation,
    this.myBidPrice,
    this.description,
    @required this.onClick,
  });
  @override
  _DisplayDetailsCardState createState() => _DisplayDetailsCardState();
}

class _DisplayDetailsCardState extends State<DisplayDetailsCard> {
  String code,
      email,
      load,
      truckDetail,
      drop,
      pickUp,
      description,
      price,
      currentMinBid,
      myBidPrice;
  final _bidController = TextEditingController();

  @override
  void initState() {
    email = FirebaseAuth.instance.currentUser.email;
    super.initState();
    code = widget.consignmentCode;
    load = widget.load;
    truckDetail = widget.truckDetail;
    drop = widget.dropLocation;
    pickUp = widget.pickUpLocation;
    description = widget.description;
    price = widget.price;
    myBidPrice = widget.myBidPrice;
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.backgroundNewPage,
        elevation: 0,
        iconTheme: IconThemeData(color: MyColors.primary),
        title: Row(
          children: [
            Text(
              "Consignment No.",
              style: TextStyle(color: Color(0xff4d4d4d), fontSize: 15),
            ),
            SizedBox(
              width: size.width * 0.01,
            ),
            Text(
              "# $code",
              style: TextStyle(
                  color: MyColors.primaryNew,
                  fontSize: 15,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
      backgroundColor: MyColors.backgroundNewPage,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Column(
          children: [
            Container(
              height: size.height * 0.27,
              // width: (size.width - 120),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      "https://st.depositphotos.com/2683099/3278/i/600/depositphotos_32782991-stock-photo-modern-warehouse.jpg",
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(
                    left: size.height * 0.05,
                    right: size.height * 0.05,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // height: size.height * 0.35,
                              width: size.width - 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.015,
                                  ),
                                  Text(
                                    description,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.015,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                pickUp,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                "Pickup Location",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: size.height * 0.01,
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/images/transporterDrop.png",
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.027,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                drop,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                "Drop Location",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w400),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/trasnporterLoad.png",
                                            height: 15,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.024,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                load,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                "Load",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/images/transporterTruck.png",
                                            height: 15,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.015,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                truckDetail,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                "Truck Details",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today_outlined,
                                            color: MyColors.red,
                                            size: 15,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.024,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                DateTime.fromMillisecondsSinceEpoch(
                                                        double.parse(
                                                                widget.date)
                                                            .toInt())
                                                    .toString()
                                                    .split(" ")[0],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                "Date",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/images/transporterTruck.png",
                                            height: 15,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.015,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.numberOfTruck,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                "Total number\nof Truck",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment:
                                  myBidPrice == null || myBidPrice == ""
                                      ? MainAxisAlignment.center
                                      : MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Column(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [
                                //     Text(
                                //       "$price/-",
                                //       style: TextStyle(
                                //           color: Color(0xff4d4d4d),
                                //           fontWeight: FontWeight.w700,
                                //           fontSize: 13),
                                //     ),
                                //     Text(
                                //       "Opening Bid",
                                //       style: TextStyle(
                                //           fontWeight: FontWeight.w700,
                                //           color: Colors.black,
                                //           fontSize: 8),
                                //     ),
                                //   ],
                                // ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      StreamBuilder<DocumentSnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection("consignment")
                                              .doc(code)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(child: Container());
                                            }
                                            if (snapshot.hasData) {
                                              currentMinBid = snapshot.data
                                                  .data()["currentMinBid"];
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    snapshot.data.data()[
                                                                "currentMinBidByID"] ==
                                                            widget.id
                                                        ? "By You"
                                                        : "By " +
                                                            snapshot.data
                                                                    .data()[
                                                                "currentMinBidByID"],
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff666666),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 8),
                                                  ),
                                                  Text(
                                                    "${snapshot.data.data()["currentMinBid"]}/-",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color:
                                                            MyColors.primaryNew,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 13),
                                                  ),
                                                ],
                                              );
                                            }
                                            return Container();
                                          }),
                                      Text(
                                        "Minimum Bid (L1)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                            fontSize: 8),
                                      ),
                                    ]),
                                widget.isBidDone
                                    ? StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(email)
                                            .collection("myBids")
                                            .doc(widget.consignmentCode)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(child: Container());
                                          }
                                          if (snapshot.hasData) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${snapshot.data.data()["bidPrice"]}/-",
                                                  style: TextStyle(
                                                      color:
                                                          MyColors.primaryNew,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 13),
                                                ),
                                                Text(
                                                  "Your Bid",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black,
                                                      fontSize: 8),
                                                ),
                                              ],
                                            );
                                          }
                                          return Container();
                                        })
                                    : Container(),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 55,
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 11),
                                    controller: _bidController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        filled: true,
                                        hoverColor: Colors.transparent,
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: MyColors.secondaryNew),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: MyColors.secondaryNew),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xffB3B3B3)),
                                        // hintText: 'abc@def.com',
                                        hintText: "Enter Amount"),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.05,
                                ),
                                widget.isBidDone
                                    ? GestureDetector(
                                        onTap: () {
                                          if (_bidController.text.isNotEmpty) {
                                            if (double.parse(
                                                    _bidController.text) >=
                                                double.parse(currentMinBid)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  "Enter bid value less than current bid",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Lato'),
                                                ),
                                                elevation: 0,
                                                duration: Duration(
                                                    milliseconds: 1500),
                                                backgroundColor:
                                                    MyColors.primary,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(5),
                                                            topLeft:
                                                                Radius.circular(
                                                                    5))),
                                              ));
                                            } else {
                                              FirebaseFirestore.instance
                                                  .collection("consignment")
                                                  .doc(widget.consignmentCode)
                                                  .update({
                                                "currentMinBid":
                                                    _bidController.text.trim(),
                                                "currentMinBidBy": email,
                                                "currentMinBidByID": widget.id
                                              });
                                              FirebaseFirestore.instance
                                                  .collection("consignment")
                                                  .doc(widget.consignmentCode)
                                                  .collection("userBids")
                                                  .doc(email)
                                                  .update({
                                                "bidPrice":
                                                    _bidController.text.trim(),
                                              });
                                              FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(email)
                                                  .collection("myBids")
                                                  .doc(widget.consignmentCode)
                                                  .update({
                                                "bidPrice":
                                                    _bidController.text.trim(),
                                                "date": DateTime.now()
                                                    .millisecondsSinceEpoch
                                                    .toString(),
                                              });
                                              setState(() {
                                                widget.onClick(
                                                    _bidController.text.trim());
                                                _bidController.clear();
                                              });
                                            }

                                            // Navigator.of(context).pop();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                "No value entered",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Lato'),
                                              ),
                                              elevation: 0,
                                              duration:
                                                  Duration(milliseconds: 1500),
                                              backgroundColor: MyColors.primary,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  5),
                                                          topLeft:
                                                              Radius.circular(
                                                                  5))),
                                            ));
                                          }
                                          setState(() {
                                            _bidController.clear();
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: size.height * 0.065,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: MyColors.green),
                                          child: Center(
                                            child: Text("Modify Bid",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          if (_bidController.text.isNotEmpty) {
                                            if (double.parse(
                                                    _bidController.text) >
                                                double.parse(currentMinBid)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  "Enter bid value less than current bid",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Lato'),
                                                ),
                                                elevation: 0,
                                                duration: Duration(
                                                    milliseconds: 1500),
                                                backgroundColor:
                                                    MyColors.primary,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(5),
                                                            topLeft:
                                                                Radius.circular(
                                                                    5))),
                                              ));
                                            } else {
                                              FirebaseFirestore.instance
                                                  .collection("consignment")
                                                  .doc(widget.consignmentCode)
                                                  .update({
                                                "currentMinBid":
                                                    _bidController.text.trim(),
                                                "currentMinBidBy": email,
                                                "currentMinBidByID": widget.id
                                              });
                                              FirebaseFirestore.instance
                                                  .collection("consignment")
                                                  .doc(widget.consignmentCode)
                                                  .collection("userBids")
                                                  .doc(email)
                                                  .set({
                                                "bidPrice":
                                                    _bidController.text.trim(),
                                                "id": widget.id,
                                                "username": widget.username,
                                              });
                                              FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(email)
                                                  .collection("myBids")
                                                  .doc(widget.consignmentCode)
                                                  .set({
                                                "id": widget.id,
                                                "username": widget.username,
                                                "description":
                                                    widget.description,
                                                "truckDetail":
                                                    widget.truckDetail,
                                                "load": widget.load,
                                                "price": widget.price,
                                                "bidPrice":
                                                    _bidController.text.trim(),
                                                "pickUpLocation":
                                                    widget.pickUpLocation,
                                                "dropLocation":
                                                    widget.dropLocation,
                                                "date": DateTime.now()
                                                    .millisecondsSinceEpoch
                                                    .toString(),
                                              });
                                              setState(() {
                                                widget.onClick(
                                                    _bidController.text.trim());
                                                _bidController.clear();
                                                // myBidPrice =
                                                //     _bidController.text.trim();
                                              });
                                            }

                                            _bidController.clear();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                "No value entered",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Lato'),
                                              ),
                                              elevation: 0,
                                              duration:
                                                  Duration(milliseconds: 1500),
                                              backgroundColor: MyColors.primary,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  5),
                                                          topLeft:
                                                              Radius.circular(
                                                                  5))),
                                            ));
                                          }
                                          setState(() {
                                            _bidController.clear();
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          height: size.height * 0.065,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: MyColors.green),
                                          child: Center(
                                            child: Text("Bid",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                        ),
                                      )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

// showAlertDialog(Size size) {
//   return showGeneralDialog(
//     barrierDismissible: true,
//     barrierLabel: '',
//     barrierColor: Colors.black12,
//     transitionDuration: Duration(milliseconds: 200),
//     pageBuilder: (ctx, anim1, anim2) => GestureDetector(
//       onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
//       child: AlertDialog(
//         elevation: 15,
//         content: Stack(
//           children: [
//             Container(
//                 padding: EdgeInsets.only(
//                   top: size.height * 0.01,
//                   bottom: size.height * 0.01,
//                   // left: size.height * 0.02,
//                   // right: size.height * 0.01,
//                 ),
//                 // width: size.width * 0.85,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         "# $code",
//                         style: TextStyle(
//                             color: MyColors.primaryNew,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w900),
//                       ),
//                       SizedBox(
//                         height: size.height * 0.005,
//                       ),
//                       Text(
//                         "Consignment No.",
//                         style:
//                             TextStyle(color: Color(0xff4d4d4d), fontSize: 8),
//                       ),
//                       Divider(
//                         color: MyColors.primaryNew,
//                         thickness: 2,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height: size.height * 0.01,
//                               ),
//                               Text(
//                                 description,
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                     color: Color(0xff4d4d4d), fontSize: 12),
//                               ),
//                               SizedBox(
//                                 height: size.height * 0.01,
//                               ),
//                               Row(
//                                 children: [
//                                   Image.asset(
//                                     "assets/images/transporterPickUp.png",
//                                     height: 15,
//                                   ),
//                                   SizedBox(
//                                     width: size.width * 0.023,
//                                   ),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         pickUp,
//                                         style: TextStyle(
//                                             color: MyColors.primaryNew,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w700),
//                                       ),
//                                       Text(
//                                         "Pickup Location",
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 8,
//                                             fontWeight: FontWeight.w400),
//                                       )
//                                     ],
//                                   )
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: size.height * 0.01,
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Image.asset(
//                                     "assets/images/transporterDrop.png",
//                                     height: 15,
//                                   ),
//                                   SizedBox(
//                                     width: size.width * 0.027,
//                                   ),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         drop,
//                                         style: TextStyle(
//                                             color: MyColors.primaryNew,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w700),
//                                       ),
//                                       Text(
//                                         "Drop Location",
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 8,
//                                             fontWeight: FontWeight.w400),
//                                       )
//                                     ],
//                                   )
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: size.height * 0.01,
//                               ),
//                               Row(
//                                 children: [
//                                   Image.asset(
//                                     "assets/images/trasnporterLoad.png",
//                                     height: 15,
//                                   ),
//                                   SizedBox(
//                                     width: size.width * 0.024,
//                                   ),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         load,
//                                         style: TextStyle(
//                                             color: MyColors.primaryNew,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w700),
//                                       ),
//                                       Text(
//                                         "Load",
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 8,
//                                             fontWeight: FontWeight.w400),
//                                       )
//                                     ],
//                                   )
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: size.height * 0.01,
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Image.asset(
//                                     "assets/images/transporterTruck.png",
//                                     height: 15,
//                                   ),
//                                   SizedBox(
//                                     width: size.width * 0.015,
//                                   ),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         truckDetail,
//                                         style: TextStyle(
//                                             color: MyColors.primaryNew,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w700),
//                                       ),
//                                       Text(
//                                         "Truck Details",
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 8,
//                                             fontWeight: FontWeight.w400),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: size.height * 0.02,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "$price/-",
//                                     style: TextStyle(
//                                         color: Color(0xff4d4d4d),
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 13),
//                                   ),
//                                   Text(
//                                     "Opening Bid",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w700,
//                                         color: Colors.black,
//                                         fontSize: 8),
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     StreamBuilder<DocumentSnapshot>(
//                                         stream: FirebaseFirestore.instance
//                                             .collection("consignment")
//                                             .doc(code)
//                                             .snapshots(),
//                                         builder: (context, snapshot) {
//                                           if (snapshot.connectionState ==
//                                               ConnectionState.waiting) {
//                                             return Center(child: Container());
//                                           }
//                                           if (snapshot.hasData) {
//                                             currentMinBid = snapshot.data
//                                                 .data()["currentMinBid"];
//                                             return Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.end,
//                                               children: [
//                                                 Text(
//                                                   snapshot.data.data()[
//                                                               "currentMinBidByID"] ==
//                                                           widget.id
//                                                       ? "By You"
//                                                       : "By " +
//                                                           snapshot.data
//                                                                   .data()[
//                                                               "currentMinBidByID"],
//                                                   textAlign: TextAlign.center,
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   style: TextStyle(
//                                                       color:
//                                                           Color(0xff666666),
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       fontSize: 8),
//                                                 ),
//                                                 Text(
//                                                   "${snapshot.data.data()["currentMinBid"]}/-",
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color:
//                                                           MyColors.primaryNew,
//                                                       fontWeight:
//                                                           FontWeight.w700,
//                                                       fontSize: 13),
//                                                 ),
//                                               ],
//                                             );
//                                           }
//                                           return Container();
//                                         }),
//                                     Text(
//                                       "Minimum Bid (L1)",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w700,
//                                           color: Colors.black,
//                                           fontSize: 8),
//                                     ),
//                                   ]),
//                               isBidDone
//                                   ? Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "$myBidPrice/-",
//                                           style: TextStyle(
//                                               color: MyColors.primaryNew,
//                                               fontWeight: FontWeight.w700,
//                                               fontSize: 13),
//                                         ),
//                                         Text(
//                                           "Your Bid",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w700,
//                                               color: Colors.black,
//                                               fontSize: 8),
//                                         ),
//                                       ],
//                                     )
//                                   : Container(),
//                             ],
//                           ),
//                           SizedBox(
//                             height: size.height * 0.02,
//                           ),
//                           Column(
//                             children: [
//                               Container(
//                                 height: 60,
//                                 child: TextFormField(
//                                   style: TextStyle(fontSize: 15),
//                                   controller: _bidController,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                       filled: true,
//                                       hoverColor: Colors.transparent,
//                                       fillColor: Colors.white,
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             width: 1,
//                                             color: MyColors.secondaryNew),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             width: 1,
//                                             color: MyColors.secondaryNew),
//                                       ),
//                                       border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(4)),
//                                       hintStyle: TextStyle(
//                                           fontSize: 16,
//                                           color: Color(0xffB3B3B3)),
//                                       // hintText: 'abc@def.com',
//                                       hintText: "Enter Amount"),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: size.height * 0.05,
//                               ),
//                               isBidDone
//                                   ? GestureDetector(
//                                       onTap: () {
//                                         if (_bidController.text.isNotEmpty) {
//                                           if (double.parse(
//                                                   _bidController.text) >=
//                                               double.parse(currentMinBid)) {
//                                             ScaffoldMessenger.of(context)
//                                                 .showSnackBar(SnackBar(
//                                               content: Text(
//                                                 "Enter bid value less than current bid",
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontFamily: 'Lato'),
//                                               ),
//                                               elevation: 0,
//                                               duration: Duration(
//                                                   milliseconds: 1500),
//                                               backgroundColor:
//                                                   MyColors.primary,
//                                               shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                           topRight: Radius
//                                                               .circular(5),
//                                                           topLeft:
//                                                               Radius.circular(
//                                                                   5))),
//                                             ));
//                                           } else {
//                                             FirebaseFirestore.instance
//                                                 .collection("consignment")
//                                                 .doc(widget.consignmentCode)
//                                                 .update({
//                                               "currentMinBid":
//                                                   _bidController.text.trim(),
//                                               "currentMinBidBy": email,
//                                               "currentMinBidByID": widget.id
//                                             });
//                                             FirebaseFirestore.instance
//                                                 .collection("consignment")
//                                                 .doc(widget.consignmentCode)
//                                                 .collection("userBids")
//                                                 .doc(email)
//                                                 .update({
//                                               "bidPrice":
//                                                   _bidController.text.trim(),
//                                             });
//                                             FirebaseFirestore.instance
//                                                 .collection("users")
//                                                 .doc(email)
//                                                 .collection("myBids")
//                                                 .doc(widget.consignmentCode)
//                                                 .update({
//                                               "bidPrice":
//                                                   _bidController.text.trim(),
//                                               "date": DateTime.now()
//                                                   .millisecondsSinceEpoch
//                                                   .toString(),
//                                             });
//                                             setState(() {
//                                               myBidPrice =
//                                                   _bidController.text;
//                                             });
//                                           }
//                                           _bidController.clear();
//                                           // Navigator.of(context).pop();
//                                         } else {
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(SnackBar(
//                                             content: Text(
//                                               "No value entered",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontFamily: 'Lato'),
//                                             ),
//                                             elevation: 0,
//                                             duration:
//                                                 Duration(milliseconds: 1500),
//                                             backgroundColor: MyColors.primary,
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.only(
//                                                         topRight:
//                                                             Radius.circular(
//                                                                 5),
//                                                         topLeft:
//                                                             Radius.circular(
//                                                                 5))),
//                                           ));
//                                         }

//                                         Navigator.pop(context);
//                                       },
//                                       child: Container(
//                                         height: size.height * 0.065,
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(7),
//                                             color: MyColors.green),
//                                         child: Center(
//                                           child: Text("Modify Bid",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 18,
//                                                   fontWeight:
//                                                       FontWeight.w700)),
//                                         ),
//                                       ),
//                                     )
//                                   : GestureDetector(
//                                       onTap: () {
//                                         if (_bidController.text.isNotEmpty) {
//                                           if (double.parse(
//                                                   _bidController.text) >
//                                               double.parse(currentMinBid)) {
//                                             ScaffoldMessenger.of(context)
//                                                 .showSnackBar(SnackBar(
//                                               content: Text(
//                                                 "Enter bid value less than current bid",
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontFamily: 'Lato'),
//                                               ),
//                                               elevation: 0,
//                                               duration: Duration(
//                                                   milliseconds: 1500),
//                                               backgroundColor:
//                                                   MyColors.primary,
//                                               shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                           topRight: Radius
//                                                               .circular(5),
//                                                           topLeft:
//                                                               Radius.circular(
//                                                                   5))),
//                                             ));
//                                           } else {
//                                             FirebaseFirestore.instance
//                                                 .collection("consignment")
//                                                 .doc(widget.consignmentCode)
//                                                 .update({
//                                               "currentMinBid":
//                                                   _bidController.text.trim(),
//                                               "currentMinBidBy": email,
//                                               "currentMinBidByID": widget.id
//                                             });
//                                             FirebaseFirestore.instance
//                                                 .collection("consignment")
//                                                 .doc(widget.consignmentCode)
//                                                 .collection("userBids")
//                                                 .doc(email)
//                                                 .set({
//                                               "bidPrice":
//                                                   _bidController.text.trim(),
//                                               "id": widget.id,
//                                               "username": widget.username,
//                                             });
//                                             FirebaseFirestore.instance
//                                                 .collection("users")
//                                                 .doc(email)
//                                                 .collection("myBids")
//                                                 .doc(widget.consignmentCode)
//                                                 .set({
//                                               "id": widget.id,
//                                               "username": widget.username,
//                                               "description":
//                                                   widget.description,
//                                               "truckDetail":
//                                                   widget.truckDetail,
//                                               "load": widget.load,
//                                               "price": widget.price,
//                                               "bidPrice":
//                                                   _bidController.text.trim(),
//                                               "pickUpLocation":
//                                                   widget.pickUpLocation,
//                                               "dropLocation":
//                                                   widget.dropLocation,
//                                               "date": DateTime.now()
//                                                   .millisecondsSinceEpoch
//                                                   .toString(),
//                                             });
//                                             getIsBidDone();
//                                             setState(() {
//                                               myBidPrice =
//                                                   _bidController.text;
//                                             });
//                                           }

//                                           _bidController.clear();
//                                         } else {
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(SnackBar(
//                                             content: Text(
//                                               "No value entered",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontFamily: 'Lato'),
//                                             ),
//                                             elevation: 0,
//                                             duration:
//                                                 Duration(milliseconds: 1500),
//                                             backgroundColor: MyColors.primary,
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.only(
//                                                         topRight:
//                                                             Radius.circular(
//                                                                 5),
//                                                         topLeft:
//                                                             Radius.circular(
//                                                                 5))),
//                                           ));
//                                         }
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: Container(
//                                         height: size.height * 0.065,
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(3),
//                                             color: MyColors.green),
//                                         child: Center(
//                                           child: Text("Bid",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 18,
//                                                   fontWeight:
//                                                       FontWeight.w700)),
//                                         ),
//                                       ),
//                                     )
//                             ],
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 )),
//             Positioned(
//                 top: 0,
//                 right: 0,
//                 child: Container(
//                   height: 20,
//                   width: 20,
//                   child: InkWell(
//                     onTap: () => Navigator.of(context).pop(),
//                     child: Icon(
//                       Icons.close,
//                       color: Colors.black,
//                     ),
//                   ),
//                   decoration: BoxDecoration(color: Colors.white),
//                 )),
//           ],
//         ),
//       ),
//     ),
//     transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
//       filter:
//           ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
//       child: FadeTransition(
//         child: child,
//         opacity: anim1,
//       ),
//     ),
//     context: context,
//   );
// }
