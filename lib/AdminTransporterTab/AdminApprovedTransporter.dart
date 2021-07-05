import 'dart:html' as html;

import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
// import 'package:pdf/widgets.dart' as f;

class AdminApprovedTransporter extends StatefulWidget {
  @override
  _AdminApprovedTransporterState createState() =>
      _AdminApprovedTransporterState();
}

class _AdminApprovedTransporterState extends State<AdminApprovedTransporter> {
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
                        "Approved Transporter",
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                            .where("userType", isEqualTo: "transporter")
                            .where("verifiedUser", isEqualTo: true)
                            // .orderBy('date', descending: true)
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
                              var pan = user.data()['pan'];
                              var panUrl = user.data()['panUrl'];
                              var regUrl = user.data()['regUrl'];
                              var phone = user.data()['phone'];
                              var phoneVerified = user.data()['phone_verified'];
                              var name = user.data()['username'];
                              var emailVerified = user.data()['email_verified'];
                              Timestamp createdAt = user.data()['created_at'];
                              var uid = user.data()['uid'];
                              var companyName = user.data()['companyName'];
                              var companyType = user.data()['companyType'];
                              var id = user.data()['userID'];
                              var registrationNumber =
                                  user.data()['registrationNumber'];
                              transporterWidget
                                  .add(AdminApprovedTransporterCard(
                                //TODO: sort by date to add
                                createdAt: createdAt.toDate().toString(),
                                regUrl: regUrl, panUrl: panUrl,
                                email: email,
                                id: id,
                                emailVerified: emailVerified,
                                name: name,
                                pan: pan,
                                phone: phone,
                                phoneVerified: phoneVerified,
                                registrationNumber: registrationNumber,
                                companyName: companyName,
                                companyType: companyType,
                                uid: uid,
                              ));
                            });
                          }
                          return ListView(
                            shrinkWrap: true,
                            children: transporterWidget,
                          );
                        }),
                  ),
                ),
              ],
            ),
          )
        ])),
      ),
    );
  }
}

class AdminApprovedTransporterCard extends StatefulWidget {
  final String name,
      email,
      id,
      pan,
      panUrl,
      regUrl,
      phone,
      uid,
      registrationNumber,
      companyName,
      companyType;
  final bool emailVerified, phoneVerified;
  final String createdAt;
  AdminApprovedTransporterCard(
      {this.createdAt,
      this.registrationNumber,
      this.panUrl,
      this.regUrl,
      this.email,
      this.id,
      this.emailVerified,
      this.name,
      this.pan,
      this.phone,
      this.phoneVerified,
      this.companyName,
      this.companyType,
      this.uid});
  @override
  _AdminApprovedTransporterCardState createState() =>
      _AdminApprovedTransporterCardState();
}

class _AdminApprovedTransporterCardState
    extends State<AdminApprovedTransporterCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        bottom: size.height * 0.05,
      ),
      child: Row(
        children: [
          Hero(
            tag: "adminApprovedTransporterName" + widget.uid,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: size.width * 0.15,
                child: Text(
                  widget.name,
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
              tag: "adminApprovedTransporterNumber" + widget.uid,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  widget.phone,
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
              tag: "adminApprovedTransporterDate" + widget.uid,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  widget.createdAt.split(" ")[0],
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
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ViewAdminApprovedTransporter(
                          createdAt: widget.createdAt,
                          email: widget.email,
                          emailVerified: widget.emailVerified,
                          name: widget.name,
                          regUrl: widget.regUrl,
                          panUrl: widget.panUrl,
                          id: widget.id,
                          pan: widget.pan,
                          phone: widget.phone,
                          phoneVerified: widget.phoneVerified,
                          registrationNumber: widget.registrationNumber,
                          uid: widget.uid,
                          companyName: widget.companyName,
                          companyType: widget.companyType,
                        )));
              },
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
    );
  }
}

class ViewAdminApprovedTransporter extends StatefulWidget {
  final String name,
      email,
      id,
      pan,
      panUrl,
      regUrl,
      phone,
      uid,
      registrationNumber,
      companyName,
      companyType;
  final bool emailVerified, phoneVerified;
  final String createdAt;
  ViewAdminApprovedTransporter({
    this.createdAt,
    this.registrationNumber,
    this.email,
    this.id,
    this.emailVerified,
    this.name,
    this.pan,
    this.regUrl,
    this.panUrl,
    this.phone,
    this.phoneVerified,
    this.uid,
    this.companyName,
    this.companyType,
  });
  @override
  _ViewAdminApprovedTransporterState createState() =>
      _ViewAdminApprovedTransporterState();
}

