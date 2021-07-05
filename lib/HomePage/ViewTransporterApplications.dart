import 'package:KPPL/HomePage/ViewUserDetails.dart';
import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewTransporterApplications extends StatefulWidget {
  ViewTransporterApplications();
  @override
  _ViewTransporterApplicationsState createState() =>
      _ViewTransporterApplicationsState();
}

class _ViewTransporterApplicationsState
    extends State<ViewTransporterApplications> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = 0;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Text(
                          "Pending",
                          style: TextStyle(
                              fontSize: 26,
                              color: currentIndex == 0
                                  ? MyColors.primary
                                  : MyColors.secondaryNew),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = 1;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Text(
                          "Approved",
                          style: TextStyle(
                              fontSize: 26,
                              color: currentIndex == 1
                                  ? MyColors.primary
                                  : MyColors.secondaryNew),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = 2;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Text(
                          "All",
                          style: TextStyle(
                              fontSize: 26,
                              color: currentIndex == 2
                                  ? MyColors.primary
                                  : MyColors.secondaryNew),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              currentIndex == 0
                  ? Container(
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.01,
                        right: MediaQuery.of(context).size.height * 0.01,
                      ),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(children: [
                            Hero(
                              tag: "nameTag",
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  width: size.width * 0.25,
                                  child: Text("Name"),
                                ),
                              ),
                            ),
                            Hero(
                              tag: "dateTag",
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  width: size.width * 0.25,
                                  child: Text("Date"),
                                ),
                              ),
                            ),
                            Hero(
                              tag: "statusTag",
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  width: size.width * 0.25,
                                  child: Text("Status"),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: size.width * 0.1,
                              child: Text(""),
                            ),
                          ]),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .where("userType", isEqualTo: "transporter")
                                  .where("verifiedUser", isEqualTo: false)
                                  // .orderBy('created_at', descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                List<Widget> transporterWidget = [];
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasData) {
                                  final userData = snapshot.data.docs;
                                  userData.forEach((user) {
                                    var email = user.data()['email'];
                                    var pan = user.data()['pan'];
                                    var phone = user.data()['phone'];
                                    var phoneVerified =
                                        user.data()['phone_verified'];
                                    var name = user.data()['username'];
                                    var emailVerified =
                                        user.data()['email_verified'];
                                    Timestamp createdAt =
                                        user.data()['created_at'];
                                    var uid = user.data()['uid'];
                                    var registrationNumber =
                                        user.data()['registrationNumber'];
                                    transporterWidget.add(TransporterDisplay(
                                      createdAt: createdAt.toDate().toString(),
                                      email: email,
                                      emailVerified: emailVerified,
                                      name: name,
                                      pan: pan,
                                      phone: phone,
                                      phoneVerified: phoneVerified,
                                      registrationNumber: registrationNumber,
                                      uid: uid,
                                    ));
                                  });
                                }
                                return ListView(
                                  shrinkWrap: true,
                                  children: transporterWidget,
                                );
                              }),
                        ],
                      ),
                    )
                  : Container(),
              currentIndex == 1
                  ? Container(
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.01,
                        right: MediaQuery.of(context).size.height * 0.01,
                      ),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: size.width * 0.25,
                              child: Text("Name"),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: size.width * 0.25,
                              child: Text("Date"),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: size.width * 0.25,
                              child: Text("Status"),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: size.width * 0.1,
                              child: Text(""),
                            ),
                          ]),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .where("userType", isEqualTo: "transporter")
                                  .where("verifiedUser", isEqualTo: true)
                                  // .orderBy('created_at', descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                List<Widget> transporterWidget = [];
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasData) {
                                  final userData = snapshot.data.docs;
                                  userData.forEach((user) {
                                    var email = user.data()['email'];
                                    var pan = user.data()['pan'];
                                    var phone = user.data()['phone'];
                                    var phoneVerified =
                                        user.data()['phone_verified'];
                                    var name = user.data()['username'];
                                    var emailVerified =
                                        user.data()['email_verified'];
                                    Timestamp createdAt =
                                        user.data()['created_at'];
                                    var uid = user.data()['uid'];
                                    var registrationNumber =
                                        user.data()['registrationNumber'];
                                    transporterWidget
                                        .add(TransporterDisplayApproved(
                                      createdAt: createdAt.toDate().toString(),
                                      email: email,
                                      emailVerified: emailVerified,
                                      name: name,
                                      pan: pan,
                                      phone: phone,
                                      phoneVerified: phoneVerified,
                                      registrationNumber: registrationNumber,
                                      uid: uid,
                                    ));
                                  });
                                }
                                return ListView(
                                  shrinkWrap: true,
                                  children: transporterWidget,
                                );
                              }),
                        ],
                      ),
                    )
                  : Container(),
              currentIndex == 2
                  ? Container(
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.01,
                        right: MediaQuery.of(context).size.height * 0.01,
                      ),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: size.width * 0.25,
                              child: Text("Name"),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: size.width * 0.25,
                              child: Text("Date"),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: size.width * 0.25,
                              child: Text("Status"),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: size.width * 0.1,
                              child: Text(""),
                            ),
                          ]),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .where("userType", isEqualTo: "transporter")
                                  // .orderBy('created_at', descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                List<Widget> transporterWidget = [];
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasData) {
                                  final userData = snapshot.data.docs;
                                  userData.forEach((user) {
                                    var email = user.data()['email'];
                                    var userVerified =
                                        user.data()['verifiedUser'];
                                    var pan = user.data()['pan'];
                                    var phone = user.data()['phone'];
                                    var phoneVerified =
                                        user.data()['phone_verified'];
                                    var name = user.data()['username'];
                                    var emailVerified =
                                        user.data()['email_verified'];
                                    Timestamp createdAt =
                                        user.data()['created_at'];
                                    var uid = user.data()['uid'];
                                    var registrationNumber =
                                        user.data()['registrationNumber'];
                                    transporterWidget.add(TransporterDisplayAll(
                                      createdAt: createdAt.toDate().toString(),
                                      email: email,
                                      emailVerified: emailVerified,
                                      name: name,
                                      pan: pan,
                                      phone: phone,
                                      phoneVerified: phoneVerified,
                                      registrationNumber: registrationNumber,
                                      uid: uid,
                                      userVerified: userVerified,
                                    ));
                                  });
                                }
                                return ListView(
                                  shrinkWrap: true,
                                  children: transporterWidget,
                                );
                              }),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class TransporterDisplay extends StatelessWidget {
  final String name, email, pan, phone, uid, registrationNumber, tag;
  final bool emailVerified, phoneVerified;
  final String createdAt;
  TransporterDisplay(
      {this.createdAt,
      this.tag,
      this.registrationNumber,
      this.email,
      this.emailVerified,
      this.name,
      this.pan,
      this.phone,
      this.phoneVerified,
      this.uid});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        String pVerify, eVerify;
        if (phoneVerified == true) {
          pVerify = 'Yes';
        } else {
          pVerify = 'No';
        }
        if (emailVerified == true) {
          eVerify = 'Yes';
        } else {
          eVerify = 'No';
        }
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ViewUserDetail(
                  email: email,
                  date: createdAt,
                  name: name,
                  phone: phone,
                  pan: pan,
                  uid: uid,
                  pVerify: pVerify,
                  eVerify: eVerify,
                  regNo: registrationNumber,
                  status: "PENDING",
                )));
      },
      child: Column(
        children: [
          Container(
            // margin: EdgeInsets.only(
            //   left: MediaQuery.of(context).size.height * 0.01,
            //   right: MediaQuery.of(context).size.height * 0.01,
            // ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height * 0.13,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: "nameTagValue" + email,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: size.width * 0.25,
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(color: MyColors.secondary, fontSize: 14),
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: "dateTagValue" + email,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: size.width * 0.25,
                      child: Text(
                        createdAt.split(" ")[0],
                        style:
                            TextStyle(color: MyColors.secondary, fontSize: 14),
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: "statusTagValue" + email,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: size.width * 0.25,
                      child: Text(
                        "Pending",
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(email)
                          .update({"verifiedUser": true});
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "User APPROVED",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        elevation: 0,
                        duration: Duration(seconds: 2),
                        backgroundColor: MyColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5))),
                      ));
                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.05,
                        decoration: BoxDecoration(
                          color: MyColors.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            "Approve",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: MyColors.secondaryNew,
            height: 2,
          )
        ],
      ),
    );
  }
}

