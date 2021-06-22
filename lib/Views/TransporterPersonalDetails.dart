import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransporterPersonalDetail extends StatefulWidget {
  final int selectedTab;
  TransporterPersonalDetail({this.selectedTab});
  @override
  _TransporterPersonalDetailState createState() =>
      _TransporterPersonalDetailState();
}

class _TransporterPersonalDetailState extends State<TransporterPersonalDetail> {
  DocumentSnapshot snap;
  bool gotDocument = false;
  @override
  void initState() {
    super.initState();
    getDocument();
  }

  getDocument() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.email)
        .get()
        .then((value) {
      snap = value;
      setState(() {
        gotDocument = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 15,
            right: 15,
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
                width: 13,
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
                      "Profile",
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
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(7)),
            // height: size.height - size.height * 0.04 - size.height * 0.3,
            width: size.width,
            margin: EdgeInsets.only(
              // top: size.height * 0.0,
              right: 15,
              left: 15,
            ),
            child: Scrollbar(
              child: SingleChildScrollView(
                  child: Container(
                      // padding: EdgeInsets.all(size.width * 0.02),
                      width: size.width * 0.8,
                      height: size.height * 0.65,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                // margin: EdgeInsets.only(left: 8),
                                height: size.height * 0.8,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7),
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
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: size.width * 0.03,
                                    right: size.width * 0.03,
                                    bottom: size.width * 0.03,
                                    top: size.width * 0.03,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.selectedTab == 0
                                            ? "Personal Details"
                                            : "Comapny Details",
                                        style: TextStyle(
                                            color: MyColors.red,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Divider(
                                        thickness: 2,
                                        color: MyColors.red,
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Expanded(
                                          child: Container(
                                        margin:
                                            EdgeInsets.all(size.width * 0.015),
                                        child: widget.selectedTab == 0
                                            ? personalDetails(
                                                size, snap, gotDocument)
                                            : companyDetails(
                                                size, snap, gotDocument),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ]))),
            )),
      ],
    );
  }

  Widget companyDetails(Size size, DocumentSnapshot snap, bool value) {
    return SingleChildScrollView(
        child: value
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.375,
                            child: Text(
                              "Company Name",
                              style: TextStyle(
                                  color: MyColors.secondary, fontSize: 16),
                            ),
                          ),
                          Expanded(
                            // width: size.width * 0.2,
                            child: Text(
                              snap.data()["companyName"],
                              style: TextStyle(
                                  color: Color(0xff4d4d4d), fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.055,
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.375,
                            child: Text(
                              "Company Type",
                              style: TextStyle(
                                  color: MyColors.secondary, fontSize: 16),
                            ),
                          ),
                          Expanded(
                            // width: size.width * 0.2,
                            child: Text(
                              snap.data()["companyType"],
                              style: TextStyle(
                                  color: Color(0xff4d4d4d), fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.055,
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.375,
                            child: Text(
                              "Registration No.",
                              style: TextStyle(
                                  color: MyColors.secondary, fontSize: 16),
                            ),
                          ),
                          Expanded(
                            // width: size.width * 0.2,
                            child: Text(
                              snap.data()["registrationNumber"],
                              style: TextStyle(
                                  color: Color(0xff4d4d4d), fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.055,
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.375,
                            child: Text(
                              "PAN No.",
                              style: TextStyle(
                                  color: MyColors.secondary, fontSize: 16),
                            ),
                          ),
                          Expanded(
                            // width: size.width * 0.2,
                            child: Text(
                              snap.data()["pan"],
                              style: TextStyle(
                                  color: Color(0xff4d4d4d), fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Container(
                    child: Text(
                      "* To change your company details contact admin.",
                      style: TextStyle(
                        color: MyColors.red,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              )
            : CircularProgressIndicator());
  }

  Widget personalDetails(Size size, DocumentSnapshot snap, bool value) {
    return SingleChildScrollView(
        child: value
            ? Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: size.width * 0.375,
                        child: Text(
                          "User ID",
                          style: TextStyle(
                              color: MyColors.secondary, fontSize: 16),
                        ),
                      ),
                      Expanded(
                        // width: size.width * 0.2,
                        child: Text(
                          snap.data()["userID"],
                          style:
                              TextStyle(color: Color(0xff4d4d4d), fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.055,
                  ),
                  Row(
                    children: [
                      Container(
                        width: size.width * 0.375,
                        child: Text(
                          "Name",
                          style: TextStyle(
                              color: MyColors.secondary, fontSize: 16),
                        ),
                      ),
                      Expanded(
                        // width: size.width * 0.2,
                        child: Text(
                          snap.data()["username"],
                          style:
                              TextStyle(color: Color(0xff4d4d4d), fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.055,
                  ),
                  Row(
                    children: [
                      Container(
                        width: size.width * 0.375,
                        child: Text(
                          "Phone No.",
                          style: TextStyle(
                              color: MyColors.secondary, fontSize: 16),
                        ),
                      ),
                      Expanded(
                        // width: size.width * 0.2,
                        child: Text(
                          snap.data()["phone"],
                          style:
                              TextStyle(color: Color(0xff4d4d4d), fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.055,
                  ),
                  Row(
                    children: [
                      Container(
                        width: size.width * 0.375,
                        child: Text(
                          "Email ID",
                          style: TextStyle(
                              color: MyColors.secondary, fontSize: 16),
                        ),
                      ),
                      Expanded(
                        // width: size.width * 0.2,
                        child: Text(
                          snap.id,
                          style:
                              TextStyle(color: Color(0xff4d4d4d), fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                ],
              )
            : CircularProgressIndicator());
  }
}
