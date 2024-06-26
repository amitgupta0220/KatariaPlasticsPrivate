import 'dart:ui';
import 'package:KPPL/Views/PrivacyPolicy.dart';
import 'package:KPPL/Views/TermsAndConditions.dart';
import 'package:KPPL/authentication/authenticate.dart';
import 'package:KPPL/onBoarding/OnBoardingScreens.dart';
import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransporterCard extends StatefulWidget {
  final String consignmentCode,
      price,
      pickUpLocation,
      dropLocation,
      description,
      load,
      truckDetail;
  TransporterCard(
      {this.consignmentCode,
      this.price,
      this.load,
      this.truckDetail,
      this.dropLocation,
      this.pickUpLocation,
      this.description});
  @override
  _TransporterCardState createState() => _TransporterCardState();
}

class _TransporterCardState extends State<TransporterCard> {
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
            width: (size.width - size.width * 0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width - size.width * 0.7,
                      child: Row(
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
                    ),
                    // SizedBox(
                    //   height: size.height * 0.01,
                    // ),
                    Container(
                      width: size.width - (size.width * 0.7),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/images/transporterDrop.png",
                            height: 15,
                          ),
                          SizedBox(
                            width: size.width * 0.042,
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
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width - (size.width * 0.7),
                      child: Row(
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
                    ),
                    // SizedBox(
                    //   height: size.height * 0.02,
                    // ),
                    Container(
                      width: size.width - size.width * 0.7,
                      child: Row(
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
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "$price/-",
                    style: TextStyle(
                        color: Color(0xff4d4d4d),
                        fontWeight: FontWeight.w700,
                        fontSize: 13),
                  ),
                  Text(
                    "Opening Bid",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 8),
                  ),
                ],
              ),
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
                                          email
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
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$myBidPrice/-",
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
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          isBidDone
              ? GestureDetector(
                  onTap: () => showAlertDialog(size),
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
                )
              : GestureDetector(
                  onTap: () => showAlertDialog(size),
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
                ),
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
                    left: size.height * 0.02,
                    right: size.height * 0.01,
                  ),
                  width: size.width * 0.65,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "# $code",
                          style: TextStyle(
                              color: MyColors.primaryNew,
                              fontSize: 15,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: size.height * 0.005,
                        ),
                        Text(
                          "Consignment No.",
                          style:
                              TextStyle(color: Color(0xff4d4d4d), fontSize: 8),
                        ),
                        Divider(
                          color: MyColors.primaryNew,
                          thickness: 2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Text(
                                  description,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color(0xff4d4d4d), fontSize: 12),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          pickUp,
                                          style: TextStyle(
                                              color: MyColors.primaryNew,
                                              fontSize: 12,
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
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          drop,
                                          style: TextStyle(
                                              color: MyColors.primaryNew,
                                              fontSize: 12,
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
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
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
                                              color: MyColors.primaryNew,
                                              fontSize: 12,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          truckDetail,
                                          style: TextStyle(
                                              color: MyColors.primaryNew,
                                              fontSize: 12,
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
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "$price/-",
                                      style: TextStyle(
                                          color: Color(0xff4d4d4d),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13),
                                    ),
                                    Text(
                                      "Opening Bid",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 8),
                                    ),
                                  ],
                                ),
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
                                                            email
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
                                isBidDone
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "$myBidPrice/-",
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
                                      )
                                    : Container(),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
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
                                                "currentMinBidByID":
                                                    email //TODO:change id here
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

                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: size.height * 0.065,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
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
                                                "currentMinBidByID":
                                                    email //TODO:change id here
                                              });
                                              FirebaseFirestore.instance
                                                  .collection("consignment")
                                                  .doc(widget.consignmentCode)
                                                  .collection("userBids")
                                                  .doc(email)
                                                  .set({
                                                "bidPrice":
                                                    _bidController.text.trim(),
                                              });
                                              FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(email)
                                                  .collection("myBids")
                                                  .doc(widget.consignmentCode)
                                                  .set({
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
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          height: size.height * 0.065,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
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
              Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    width: 20,
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
                        "assets/images/transporterHome.png",
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
                          "assets/images/transporterBid.png",
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
                        "assets/images/transporterProfile.png",
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
                ListTile(
                  tileColor: widget.selectedTab == 3
                      ? Color(0xfff1f1f1)
                      : Colors.transparent,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/privacyPolicy.png",
                        height: 30,
                        color: MyColors.secondary,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Privacy Policy',
                        style:
                            TextStyle(color: Color(0xff989898), fontSize: 18),
                      ),
                    ],
                  ),
                  onTap: () {
                    widget.onFieldUpdated([3, 0]);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  tileColor: widget.selectedTab == 4
                      ? Color(0xfff1f1f1)
                      : Colors.transparent,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/termsConditions.png",
                          height: 30, color: MyColors.secondary),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Terms and Conditions',
                        style:
                            TextStyle(color: Color(0xff989898), fontSize: 18),
                      ),
                    ],
                  ),
                  onTap: () {
                    widget.onFieldUpdated([4, 0]);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            GestureDetector(
                onTap: () {
                  AuthService().signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => OnBoardingScreens()));
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
