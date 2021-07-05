import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Marketing extends StatefulWidget {
  @override
  _MarketingState createState() => _MarketingState();
}

class _MarketingState extends State<Marketing> {
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
                            "All marketing user",
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
                            "Approved Consignment",
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
                            "Pending Consignment",
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
                              Container(
                                alignment: Alignment.centerLeft,
                                width: size.width * 0.25,
                                child: Text("Name"),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: size.width * 0.25,
                                child: Text("Email Address"),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: size.width * 0.25,
                                child: Text("Phone Number"),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: size.width * 0.1,
                                child: Text("Date"),
                              ),
                            ]),
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .where("userType", isEqualTo: "marketer")
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
                                      var phone = user.data()['phone'];
                                      var name = user.data()['username'];
                                      Timestamp createdAt =
                                          user.data()['created_at'];
                                      var uid = user.data()['uid'];
                                      transporterWidget.add(MarketingDisplay(
                                        createdAt:
                                            createdAt.toDate().toString(),
                                        email: email,
                                        name: name,
                                        phone: phone,
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
              ],
            ))));
  }
}

class MarketingDisplay extends StatelessWidget {
  final String name, email, phone, uid;
  final String createdAt;
  MarketingDisplay(
      {this.createdAt, this.email, this.name, this.phone, this.uid});
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
                    email,
                    style: TextStyle(color: MyColors.secondary, fontSize: 14),
                  ),
                ),
                Container(
                  width: size.width * 0.25,
                  child: Text(
                    phone,
                    style: TextStyle(color: MyColors.secondary, fontSize: 14),
                  ),
                ),
                Container(
                  width: size.width * 0.1,
                  child: Text(
                    createdAt.split(" ")[0],
                    style: TextStyle(color: MyColors.secondary, fontSize: 14),
                  ),
                ),
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
