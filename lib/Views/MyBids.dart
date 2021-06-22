import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyBids extends StatefulWidget {
  final String email;
  MyBids({
    this.email,
  });
  @override
  _MyBidsState createState() => _MyBidsState();
}

class _MyBidsState extends State<MyBids> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundNewPage,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.email)
                    .collection("myBids")
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  List<Widget> bidWidget = [];
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    final userData = snapshot.data.docs;
                    userData.forEach((consignment) {
                      var pickUpLocation = consignment.data()["pickUpLocation"];
                      var dropLocation = consignment.data()["dropLocation"];
                      var consignmentCode = consignment.id;
                      bidWidget.add(BidCardDisplay(
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
          )
        ],
      ),
    );
  }
}

class BidCardDisplay extends StatelessWidget {
  final String consignmentCode, pickUpLocation, dropLocation;
  BidCardDisplay({
    this.consignmentCode,
    this.dropLocation,
    this.pickUpLocation,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => BidDescriptionPage(
        //           description: description,
        //           pickUpLocation: pickUpLocation,
        //           dropLocation: dropLocation,
        //           consignmentCode: consignmentCode,
        //         )));
      },
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    blurRadius: 4.0,
                    spreadRadius: 5.0,
                    offset: Offset(
                      0.0,
                      0.0,
                    ),
                  )
                ],
              ),
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              height: MediaQuery.of(context).size.height * 0.158,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.04,
                    left: MediaQuery.of(context).size.height * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.gps_fixed_outlined,
                          color: MyColors.secondary,
                          size: 15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "Pickup Location : $pickUpLocation",
                          style: TextStyle(
                              color: MyColors.secondary, fontSize: 12),
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
                          color: MyColors.secondary,
                          size: 15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "Drop Location : $dropLocation",
                          style: TextStyle(
                              color: MyColors.secondary, fontSize: 12),
                        ),
                      ],
                    ),
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("consignment")
                            .doc(consignmentCode)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: Container());
                          }
                          if (snapshot.hasData) {
                            return Container(
                              margin: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.02,
                                left: MediaQuery.of(context).size.width * 0.02,
                              ),
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Current Bid Price: ${snapshot.data.data()["currentMinBid"]}/-",
                                style: TextStyle(
                                    color: MyColors.secondary, fontSize: 12),
                              ),
                            );
                          }
                          return Container();
                        })
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.width * 0.08,
            left: MediaQuery.of(context).size.width * 0.06,
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.height * 0.12,
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: MyColors.primary, width: 5)),
            ),
          ),
        ],
      ),
    );
  }
}
