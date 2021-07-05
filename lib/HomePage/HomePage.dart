import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, double> data = new Map();
  bool _loadChart = false;
  double marketer = 0, admin = 0, superAdmin = 0, transporter = 0;
  List<Color> _colors = [
    Colors.teal,
    Colors.blueAccent,
    Colors.amberAccent,
    Colors.redAccent
  ];
  @override
  void initState() {
    // getUserData();
    // data.addAll({
    //   'SuperAdmin': superAdmin,
    //   'Admin': admin,
    //   'Marketer': marketer,
    //   'Transporter': transporter
    // });
    super.initState();
  }

  // getUserData() async {
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .get()
  //       .then((value) => value.docs.forEach((element) {
  //             if (element.data()["userType"] == "transporter") {
  //               transporter++;
  //             } else if (element.data()["userType"] == "admin") {
  //               admin++;
  //             } else if (element.data()["userType"] == "superAdmin") {
  //               superAdmin++;
  //             } else if (element.data()["userType"] == "marketer") {
  //               marketer++;
  //             }
  //           }));
  //   setState(() {
  //     _loadChart = true;
  //     data.clear();
  //     data.addAll({
  //       'SuperAdmin': superAdmin,
  //       'Admin': admin,
  //       'Marketer': marketer,
  //       'Transporter': transporter
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scrollbar(
        radius: Radius.circular(4),
        thickness: 2.5,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dashboard",
                style: TextStyle(
                    color: MyColors.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: width * 0.25,
                    height: height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff01C282),
                              Color(0xff23eba8),
                            ])),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Pending\nApproval",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 26,
                            ),
                          ),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .where("verifiedUser", isEqualTo: false)
                                  // .orderBy('created_at', descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasData) {
                                  final userData = snapshot.data.docs;
                                  return Text(
                                    userData.length.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  );
                                }
                                return CircularProgressIndicator(
                                  backgroundColor: Color(0xff23eba8),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Container(
                    width: width * 0.25,
                    height: height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff884DFF),
                              Color(0xffa67dfa),
                            ])),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "OnGoing\nConsignment",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 26,
                            ),
                          ),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .where("verifiedUser", isEqualTo: false)
                                  // .orderBy('created_at', descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasData) {
                                  final userData = snapshot.data.docs;
                                  return Text(
                                    userData.length.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  );
                                }
                                return CircularProgressIndicator(
                                  backgroundColor: Color(0xff23eba8),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Container(
                    width: width * 0.25,
                    height: height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff0095FF),
                              Color(0xff74c4fc),
                            ])),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Pending Consignment\nApproval",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 26,
                            ),
                          ),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .where("verifiedUser", isEqualTo: false)
                                  // .orderBy('created_at', descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasData) {
                                  final userData = snapshot.data.docs;
                                  return Text(
                                    userData.length.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  );
                                }
                                return CircularProgressIndicator(
                                  backgroundColor: Color(0xff23eba8),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              // _loadChart
              //     ? PieChart(
              //         dataMap: data,
              //         colorList: _colors,
              //         animationDuration: Duration(milliseconds: 1500),
              //         chartLegendSpacing: 32.0,
              //         chartRadius: MediaQuery.of(context).size.width * 0.35,
              //         showChartValuesInPercentage: true,
              //         showChartValues: true,
              //         showChartValuesOutside: false,
              //         chartValueBackgroundColor: Colors.grey[200],
              //         showLegends: true,
              //         legendPosition: LegendPosition.right,
              //         decimalPlaces: 1,
              //         showChartValueLabel: true,
              //         initialAngle: 0,
              //         chartType: ChartType.disc,
              //       )
              //     : Container(),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.05,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
