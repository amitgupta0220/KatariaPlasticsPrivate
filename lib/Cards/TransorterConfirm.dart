import 'dart:io';

import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TransporterConfirm extends StatefulWidget {
  @override
  _TransporterConfirmState createState() => _TransporterConfirmState();
}

class _TransporterConfirmState extends State<TransporterConfirm> {
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
                            "Confirmed Orders",
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
                          .where("status", isEqualTo: "ongoing")
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
                            bidWidget.add(TransporterCompletedCard(
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

class TransporterCompletedCard extends StatefulWidget {
  final bidPrice, dropLocation, pickUpLocation, date, consignmentCode;
  TransporterCompletedCard(
      {this.bidPrice,
      this.consignmentCode,
      this.date,
      this.dropLocation,
      this.pickUpLocation});
  @override
  _TransporterCompletedCardState createState() =>
      _TransporterCompletedCardState();
}

class _TransporterCompletedCardState extends State<TransporterCompletedCard> {
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
                    width: size.width * 0.015,
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
                  builder: (_) => ViewTransporterCompleted(
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
                child: Text("Details",
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

class ViewTransporterCompleted extends StatefulWidget {
  final String code;
  ViewTransporterCompleted({this.code});
  @override
  _ViewTransporterCompletedState createState() =>
      _ViewTransporterCompletedState();
}

class _ViewTransporterCompletedState extends State<ViewTransporterCompleted> {
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
                          width: 110,
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
                                  "Delivery",
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
                              : deliveryTab(size, snap),
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

  deliveryTab(Size size, DocumentSnapshot snap) {
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
          GestureDetector(
            onTap: () => _showPicker(context),
            child: Container(
              margin: EdgeInsets.all(8),
              height: size.width * 0.08,
              child: FDottedLine(
                  space: 6,
                  strokeWidth: 1,
                  color: MyColors.secondaryNew,
                  child: _image != null
                      ? Center(
                          child: Text("${_image.path.split("/").last}",
                              style: TextStyle(
                                  fontSize: 12, color: MyColors.secondary)),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/addDocument.png"),
                            SizedBox(
                              width: 8,
                            ),
                            Center(
                                child: Text("Upload certificate",
                                    style: TextStyle(
                                      color: MyColors.secondary,
                                      fontSize: 13,
                                    ))),
                          ],
                        )),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          GestureDetector(
            onTap: () {
              if (_image != null) {
                FirebaseStorage.instance
                    .refFromURL("gs://logistics-katariaplastics.appspot.com/")
                    .child(
                        "/receipt/${DateTime.now().microsecondsSinceEpoch}.${_image.path.split("/").last.split(".")[1]}")
                    .putFile(_image)
                    .then((v) async {
                  String url = await v.ref.getDownloadURL();
                  FirebaseFirestore.instance
                      .collection("consignment")
                      .doc(widget.code)
                      .update({
                    "deliveredImageUrl": url,
                    "status": "delivered",
                  });
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser.email)
                      .collection("myOrders")
                      .doc(widget.code)
                      .update({
                    "deliveredImageUrl": url,
                    "status": "delivered",
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Upload Successful",
                      style: TextStyle(color: Colors.white),
                    ),
                    elevation: 0,
                    duration: Duration(milliseconds: 1500),
                    backgroundColor: MyColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5))),
                  ));
                });
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Upload Receipt",
                    style: TextStyle(color: Colors.white),
                  ),
                  elevation: 0,
                  duration: Duration(milliseconds: 1500),
                  backgroundColor: MyColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          topLeft: Radius.circular(5))),
                ));
              }
            },
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: MyColors.primaryNew,
                    borderRadius: BorderRadius.circular(2)),
                padding: EdgeInsets.all(8),
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
          )
        ]));
  }

  final ImagePicker _picker = ImagePicker();
  File _image;
  void _showPicker(context) {
    showModalBottomSheet(
        barrierColor: Colors.transparent,
        elevation: 10,
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    PickedFile image =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  _imgFromGallery() async {
    PickedFile image =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }
}
