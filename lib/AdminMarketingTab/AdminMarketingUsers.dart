import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminMarketingUsers extends StatefulWidget {
  @override
  _AdminMarketingUsersState createState() => _AdminMarketingUsersState();
}

class _AdminMarketingUsersState extends State<AdminMarketingUsers> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child: Column(children: [
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
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 20,
                  height: size.height * 0.1,
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
                    height: size.height * 0.1,
                    child: Container(
                      margin: EdgeInsets.only(left: size.height * 0.05),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Marketing User",
                        style: TextStyle(
                            color: MyColors.primaryNew,
                            fontSize: 26,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: size.height * 0.7,
              margin: EdgeInsets.only(
                top: size.height * 0.01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(7),
                  bottomRight: Radius.circular(7),
                ),
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
              ),
              padding: EdgeInsets.only(
                top: size.width * 0.03,
                bottom: size.width * 0.03,
                left: size.width * 0.02,
                right: size.width * 0.02,
              ),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  children: [
                    Container(
                      width: size.width * 0.15,
                      child: Text(
                        "Name",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: MyColors.secondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.15,
                      child: Text(
                        "Contact No.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: MyColors.secondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.15,
                      child: Text(
                        "Date",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: MyColors.secondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    // Container(
                    //   width: size.width * 0.13,
                    //   child: Text(
                    //     "",
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(
                    //       fontSize: 20,
                    //       color: MyColors.secondary,
                    //       fontWeight: FontWeight.w700,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Divider(
                  color: MyColors.secondaryNew,
                  thickness: 2,
                  height: 1,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Expanded(
                    child: Scrollbar(
                  thickness: 2,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where("userType", isEqualTo: "marketer")
                          // .where("verifiedUser", isEqualTo: false)
                          // .orderBy('created_at', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        List<Widget> transporterWidget = [];
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          final userData = snapshot.data.docs;
                          userData.forEach((user) {
                            var email = user.data()['email'];
                            var phone = user.data()['phone'];
                            var name = user.data()['username'];
                            Timestamp createdAt = user.data()['created_at'];
                            var uid = user.data()['uid'];
                            transporterWidget.add(AdminMarketingDisplay(
                              createdAt: createdAt.toDate().toString(),
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
                ))
              ]))
        ])),
      ),
    );
  }
}

class AdminMarketingDisplay extends StatelessWidget {
  final String name, email, phone, uid;
  final String createdAt;
  AdminMarketingDisplay(
      {this.createdAt, this.email, this.name, this.phone, this.uid});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(
          bottom: size.height * 0.05,
        ),
        child: Row(
          children: [
            Hero(
              tag: "adminMarketingName" + uid,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: size.width * 0.15,
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: MyColors.secondary,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: size.width * 0.15,
              child: Hero(
                tag: "adminMarketingNumber" + uid,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    phone,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: MyColors.secondary,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: size.width * 0.15,
              child: Hero(
                tag: "adminMarketingDate" + uid,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    createdAt.split(" ")[0],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: MyColors.secondary,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  "View",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: MyColors.primaryNew,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
