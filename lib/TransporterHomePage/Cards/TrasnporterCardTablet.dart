import 'dart:ui';

import 'package:KPPL/styles.dart';
import 'package:KPPL/widgets/nav_bar/AlertBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TrasnporterCardTablet extends StatefulWidget {
  final String consignmentCode,
      id,
      date,
      numberOfTruck,
      username,
      price,
      pickUpLocation,
      dropLocation,
      description,
      load,
      truckDetail;
  TrasnporterCardTablet(
      {this.consignmentCode,
      this.id,
      this.date,
      this.numberOfTruck,
      this.username,
      this.price,
      this.load,
      this.truckDetail,
      this.dropLocation,
      this.pickUpLocation,
      this.description});
  @override
  _TrasnporterCardTabletState createState() => _TrasnporterCardTabletState();
}

class _TrasnporterCardTabletState extends State<TrasnporterCardTablet> {
  String code, load, truckDetail, drop, pickUp, description, price;
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _bidController = TextEditingController();
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
      margin: EdgeInsets.only(bottom: 8),
      width: size.width - 120,
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
            width: (size.width - 120) / 3,
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
            width: (size.width - 120) / 3,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.fade,
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/transporterPickUp.png",
                        height: 18,
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
                                fontSize: 12,
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
                        height: 18,
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
                                fontSize: 12,
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
                        height: 18,
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
                                fontSize: 12,
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
                        height: 18,
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
                                fontSize: 12,
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
                ],
              ),
            ),
          ),
          Expanded(
            // height: size.height * 0.35,
            // width: size.width / 2.77,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: size.width * 0.015, left: size.width * 0.015),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "# $code",
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
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           "Opening Bid",
                      //           style: TextStyle(
                      //               fontWeight: FontWeight.w700,
                      //               color: Colors.black,
                      //               fontSize: 10),
                      //         ),
                      //         Text(
                      //           "$price/-",
                      //           style: TextStyle(
                      //               color: Color(0xff4d4d4d),
                      //               fontWeight: FontWeight.w700,
                      //               fontSize: 20),
                      //         ),
                      //       ],
                      //     ),
                      //     SizedBox(
                      //       width: size.width * 0.02,
                      //     ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${snapshot.data.data()["currentMinBid"]}/-",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: MyColors.primaryNew,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        snapshot.data.data()[
                                                    "currentMinBidByID"] ==
                                                widget.id
                                            ? "By You"
                                            : "By " +
                                                snapshot.data.data()[
                                                    "currentMinBidByID"],
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Color(0xff666666),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10),
                                      ),
                                    ],
                                  );
                                }
                                return Container();
                              }),

                          // Text(
                          //   "7900/-",
                          //   style: TextStyle(
                          //       color: MyColors.primaryNew,
                          //       fontWeight: FontWeight.w700,
                          //       fontSize: 24),
                          // ),
                        ],
                      ),
                      //   ],
                      // ),
                      isBidDone
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your Bid",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      fontSize: 10),
                                ),
                                Text(
                                  "$myBidPrice/-",
                                  style: TextStyle(
                                      color: MyColors.primaryNew,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
                isBidDone
                    ? StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(email)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var userData = snapshot.data;
                            return GestureDetector(
                              onTap: () {
                                if (userData.data()["verifiedUser"]) {
                                  showAlertDialog(size);
                                } else {
                                  showAlertDialogCustom(context);
                                }
                              },
                              child: Container(
                                height: size.height * 0.065,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(7)),
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
                          if (snapshot.hasData) {
                            var userData = snapshot.data;
                            return GestureDetector(
                              onTap: () {
                                if (userData.data()["verifiedUser"]) {
                                  showAlertDialog(size);
                                } else {
                                  showAlertDialogCustom(context);
                                }
                              },
                              child: Container(
                                height: size.height * 0.065,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(7)),
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
          )
        ],
      ),
    );
  }

  showAlertDialog(Size size) {
    return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black12,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (ctx, anim1, anim2) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: AlertDialog(
          elevation: 15,
          content: Stack(
            children: [
              Container(
                  padding: EdgeInsets.only(
                    top: size.height * 0.01,
                    bottom: size.height * 0.01,
                    left: size.height * 0.05,
                    right: size.height * 0.01,
                  ),
                  width: size.width * 0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "# $code",
                        style: TextStyle(
                            color: MyColors.primaryNew,
                            fontSize: 24,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Text(
                        "Consignment No.",
                        style:
                            TextStyle(color: Color(0xff4d4d4d), fontSize: 12),
                      ),
                      Divider(
                        color: MyColors.primaryNew,
                        thickness: 2,
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Row(
                        children: [
                          Container(
                            height: size.height * 0.65,
                            width: size.width * 0.32,
                            padding: EdgeInsets.only(right: size.height * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.height * 0.05,
                                ),
                                Text(
                                  description,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color(0xff4d4d4d), fontSize: 16),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          pickUp,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          drop,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          load,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          truckDetail,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.numberOfTruck,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateTime.fromMillisecondsSinceEpoch(
                                                  double.parse(widget.date)
                                                      .toInt())
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
                          Container(
                            margin: EdgeInsets.only(top: size.height * 0.05),
                            color: Color.fromRGBO(230, 230, 230, 0.6),
                            width: 3,
                            height: size.height * 0.63,
                          ),
                          Expanded(
                            child: Container(
                              height: size.height * 0.65,
                              width: size.width * 0.32,
                              padding: EdgeInsets.only(
                                left: size.height * 0.02,
                                top: size.height * 0.05,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Column(
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              .doc(code)
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
                                                    "${snapshot.data.data()["currentMinBid"]}/-",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color:
                                                            MyColors.primaryNew,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 20),
                                                  ),
                                                  Text(
                                                    snapshot.data.data()[
                                                                "currentMinBidByID"] ==
                                                            widget.id
                                                        ? "By You"
                                                        : "By " +
                                                            snapshot.data
                                                                    .data()[
                                                                "currentMinBidByID"],
                                                    textAlign: TextAlign.left,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff666666),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              );
                                            }
                                            return Container();
                                          }),
                                    ],
                                  ),
                                  //     SizedBox(
                                  //       height: size.height * 0.02,
                                  //     ),
                                  //     Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.start,
                                  //       children: [
                                  //         Text(
                                  //           "Opening Bid",
                                  //           style: TextStyle(
                                  //               fontWeight: FontWeight.w700,
                                  //               color: Colors.black,
                                  //               fontSize: 10),
                                  //         ),
                                  //         Text(
                                  //           "$price/-",
                                  //           style: TextStyle(
                                  //               color: Color(0xff4d4d4d),
                                  //               fontWeight: FontWeight.w700,
                                  //               fontSize: 20),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                  isBidDone
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Your Bid",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              "$myBidPrice/-",
                                              style: TextStyle(
                                                  color: MyColors.primaryNew,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  Column(
                                    children: [
                                      TextFormField(
                                        style: TextStyle(fontSize: 15),
                                        controller: _bidController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            filled: true,
                                            hoverColor: Colors.transparent,
                                            fillColor: Colors.white,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: MyColors.secondaryNew),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xffB3B3B3)),
                                            // hintText: 'abc@def.com',
                                            labelText: "Enter Amount"),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.05,
                                      ),
                                      isBidDone
                                          ? GestureDetector(
                                              onTap: () {
                                                if (_bidController
                                                    .text.isNotEmpty) {
                                                  if (double.parse(
                                                          _bidController
                                                              .text) >=
                                                      double.parse(
                                                          currentMinBid)) {
                                                    ScaffoldMessenger.of(
                                                            context)
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
                                                                      .circular(
                                                                          5),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5))),
                                                    ));
                                                  } else {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            "consignment")
                                                        .doc(widget
                                                            .consignmentCode)
                                                        .update({
                                                      "currentMinBid":
                                                          _bidController.text
                                                              .trim(),
                                                      "currentMinBidBy": email,
                                                      "currentMinBidByID":
                                                          widget.id
                                                    });
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            "consignment")
                                                        .doc(widget
                                                            .consignmentCode)
                                                        .collection("userBids")
                                                        .doc(email)
                                                        .update({
                                                      "bidPrice": _bidController
                                                          .text
                                                          .trim(),
                                                    });
                                                    FirebaseFirestore.instance
                                                        .collection("users")
                                                        .doc(email)
                                                        .collection("myBids")
                                                        .doc(widget
                                                            .consignmentCode)
                                                        .update({
                                                      "bidPrice": _bidController
                                                          .text
                                                          .trim(),
                                                      "date": DateTime.now()
                                                          .millisecondsSinceEpoch
                                                          .toString(),
                                                    });
                                                    setState(() {
                                                      myBidPrice =
                                                          _bidController.text;
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
                                                    duration: Duration(
                                                        milliseconds: 1500),
                                                    backgroundColor:
                                                        MyColors.primary,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        5),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        5))),
                                                  ));
                                                }

                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: size.height * 0.065,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
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
                                                if (_bidController
                                                    .text.isNotEmpty) {
                                                  if (double.parse(
                                                          _bidController.text) >
                                                      double.parse(
                                                          currentMinBid)) {
                                                    ScaffoldMessenger.of(
                                                            context)
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
                                                                      .circular(
                                                                          5),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5))),
                                                    ));
                                                  } else {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            "consignment")
                                                        .doc(widget
                                                            .consignmentCode)
                                                        .update({
                                                      "currentMinBid":
                                                          _bidController.text
                                                              .trim(),
                                                      "currentMinBidBy": email,
                                                      "currentMinBidByID":
                                                          widget.id
                                                    });
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            "consignment")
                                                        .doc(widget
                                                            .consignmentCode)
                                                        .collection("userBids")
                                                        .doc(email)
                                                        .set({
                                                      "bidPrice": _bidController
                                                          .text
                                                          .trim(),
                                                      "id": widget.id,
                                                      "username":
                                                          widget.username,
                                                    });
                                                    FirebaseFirestore.instance
                                                        .collection("users")
                                                        .doc(email)
                                                        .collection("myBids")
                                                        .doc(widget
                                                            .consignmentCode)
                                                        .set({
                                                      "id": widget.id,
                                                      "username":
                                                          widget.username,
                                                      "description":
                                                          widget.description,
                                                      "truckDetail":
                                                          widget.truckDetail,
                                                      "load": widget.load,
                                                      "price": widget.price,
                                                      "bidPrice": _bidController
                                                          .text
                                                          .trim(),
                                                      "pickUpLocation":
                                                          widget.pickUpLocation,
                                                      "dropLocation":
                                                          widget.dropLocation,
                                                      "date": DateTime.now()
                                                          .millisecondsSinceEpoch
                                                          .toString(),
                                                    });
                                                    getIsBidDone();
                                                    setState(() {
                                                      myBidPrice =
                                                          _bidController.text;
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
                                                    duration: Duration(
                                                        milliseconds: 1500),
                                                    backgroundColor:
                                                        MyColors.primary,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        5),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        5))),
                                                  ));
                                                }
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                height: size.height * 0.065,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
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
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
              Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    width: 50,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                    decoration: BoxDecoration(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter:
            ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(
          child: child,
          opacity: anim1,
        ),
      ),
      context: context,
    );
  }
}