class TransporterDisplayApproved extends StatelessWidget {
  final String name, email, pan, phone, uid, registrationNumber;
  final bool emailVerified, phoneVerified;
  final String createdAt;
  TransporterDisplayApproved(
      {this.createdAt,
      this.registrationNumber,
      this.email,
      this.emailVerified,
      this.name,
      this.pan,
      this.phone,
      this.phoneVerified,
      this.uid});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            // margin: EdgeInsets.only(
            //   left: MediaQuery.of(context).size.height * 0.01,
            //   right: MediaQuery.of(context).size.height * 0.01,
            // ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height * 0.13,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.25,
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: MyColors.secondary, fontSize: 14),
                  ),
                ),
                Container(
                  width: size.width * 0.25,
                  child: Text(
                    createdAt.split(" ")[0],
                    style: TextStyle(color: MyColors.secondary, fontSize: 14),
                  ),
                ),
                Container(
                  width: size.width * 0.25,
                  child: Text(
                    "Approved",
                    style: TextStyle(color: Colors.green, fontSize: 14),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(email)
                          .update({"verifiedUser": false});
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "User REMOVED",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        elevation: 0,
                        duration: Duration(seconds: 2),
                        backgroundColor: MyColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5))),
                      ));
                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.05,
                        decoration: BoxDecoration(
                          color: MyColors.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            "Remove",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
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

class TransporterDisplayAll extends StatelessWidget {
  final String name, email, pan, phone, uid, registrationNumber;
  final bool emailVerified, phoneVerified, userVerified;
  final String createdAt;
  TransporterDisplayAll(
      {this.createdAt,
      this.userVerified,
      this.registrationNumber,
      this.email,
      this.emailVerified,
      this.name,
      this.pan,
      this.phone,
      this.phoneVerified,
      this.uid});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            // margin: EdgeInsets.only(
            //   left: MediaQuery.of(context).size.height * 0.01,
            //   right: MediaQuery.of(context).size.height * 0.01,
            // ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height * 0.13,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.25,
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: MyColors.secondary, fontSize: 14),
                  ),
                ),
                Container(
                  width: size.width * 0.25,
                  child: Text(
                    createdAt.split(" ")[0],
                    style: TextStyle(color: MyColors.secondary, fontSize: 14),
                  ),
                ),
                Container(
                  width: size.width * 0.25,
                  child: userVerified
                      ? Text(
                          "Approved",
                          style: TextStyle(color: Colors.green, fontSize: 14),
                        )
                      : Text(
                          "Pending",
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.05,
                        decoration: BoxDecoration(
                          color: MyColors.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            "View",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
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
