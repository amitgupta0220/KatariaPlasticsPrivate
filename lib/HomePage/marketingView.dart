import 'dart:math';

import 'package:KPPL/authentication/authenticate.dart';
import 'package:KPPL/styles.dart';
import 'package:KPPL/views/NewLogin.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'AddConsignment.dart';

class MarketingView extends StatefulWidget {
  @override
  _MarketingViewState createState() => _MarketingViewState();
}

class _MarketingViewState extends State<MarketingView> {
  bool autoValidate = false;
  int consignmentNumber;
  int currentIndex = 0;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dropLocationController = TextEditingController();
  bool gotNumber = false;
  final TextEditingController loadController = TextEditingController();
  final TextEditingController pickUpLocationController =
      TextEditingController();

  final TextEditingController priceController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final TextEditingController truckDetailsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => setState(
                        () {
                          _currentIndex = 0;
                        },
                      ),
                      child: Container(
                        margin: EdgeInsets.all(2),
                        child: Text(
                          "Start Campaign",
                          style: TextStyle(
                              fontSize: 26,
                              color: _currentIndex == 0
                                  ? MyColors.primary
                                  : MyColors.secondaryNew),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => setState(
                        () {
                          _currentIndex = 1;
                        },
                      ),
                      child: Container(
                        margin: EdgeInsets.all(2),
                        child: Text(
                          "Open Bids",
                          style: TextStyle(
                              fontSize: 26,
                              color: _currentIndex == 1
                                  ? MyColors.primary
                                  : MyColors.secondaryNew),
                        ),
                      ),
                    ),
                  ],
                ),
                ///////////////////////////////////////////
                _currentIndex == 1 ? tabForOpenConsignment(size) : Container(),
                _currentIndex == 0
                    ? tabForCreateConsignment(size)
                    : Container(),
              ],
            ),
          )),
    );
  }

  Widget tabForCreateConsignment(Size size) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.height * 0.01,
              right: MediaQuery.of(context).size.height * 0.01,
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(size.width * 0.01),
                      width: size.width * 0.45,
                      child: TextFormField(
                        enabled: false,
                        autocorrect: autoValidate,
                        // autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                          labelText: 'Consignment Number: ' +
                              consignmentNumber.toString(),
                          labelStyle: TextStyle(
                            color: Color(0xFF03045E),
                          ),
                          prefixText: '  ',
                          contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF03045E),
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF03045E))),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),

                        // controller: consignmentIdController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(size.width * 0.01),
                      width: size.width * 0.45,
                      child: TextFormField(
                        autocorrect: autoValidate,
                        // autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                          labelText: "Description",
                          labelStyle: TextStyle(
                            color: Color(0xFF03045E),
                          ),
                          prefixText: '  ',
                          contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF03045E),
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF03045E))),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter valid value";
                          }
                          return null;
                        },
                        controller: descriptionController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    //date picker

                    ///
                    Container(
                      padding: EdgeInsets.all(size.width * 0.01),
                      width: size.width * 0.45,
                      child: TextFormField(
                        autocorrect: autoValidate,
                        // autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                          labelText: "Pick Up Location",
                          labelStyle: TextStyle(
                            color: Color(0xFF03045E),
                          ),
                          prefixText: '  ',
                          contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF03045E),
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF03045E))),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter valid value";
                          }
                          return null;
                        },
                        controller: pickUpLocationController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(size.width * 0.01),
                      width: size.width * 0.45,
                      child: TextFormField(
                        autocorrect: autoValidate,
                        // autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                          labelText: "Drop Location",
                          labelStyle: TextStyle(
                            color: Color(0xFF03045E),
                          ),
                          prefixText: '  ',
                          contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF03045E),
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF03045E))),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter valid value";
                          }
                          return null;
                        },
                        controller: dropLocationController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(size.width * 0.01),
                      width: size.width * 0.45,
                      child: TextFormField(
                        autocorrect: autoValidate,
                        // autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                          labelText: "Truck Details",
                          labelStyle: TextStyle(
                            color: Color(0xFF03045E),
                          ),
                          prefixText: '  ',
                          contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF03045E),
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF03045E))),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter valid value";
                          }
                          return null;
                        },
                        controller: truckDetailsController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(size.width * 0.01),
                      width: size.width * 0.45,
                      child: TextFormField(
                        autocorrect: autoValidate,
                        // autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                          labelText: "Load Details",
                          labelStyle: TextStyle(
                            color: Color(0xFF03045E),
                          ),
                          prefixText: '  ',
                          contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF03045E),
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF03045E))),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter valid value";
                          }
                          return null;
                        },
                        controller: loadController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(size.width * 0.01),
                      width: size.width * 0.45,
                      child: TextFormField(
                        autocorrect: autoValidate,
                        // autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                          labelText: "Price",
                          labelStyle: TextStyle(
                            color: Color(0xFF03045E),
                          ),
                          prefixText: '  ',
                          contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF03045E),
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF03045E))),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter valid value";
                          }
                          return null;
                        },
                        controller: priceController,
                        keyboardType: TextInputType.text,
                      ),
                    ),

                    FlatButton(
                        color: MyColors.primary,
                        onPressed: () async {
                          _selectDate(context);
                        },
                        child: Text(
                          "Click To select date",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                    selectedDate != null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${selectedDate.toLocal()}".split(' ')[0],
                              style: TextStyle(
                                color: Color(0xFF03045E),
                              ),
                            ),
                          )
                        : Container(),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          // getDistance('mumbai, india', 'nashik, india');
                          if (_formKey.currentState.validate()) {
                            await FirebaseFirestore.instance
                                .collection("consignment")
                                .doc(consignmentNumber.toString())
                                .set({
                              "assignedTo": null,
                              "assignedToID": null,
                              "currentMinBid": priceController.text.trim(),
                              "currentMinBidBy": "Admin", //add role
                              "currentMinBidByID": "Admin", //add role
                              "dropLocation":
                                  dropLocationController.text.trim(),
                              "pickUpLocation":
                                  pickUpLocationController.text.trim(),
                              "status": "open",
                              "description": descriptionController.text.trim(),
                              "date": selectedDate.toLocal(),
                              "truckDetail": truckDetailsController.text.trim(),
                              "load": loadController.text.trim(),
                              "price": priceController.text.trim()
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
                            descriptionController.clear();
                            dropLocationController.clear();
                            loadController.clear();
                            pickUpLocationController.clear();
                            priceController.clear();
                            truckDetailsController.clear();
                            getCOnsignmentNumber();
                          } else {
                            setState(() {
                              autoValidate = true;
                            });
                          }
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
                                "Create",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        AuthService().signOut();
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => LoginPageTab()));
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
                              "LOGOUT",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[350],
                    blurRadius: 5.0,
                    offset: Offset(0, 3))
              ],
            ),
            // child: MyMapView(),
            child: Container(),
          ),
        )
      ],
    );
  }

  Widget tabForOpenConsignment(Size size) {
    return Container(
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
              tag: "idOpenConsignment",
              child: Material(
                color: Colors.transparent,
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: size.width * 0.25,
                  child: Text("ID"),
                ),
              ),
            ),
            Hero(
              tag: "statusOpenConsignment",
              child: Material(
                color: Colors.transparent,
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: size.width * 0.25,
                  child: Text("Status"),
                ),
              ),
            ),
            Hero(
              tag: "currentMinBidByOpenConsignment",
              child: Material(
                color: Colors.transparent,
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: size.width * 0.25,
                  child: Text("Current Bid By"),
                ),
              ),
            ),
            Hero(
              tag: "currentMinOpenConsignment",
              child: Material(
                color: Colors.transparent,
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: size.width * 0.1,
                  child: Text("Current Bid"),
                ),
              ),
            ),
          ]),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('consignment')
                  // .where("userType", isEqualTo: "transporter")
                  // .where("verifiedUser", isEqualTo: false)
                  // .orderBy('created_at', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                List<Widget> transporterWidget = [];
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  final userData = snapshot.data.docs;
                  userData.forEach((user) {
                    var assignedTo = user.data()['assignedTo'];
                    var assignedToID = user.data()['assignedToID'];
                    var currentMinBid = user.data()['currentMinBid'];
                    var currentMinBidBy = user.data()['currentMinBidBy'];
                    var currentMinBidByID = user.data()['currentMinBidByID'];
                    var dropLocation = user.data()['dropLocation'];
                    var pickUpLocation = user.data()['pickUpLocation'];
                    var status = user.data()['status'];
                    var id = user.id;
                    transporterWidget.add(ConsignmentOpen(
                      id: id,
                      assignedTo: assignedTo,
                      assignedToID: assignedToID,
                      currentMinBid: currentMinBid,
                      currentMinBidBy: currentMinBidBy,
                      currentMinBidByID: currentMinBidByID,
                      dropLocation: dropLocation,
                      pickUpLocation: pickUpLocation,
                      status: status,
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
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  getCOnsignmentNumber() async {
    consignmentNumber = Random().nextInt(100000000);
    await FirebaseFirestore.instance
        .collection("consignment")
        .doc(consignmentNumber.toString())
        .get()
        .then((value) {
      if (value.exists) {
        do {
          getCOnsignmentNumber();
        } while (gotNumber);
      } else {
        setState(() {
          gotNumber = true;
        });
      }
    });
  }
}
