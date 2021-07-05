import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewOpenConsignment extends StatefulWidget {
  final String id,
      status,
      currentBidBy,
      currentBid,
      dropLocation,
      pickUpLocation;
  ViewOpenConsignment(
      {this.currentBid,
      this.currentBidBy,
      this.id,
      this.status,
      this.dropLocation,
      this.pickUpLocation});
  @override
  _ViewOpenConsignmentState createState() => _ViewOpenConsignmentState();
}

class _ViewOpenConsignmentState extends State<ViewOpenConsignment> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        // appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                      alignment: Alignment.center,
                      width: size.width * 0.5 - 32,
                      height: size.height * 0.35,
                      margin: EdgeInsets.only(top: 16, left: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              offset: Offset(
                                0,
                                1,
                              ),
                            )
                          ]),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Hero(
                                    tag: "idOpenConsignment",
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text("ID : "),
                                      ),
                                    ),
                                  ),
                                  Hero(
                                    tag: "idOpenConsignmentValue" + widget.id,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Container(
                                        child: Text(
                                          widget.id,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColors.secondary,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.width * 0.025,
                              ),
                              Row(
                                children: [
                                  Hero(
                                    tag: "statusOpenConsignment",
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Status : "),
                                      ),
                                    ),
                                  ),
                                  StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("consignment")
                                        .doc(widget.id)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      var value;
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(child: Container());
                                      }
                                      if (snapshot.hasData) {
                                        value = snapshot.data.data()["status"];
                                      }
                                      return Container(
                                        child: Text(
                                          value.toString().toUpperCase() ?? "",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 14),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.width * 0.025,
                              ),
                              Row(
                                children: [
                                  Hero(
                                    tag: "currentMinBidByOpenConsignment",
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Current Min Bid By : "),
                                      ),
                                    ),
                                  ),
                                  StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("consignment")
                                        .doc(widget.id)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      var value;
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(child: Container());
                                      }
                                      if (snapshot.hasData) {
                                        value = snapshot.data
                                            .data()["currentMinBidBy"];
                                      }
                                      return Container(
                                        child: Text(
                                          value ?? "",
                                          style: TextStyle(
                                              color: MyColors.secondary,
                                              fontSize: 14),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.width * 0.025,
                              ),
                              Row(
                                children: [
                                  Hero(
                                    tag: "currentMinOpenConsignment",
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Current Min Bid : "),
                                      ),
                                    ),
                                  ),
                                  StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("consignment")
                                        .doc(widget.id)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      var value;
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(child: Container());
                                      }
                                      if (snapshot.hasData) {
                                        value = snapshot.data
                                            .data()["currentMinBid"];
                                      }
                                      return Container(
                                        child: Text(
                                          value ?? "",
                                          style: TextStyle(
                                              color: MyColors.secondary,
                                              fontSize: 14),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.all(1),
                              // height: size.height * 0.5,
                              // width: size.width * 0.38,
                              child: Image.asset("assets/userVectorArt.jpg"))
                        ],
                      )),
                  Container(
                    width: size.width * 0.5 - 16,
                    height: size.height * 0.35,
                    margin: EdgeInsets.only(top: 16, left: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            offset: Offset(
                              0,
                              1,
                            ),
                          )
                        ]),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.all(size.width * 0.01),
                padding: EdgeInsets.all(size.width * 0.01),
                height: size.height - size.height * 0.35 - size.width * 0.05,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                        offset: Offset(
                          0,
                          1,
                        ),
                      )
                    ]),
                child: Scrollbar(
                  thickness: 1,
                  radius: Radius.circular(4),
                  controller: _scrollController,
                  isAlwaysShown: true,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("All bids :",
                            style:
                                TextStyle(color: Colors.black, fontSize: 14)),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: size.width * 0.4,
                              child: Text(
                                "Bid By",
                                style: TextStyle(
                                    color: MyColors.secondary, fontSize: 14),
                              ),
                            ),
                            Container(
                              width: size.width * 0.4,
                              child: Text(
                                "Bid Pice",
                                style: TextStyle(
                                    color: MyColors.secondary, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("consignment")
                              .doc(widget.id)
                              .collection("userBids")
                              .orderBy("bidPrice")
                              .snapshots(),
                          builder: (context, snapshot) {
                            List<Widget> bidWidget = [];
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasData) {
                              final userData = snapshot.data.docs;
                              userData.forEach((bid) {
                                var user = bid.id;
                                var price = bid.data()["bidPrice"];
                                bidWidget.add(BidWidgetDisplay(
                                  price: price,
                                  user: user,
                                  consignmentCode: widget.id,
                                  pickUpLocation: widget.pickUpLocation,
                                  dropLocation: widget.dropLocation,
                                ));
                              });
                              return ListView(
                                children: bidWidget,
                                shrinkWrap: true,
                              );
                            }
                            return Container();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BidWidgetDisplay extends StatelessWidget {
  final String user, price, consignmentCode, pickUpLocation, dropLocation;
  BidWidgetDisplay(
      {this.user,
      this.price,
      this.consignmentCode,
      this.dropLocation,
      this.pickUpLocation});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height * 0.13,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.4,
                  child: Text(
                    user,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: MyColors.secondary, fontSize: 14),
                  ),
                ),
                Container(
                  width: size.width * 0.4,
                  child: Text(
                    price,
                    style: TextStyle(color: MyColors.secondary, fontSize: 14),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection("consignment")
                        .doc(consignmentCode)
                        .update({
                      "assignedTo": user,
                      "assignedToID": user, //TODO: change id here
                      "status": "ongoing"
                    });
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(user)
                        .collection("myOrders")
                        .doc(consignmentCode)
                        .set({
                      "finalBid": price,
                      "status": "ongoing",
                      "pickUpLocation": pickUpLocation,
                      "dropLocation": dropLocation,
                    });
                  },
                  child: Container(
                    height: size.height * 0.05,
                    width: size.width * 0.1,
                    child: Center(
                        child: Text("Confirm",
                            style: TextStyle(
                              color: Colors.white,
                            ))),
                    decoration: BoxDecoration(
                        color: MyColors.primary,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: MyColors.secondaryNew,
            height: 2,
          )
        ],
      ),
    );
  }
}