class _ViewAdminApprovedTransporterState
    extends State<ViewAdminApprovedTransporter> {
  int currentTab = 0;
  var blob;
  Future<html.Blob> myGetBlobPdfContent(Size size) async {
    var data = await rootBundle.load("assets/Lato-Regular.ttf");
    var ttf = pw.Font.ttf(data);
    // var myStyle = pw.TextStyle(font: myFont, fontSize: 36.0);

    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Center(
                child: pw.Text(
              "Kataria Logistics",
              style: pw.TextStyle(
                font: ttf,
                fontSize: 22,
                fontWeight: pw.FontWeight.bold,
              ),
            )),
            pw.SizedBox(
              height: size.height * 0.08,
            ),
            pw.Container(
                // width: size.width * 0.75,
                // padding: pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColor.fromHex("#000000"))),
                child: pw.Row(children: [
                  pw.Flexible(
                      child: pw.Column(children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(children: [
                              pw.SizedBox(width: 10),
                              pw.Container(
                                // width: size.width * 0.09,
                                child: pw.Text(
                                  "Name",
                                  style: pw.TextStyle(font: ttf, fontSize: 18),
                                ),
                              ),
                            ]),

                            pw.Row(children: [
                              pw.SizedBox(
                                width: 10,
                              ),
                              pw.Text(
                                widget.name,
                                style: pw.TextStyle(font: ttf, fontSize: 18),
                              ),
                            ])
                            // ),
                          ],
                        ),
                        // pw.SizedBox(
                        //   height: size.height * 0.05,
                        // ),
                        pw.Divider(
                            thickness: 1, color: PdfColor.fromHex("#000000")),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(children: [
                              pw.SizedBox(width: 10),
                              pw.Container(
                                // width: size.width * 0.09,
                                child: pw.Text(
                                  "Comapny Name",
                                  style: pw.TextStyle(font: ttf, fontSize: 18),
                                ),
                              ),
                            ]),

                            pw.Row(children: [
                              pw.SizedBox(
                                width: 10,
                              ),
                              pw.Text(
                                widget.companyName,
                                style: pw.TextStyle(font: ttf, fontSize: 18),
                              ),
                            ])
                            // ),
                          ],
                        ),
                        // pw.SizedBox(
                        //   height: size.height * 0.05,
                        // ),
                        pw.Divider(
                            thickness: 1, color: PdfColor.fromHex("#000000")),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(children: [
                              pw.SizedBox(width: 10),
                              pw.Container(
                                // width: size.width * 0.09,
                                child: pw.Text(
                                  "Company Type",
                                  style: pw.TextStyle(font: ttf, fontSize: 18),
                                ),
                              ),
                            ]),

                            pw.Row(children: [
                              pw.SizedBox(
                                width: 10,
                              ),
                              pw.Text(
                                widget.companyType,
                                style: pw.TextStyle(font: ttf, fontSize: 18),
                              ),
                            ])
                            // ),
                          ],
                        ),
                        // pw.SizedBox(
                        //   height: size.height * 0.05,
                        // ),
                        pw.Divider(
                            thickness: 1, color: PdfColor.fromHex("#000000")),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(children: [
                              pw.SizedBox(width: 10),
                              pw.Container(
                                // width: size.width * 0.09,
                                child: pw.Text(
                                  "Reg. No.",
                                  style: pw.TextStyle(font: ttf, fontSize: 18),
                                ),
                              ),
                            ]),

                            pw.Row(children: [
                              pw.SizedBox(
                                width: 10,
                              ),
                              pw.Text(
                                widget.registrationNumber,
                                style: pw.TextStyle(font: ttf, fontSize: 18),
                              ),
                            ])
                            // ),
                          ],
                        ),
                        // pw.SizedBox(
                        //   height: size.height * 0.05,
                        // ),
                        pw.Divider(
                            thickness: 1, color: PdfColor.fromHex("#000000")),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(children: [
                              pw.SizedBox(width: 10),
                              pw.Container(
                                // width: size.width * 0.09,
                                child: pw.Text(
                                  "Email",
                                  style: pw.TextStyle(font: ttf, fontSize: 18),
                                ),
                              ),
                            ]),

                            pw.Row(children: [
                              pw.SizedBox(
                                width: 10,
                              ),
                              pw.Text(
                                widget.email,
                                style: pw.TextStyle(font: ttf, fontSize: 18),
                              ),
                            ])
                            // ),
                          ],
                        ),
                      ]),
                      flex: 1),
                  pw.Container(
                      width: 1,
                      height: 370,
                      color: PdfColor.fromHex("#000000")),
                  pw.Flexible(
                      flex: 1,
                      child: pw.Column(children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(children: [
                              pw.SizedBox(width: 10),
                              pw.Container(
                                // width: size.width * 0.09,
                                child: pw.Text(
                                  "User ID",
                                  style: pw.TextStyle(font: ttf, fontSize: 18),
                                ),
                              ),
                            ]),

                            pw.Row(children: [
                              pw.SizedBox(
                                width: 10,
                              ),
                              pw.Text(
                                widget.id,
                                style: pw.TextStyle(font: ttf, fontSize: 18),
                              ),
                            ])
                            // ),
                          ],
                        ),
                        pw.Divider(
                            thickness: 1, color: PdfColor.fromHex("#000000")),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(children: [
                              pw.SizedBox(width: 10),
                              pw.Container(
                                // width: size.width * 0.09,
                                child: pw.Text(
                                  "Reg. Date",
                                  style: pw.TextStyle(font: ttf, fontSize: 18),
                                ),
                              ),
                            ]),

                            pw.Row(children: [
                              pw.SizedBox(
                                width: 10,
                              ),
                              pw.Text(
                                widget.createdAt.split(" ")[0],
                                style: pw.TextStyle(font: ttf, fontSize: 18),
                              ),
                            ])
                            // ),
                          ],
                        ),
                        pw.Divider(
                            thickness: 1, color: PdfColor.fromHex("#000000")),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(children: [
                              pw.SizedBox(width: 10),
                              pw.Container(
                                // width: size.width * 0.09,
                                child: pw.Text(
                                  "Pan No.",
                                  style: pw.TextStyle(font: ttf, fontSize: 18),
                                ),
                              ),
                            ]),

                            pw.Row(children: [
                              pw.SizedBox(
                                width: 10,
                              ),
                              pw.Text(
                                widget.pan,
                                style: pw.TextStyle(font: ttf, fontSize: 18),
                              ),
                            ])
                            // ),
                          ],
                        ),
                        pw.Divider(
                            thickness: 1, color: PdfColor.fromHex("#000000")),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(children: [
                              pw.SizedBox(width: 10),
                              pw.Container(
                                // width: size.width * 0.09,
                                child: pw.Text(
                                  "Phone No.",
                                  style: pw.TextStyle(font: ttf, fontSize: 18),
                                ),
                              ),
                            ]),

                            pw.Row(children: [
                              pw.SizedBox(
                                width: 10,
                              ),
                              pw.Text(
                                widget.phone,
                                style: pw.TextStyle(font: ttf, fontSize: 18),
                              ),
                            ])
                            // ),
                          ],
                        ),
                        pw.Divider(
                            thickness: 1, color: PdfColor.fromHex("#000000")),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(children: [
                              pw.SizedBox(width: 10),
                              pw.Container(
                                // width: size.width * 0.09,
                                child: pw.Text(
                                  "Status",
                                  style: pw.TextStyle(font: ttf, fontSize: 18),
                                ),
                              ),
                            ]),

                            pw.Row(children: [
                              pw.SizedBox(
                                width: 10,
                              ),
                              pw.Text(
                                "Approved",
                                style: pw.TextStyle(font: ttf, fontSize: 18),
                              ),
                            ])
                            // ),
                          ],
                        ),
                      ]))
                ])),
          ]);
        }));
    final bytes = await pdf.save();
    html.Blob blob = html.Blob([bytes], 'application/pdf');
    return blob;
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
                  "User ID : ${widget.id}",
                  style: TextStyle(
                    fontSize: 20,
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
          Container(
              padding: EdgeInsets.only(
                left: size.width * 0.015,
                right: size.width * 0.015,
              ),
              height: size.height * 0.6,
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
                      width: 330,
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
                              "Personal Detail",
                              style: TextStyle(
                                color: currentTab == 0
                                    ? MyColors.red
                                    : MyColors.secondaryNew,
                                fontSize: currentTab == 0 ? 24 : 20,
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
                              "Company Detail",
                              style: TextStyle(
                                color: currentTab == 1
                                    ? MyColors.red
                                    : MyColors.secondaryNew,
                                fontSize: currentTab == 1 ? 24 : 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.011),
                    Container(
                      padding: EdgeInsets.only(
                        left: size.width * 0.015,
                        right: size.width * 0.015,
                      ),
                      height: size.height * 0.5,
                      width: size.width,
                      child: currentTab == 0
                          ? personalDetailCard(size)
                          : companyDetailCard(size),
                    )
                  ]))),
          SizedBox(height: size.height * 0.011),
          Container(
            height: size.height * 0.1,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(7),
                bottomRight: Radius.circular(7),
              ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final url = html.Url.createObjectUrlFromBlob(
                          await myGetBlobPdfContent(size));
                      html.window.open(url, "_blank");
                      html.Url.revokeObjectUrl(url);
                      // final url = html.Url.createObjectUrlFromBlob(
                      //     await myGetBlobPdfContent(size));
                      // final anchor =
                      //     html.document.createElement('a') as html.AnchorElement
                      //       ..href = url
                      //       ..style.display = 'none'
                      //       ..download = '${widget.name}.pdf';
                      // html.document.body.children.add(anchor);
                      // anchor.click();
                      // html.document.body.children.remove(anchor);
                      // html.Url.revokeObjectUrl(url);
                    },
                    child: Container(
                      // width: size.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(7),
                        ),
                        color: MyColors.primaryNew,
                      ),
                      child: Center(
                          child: Text("Export Details",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ))),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(widget.email)
                          .update({"verifiedUser": false});
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "User DISAPPROVED",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        elevation: 0,
                        duration: Duration(seconds: 2),
                        backgroundColor: MyColors.primaryNew,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5))),
                      ));
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      // width: size.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(7),
                        ),
                        color: MyColors.primaryNew,
                      ),
                      child: Center(
                          child: Text("Disapprove User",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }

  personalDetailCard(Size size) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Row(
          children: [
            Container(
              width: size.width * 0.085,
              child: Text(
                "User ID",
                style: TextStyle(color: MyColors.secondary, fontSize: 18),
              ),
            ),
            Expanded(
              // width: size.width * 0.2,
              child: Text(
                widget.id,
                style: TextStyle(color: Color(0xff4d4d4d), fontSize: 18),
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        Row(
          children: [
            Container(
              width: size.width * 0.085,
              child: Text(
                "Name",
                style: TextStyle(color: MyColors.secondary, fontSize: 18),
              ),
            ),
            Expanded(
              // width: size.width * 0.2,
              child: Hero(
                tag: "adminApprovedTransporterName" + widget.uid,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    widget.name,
                    style: TextStyle(color: Color(0xff4d4d4d), fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        Row(
          children: [
            Container(
              width: size.width * 0.085,
              child: Text(
                "Phone No.",
                style: TextStyle(color: MyColors.secondary, fontSize: 18),
              ),
            ),
            Expanded(
              // width: size.width * 0.2,
              child: Hero(
                tag: "adminApprovedTransporterNumber" + widget.uid,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    widget.phone,
                    style: TextStyle(color: Color(0xff4d4d4d), fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        Row(
          children: [
            Container(
              width: size.width * 0.085,
              child: Text(
                "Email ID",
                style: TextStyle(color: MyColors.secondary, fontSize: 18),
              ),
            ),
            Expanded(
              // width: size.width * 0.2,
              child: Text(
                widget.email,
                style: TextStyle(color: Color(0xff4d4d4d), fontSize: 18),
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        Row(
          children: [
            Container(
              width: size.width * 0.085,
              child: Text(
                "Registration Date",
                style: TextStyle(color: MyColors.secondary, fontSize: 18),
              ),
            ),
            Expanded(
              // width: size.width * 0.2,
              child: Hero(
                tag: "adminApprovedTransporterDate" + widget.uid,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    widget.createdAt,
                    style: TextStyle(color: Color(0xff4d4d4d), fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
      ],
    ));
  }

  companyDetailCard(Size size) {
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    width: size.width * 0.1,
                    child: Text(
                      "Company Name",
                      style: TextStyle(color: MyColors.secondary, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    // width: size.width * 0.2,
                    child: Text(
                      widget.companyName,
                      style: TextStyle(color: Color(0xff4d4d4d), fontSize: 18),
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
                    width: size.width * 0.1,
                    child: Text(
                      "Company Type",
                      style: TextStyle(color: MyColors.secondary, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    // width: size.width * 0.2,
                    child: Text(
                      widget.companyType,
                      style: TextStyle(color: Color(0xff4d4d4d), fontSize: 18),
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
                    width: size.width * 0.1,
                    child: Text(
                      "Registration No.",
                      style: TextStyle(color: MyColors.secondary, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    // width: size.width * 0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.registrationNumber,
                          style:
                              TextStyle(color: Color(0xff4d4d4d), fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            html.AnchorElement anchorElement =
                                new html.AnchorElement(href: widget.regUrl);
                            anchorElement.download = widget.regUrl;
                            anchorElement.target = "__blank";
                            anchorElement.click();
                          },
                          child: Text(
                            "View",
                            style: TextStyle(
                                color: MyColors.primaryNew, fontSize: 18),
                          ),
                        ),
                      ],
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
                    width: size.width * 0.1,
                    child: Text(
                      "PAN No.",
                      style: TextStyle(color: MyColors.secondary, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    // width: size.width * 0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.pan,
                          style:
                              TextStyle(color: Color(0xff4d4d4d), fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            html.AnchorElement anchorElement =
                                new html.AnchorElement(href: widget.panUrl);
                            anchorElement.download = widget.panUrl;
                            anchorElement.target = "__blank";
                            anchorElement.click();
                          },
                          child: Text(
                            "View",
                            style: TextStyle(
                                color: MyColors.primaryNew, fontSize: 18),
                          ),
                        ),
                      ],
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
        ]));
  }
}
