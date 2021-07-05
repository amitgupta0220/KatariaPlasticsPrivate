import 'dart:convert';
import 'dart:math';
import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MobileAdminCreateConsignment extends StatefulWidget {
  @override
  _MobileAdminCreateConsignmentState createState() =>
      _MobileAdminCreateConsignmentState();
}

class _MobileAdminCreateConsignmentState
    extends State<MobileAdminCreateConsignment> {
  int consignmentNumber;
  String resultId;
  bool gotNumber = false, autoValidate = false;
  final _descriptionController = TextEditingController();
  final _pickUpController = TextEditingController();
  final _dropController = TextEditingController();
  final _truckController = TextEditingController();
  final _truckNumberController = TextEditingController();
  final _loadController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  String adminId;

  getConsignmentNumber() async {
    consignmentNumber = Random().nextInt(100000000);
    await FirebaseFirestore.instance
        .collection("consignment")
        .doc(consignmentNumber.toString())
        .get()
        .then((value) {
      if (value.exists) {
        do {
          getConsignmentNumber();
        } while (gotNumber);
      } else {
        FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser.email)
            .get()
            .then((value) {
          if (mounted)
            setState(() {
              gotNumber = true;
              adminId = value.data()["userID"];
            });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getConsignmentNumber();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(children: [
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
                              "Create Consignment",
                              style: TextStyle(
                                  color: MyColors.primaryNew,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                        height: size.height * 0.6,
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.only(
                          //   bottomLeft: Radius.circular(7),
                          //   bottomRight: Radius.circular(7),
                          // ),
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
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      style: TextStyle(fontSize: 15),
                                      controller: _descriptionController,
                                      autocorrect: autoValidate,
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Enter valid description";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          filled: true,
                                          hoverColor: Colors.transparent,
                                          fillColor: Colors.white,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: MyColors.secondaryNew),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: MyColors.secondaryNew),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xffB3B3B3)),
                                          // hintText: 'abc@def.com',
                                          hintText: "Description"),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 5),
                                          width: size.width * 0.28,
                                          child: TextFormField(
                                            style: TextStyle(fontSize: 15),
                                            controller: _pickUpController,
                                            autocorrect: autoValidate,
                                            keyboardType: TextInputType.name,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Enter valid location";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                filled: true,
                                                hoverColor: Colors.transparent,
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: MyColors
                                                          .secondaryNew),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: MyColors
                                                          .secondaryNew),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xffB3B3B3)),
                                                // hintText: 'abc@def.com',
                                                hintText: "Pick up Location"),
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: size.height * 0.02,
                                        // ),
                                        Expanded(
                                          child: TextFormField(
                                            style: TextStyle(fontSize: 15),
                                            controller: _dropController,
                                            autocorrect: autoValidate,
                                            keyboardType: TextInputType.name,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Enter valid location";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                filled: true,
                                                hoverColor: Colors.transparent,
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: MyColors
                                                          .secondaryNew),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: MyColors
                                                          .secondaryNew),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xffB3B3B3)),
                                                // hintText: 'abc@def.com',
                                                hintText: "Drop Location"),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              if (_pickUpController.text
                                                      .trim()
                                                      .isNotEmpty &&
                                                  _dropController.text
                                                      .trim()
                                                      .isNotEmpty) {
                                                FirebaseFirestore.instance
                                                    .collection("data")
                                                    .add({
                                                  "startAddress":
                                                      _pickUpController.text
                                                          .trim(),
                                                  "endAddress": _dropController
                                                      .text
                                                      .trim(),
                                                }).then((value) {
                                                  resultId = value.id;
                                                  setState(() {});
                                                });
                                              }
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: MyColors.primaryNew,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2)),
                                                padding: EdgeInsets.all(8),
                                                // width: 100,
                                                // height: 30,
                                                child: Text(
                                                  "Calculate Distance",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ))),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        resultId != null
                                            ? StreamBuilder<DocumentSnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('result')
                                                    .doc(resultId)
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                  if (snapshot.hasData) {
                                                    if (snapshot.data.exists) {
                                                      final consignmentData =
                                                          snapshot.data;
                                                      var temp = json.decode(
                                                          consignmentData
                                                                  .data()[
                                                              "success"]);
                                                      if (temp["status"] ==
                                                          "REQUEST_DENIED") {
                                                        return Text(
                                                            "Please retry");
                                                      } else {
                                                        return Text(json
                                                            .decode(
                                                                consignmentData
                                                                        .data()[
                                                                    "success"])[
                                                                "rows"][0]
                                                                ["elements"][0]
                                                                ["distance"]
                                                                ["text"]
                                                            .toString());
                                                      }
                                                    }
                                                  }
                                                  return Container();
                                                })
                                            : Container(),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    TextFormField(
                                      style: TextStyle(fontSize: 15),
                                      controller: _truckController,
                                      autocorrect: autoValidate,
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Enter valid details";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          filled: true,
                                          hoverColor: Colors.transparent,
                                          fillColor: Colors.white,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: MyColors.secondaryNew),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: MyColors.secondaryNew),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xffB3B3B3)),
                                          // hintText: 'abc@def.com',
                                          hintText: "Truck Details"),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 5),
                                          width: size.width * 0.28,
                                          child: TextFormField(
                                            style: TextStyle(fontSize: 15),
                                            controller: _loadController,
                                            autocorrect: autoValidate,
                                            keyboardType: TextInputType.name,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Enter valid load details";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                filled: true,
                                                hoverColor: Colors.transparent,
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: MyColors
                                                          .secondaryNew),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: MyColors
                                                          .secondaryNew),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xffB3B3B3)),
                                                // hintText: 'abc@def.com',
                                                hintText: "Load"),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            style: TextStyle(fontSize: 15),
                                            controller: _priceController,
                                            autocorrect: autoValidate,
                                            keyboardType: TextInputType.number,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Enter valid price";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                filled: true,
                                                hoverColor: Colors.transparent,
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: MyColors
                                                          .secondaryNew),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: MyColors
                                                          .secondaryNew),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xffB3B3B3)),
                                                // hintText: 'abc@def.com',
                                                hintText: "Amount"),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 8),
                                          width: size.width * 0.35,
                                          child: TextFormField(
                                            style: TextStyle(fontSize: 15),
                                            controller: _truckNumberController,
                                            autocorrect: autoValidate,
                                            keyboardType: TextInputType.number,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Enter valid number";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                filled: true,
                                                hoverColor: Colors.transparent,
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: MyColors
                                                          .secondaryNew),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: MyColors
                                                          .secondaryNew),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xffB3B3B3)),
                                                // hintText: 'abc@def.com',
                                                hintText: "Number of Trucks"),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              FlatButton(
                                                  color: MyColors.primaryNew,
                                                  onPressed: () async {
                                                    _selectDate(context);
                                                  },
                                                  child: Text(
                                                    "Click To select date",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              _selectedDate != null
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "${_selectedDate.toLocal()}"
                                                            .split(' ')[0],
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                        )),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState.validate()) {
                          await FirebaseFirestore.instance
                              .collection("consignment")
                              .doc(consignmentNumber.toString())
                              .set({
                            "assignedTo": null,
                            "assignedToName": null,
                            "assignedToID": null,
                            "deliveredImageUrl": null,
                            "currentMinBid": _priceController.text.trim(),
                            "currentMinBidBy": "Admin",
                            "currentMinBidByID":
                                adminId == null ? "7856924" : adminId,
                            "dropLocation": _dropController.text.trim(),
                            "pickUpLocation": _pickUpController.text.trim(),
                            "status": "open",
                            "description": _descriptionController.text.trim(),
                            "date":
                                _selectedDate.millisecondsSinceEpoch.toString(),
                            "truckDetail": _truckController.text.trim(),
                            "load": _loadController.text.trim(),
                            "price": _priceController.text.trim(),
                            "created_at": DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            "numberOfTruck": _truckNumberController.text.trim(),
                            "deliveryDate": null,
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Created successfully",
                              style: TextStyle(color: Colors.white),
                            ),
                            elevation: 0,
                            duration: Duration(seconds: 2),
                            backgroundColor: MyColors.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    topLeft: Radius.circular(5))),
                          ));
                          _descriptionController.clear();
                          _dropController.clear();
                          _loadController.clear();
                          _pickUpController.clear();
                          _priceController.clear();
                          _truckController.clear();
                          _truckNumberController.clear();
                          getConsignmentNumber();
                        } else {
                          setState(() {
                            autoValidate = true;
                          });
                        }
                      },
                      child: Container(
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
                            color: MyColors.primaryNew,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(7),
                              bottomRight: Radius.circular(7),
                            )),
                        padding: EdgeInsets.all(
                          size.height * 0.02,
                        ),
                        margin: EdgeInsets.only(
                          top: size.height * 0.01,
                        ),
                        child: Center(
                          child: Text(
                            "Create Consignment",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ]))),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }
}
