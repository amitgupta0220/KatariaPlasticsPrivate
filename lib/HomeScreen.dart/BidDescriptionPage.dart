import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BidDescriptionPage extends StatefulWidget {
  final String consignmentCode,
      pickUpLocation,
      dropLocation,
      description,
      truckDetail,
      load;
  BidDescriptionPage(
      {this.consignmentCode,
      this.dropLocation,
      this.load,
      this.truckDetail,
      this.pickUpLocation,
      this.description});
  @override
  _BidDescriptionPageState createState() => _BidDescriptionPageState();
}

class _BidDescriptionPageState extends State<BidDescriptionPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _bidController = TextEditingController();
  String email, myBidPrice = "", currentMinBid;
  bool isBidDone = false;
  @override
  void initState() {
    email = FirebaseAuth.instance.currentUser.email;
    super.initState();
    getIsBidDone();
  }

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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MyColors.backgroundNew,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.02,
            // ),
            Stack(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Image.network(
                      "https://st.depositphotos.com/2683099/3278/i/600/depositphotos_32782991-stock-photo-modern-warehouse.jpg",
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    )),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.04,
                  left: MediaQuery.of(context).size.height * 0.02,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: MyColors.primary,
                      )),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.02,
                top: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Text(
                "Description",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: MyColors.primary),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.02,
                top: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Text(
                widget.description,
                style: TextStyle(fontSize: 14, color: MyColors.primary),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  left: MediaQuery.of(context).size.height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.gps_fixed_outlined,
                        color: MyColors.primary,
                        size: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text(
                        "Pickup Location : ${widget.pickUpLocation}",
                        style: TextStyle(color: MyColors.primary, fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: MyColors.primary,
                        size: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text(
                        "Drop Location : ${widget.dropLocation}",
                        style: TextStyle(color: MyColors.primary, fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.car_repair,
                        color: MyColors.primary,
                        size: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text(
                        "Truck Details : ${widget.truckDetail}",
                        style: TextStyle(color: MyColors.primary, fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.loyalty_rounded,
                        color: MyColors.primary,
                        size: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text(
                        "Load : ${widget.load}",
                        style: TextStyle(color: MyColors.primary, fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.03,
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
                          currentMinBid = snapshot.data.data()["currentMinBid"];
                          return Container(
                            margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.02,
                              left: MediaQuery.of(context).size.width * 0.02,
                            ),
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width,
                                  height: size.height * 0.07,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text("Minimum Bid By",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: MyColors.primary)),
                                          Text(snapshot.data.data()[
                                                      "currentMinBidByID"] ==
                                                  email
                                              ? "You"
                                              : snapshot.data
                                                  .data()["currentMinBidByID"]),
                                        ],
                                      ),
                                      VerticalDivider(
                                        width: 2,
                                        color: MyColors.secondary,
                                      ),
                                      Column(
                                        children: [
                                          Text("Current Bid",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: MyColors.primary)),
                                          Text(snapshot.data
                                              .data()["currentMinBid"]),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                myBidPrice == ""
                                    ? Container()
                                    : Text(
                                        "Your Bid : $myBidPrice/-",
                                        style: TextStyle(
                                            color: MyColors.primary,
                                            fontSize: 12),
                                      ),
                              ],
                            ),
                          );
                        }
                        return Container();
                      })
                ],
              ),
            ),

            isBidDone
                ? GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Form(
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 15),
                                    controller: _bidController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        hintStyle: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff9D9D9D)),
                                        labelText: "Enter new bid price"),
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () {
                                        if (_bidController.text.isNotEmpty) {
                                          if (double.parse(
                                                  _bidController.text) >=
                                              double.parse(currentMinBid)) {
                                            _scaffoldKey.currentState
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                "Enter bid value less than current bid",
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
                                              myBidPrice = _bidController.text;
                                            });
                                          }

                                          _bidController.clear();
                                        } else {
                                          _scaffoldKey.currentState
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
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5),
                                                    topLeft:
                                                        Radius.circular(5))),
                                          ));
                                        }

                                        Navigator.pop(context);
                                      },
                                      child: Text("Done",
                                          style: TextStyle(fontFamily: 'Lato')))
                                ],
                              ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.height * 0.02,
                          left: MediaQuery.of(context).size.height * 0.02),
                      decoration: BoxDecoration(
                          color: MyColors.primary,
                          borderRadius: BorderRadius.circular(4)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Center(
                        child: Text("Modify Price",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Form(
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 15),
                                    controller: _bidController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        hintStyle: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff9D9D9D)),
                                        labelText: "Enter bid price"),
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () {
                                        if (_bidController.text.isNotEmpty) {
                                          if (double.parse(
                                                  _bidController.text) >
                                              double.parse(currentMinBid)) {
                                            _scaffoldKey.currentState
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                "Enter bid value less than current bid",
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
                                              myBidPrice = _bidController.text;
                                            });
                                          }

                                          _bidController.clear();
                                        } else {
                                          _scaffoldKey.currentState
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
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5),
                                                    topLeft:
                                                        Radius.circular(5))),
                                          ));
                                        }
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Done",
                                          style: TextStyle(fontFamily: 'Lato')))
                                ],
                              ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.height * 0.02,
                          left: MediaQuery.of(context).size.height * 0.02),
                      decoration: BoxDecoration(
                          color: MyColors.primary,
                          borderRadius: BorderRadius.circular(4)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Center(
                        child: Text("Bid",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
