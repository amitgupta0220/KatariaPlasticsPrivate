import 'dart:math';
import 'package:KPPL/HomePage/ViewOpenConsignment.dart';
import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoder/geocoder.dart';

class AddConsignment extends StatefulWidget {
  @override
  _AddConsignmentState createState() => _AddConsignmentState();
}

class _AddConsignmentState extends State<AddConsignment> {
  bool autoValidate = false;
  int consignmentNumber;
  int currentIndex = 0;
  String temp = "hi ";
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
  // final Geolocator _geolocator = Geolocator();

  @override
  void initState() {
    super.initState();
    getCOnsignmentNumber();
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
                  .where("status", isEqualTo: "open")
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

  Widget tabForCompletedConsignment(Size size) {
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
              tag: "idCompleteConsignment",
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
              tag: "assignedToIDCompleteConsignment",
              child: Material(
                color: Colors.transparent,
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: size.width * 0.25,
                  child: Text("Assigned To ID"),
                ),
              ),
            ),
            Hero(
              tag: "assignedToCompleteConsignment",
              child: Material(
                color: Colors.transparent,
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: size.width * 0.25,
                  child: Text("Assigned To"),
                ),
              ),
            ),
            Hero(
              tag: "statusCompleteConsignment",
              child: Material(
                color: Colors.transparent,
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: size.width * 0.1,
                  child: Text("Status"),
                ),
              ),
            ),
          ]),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('consignment')
                  .where("status", isEqualTo: "ongoing")
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
                    var dropLocation = user.data()['dropLocation'];
                    var pickUpLocation = user.data()['pickUpLocation'];
                    var status = user.data()['status'];
                    var finalPrice = user.data()['finalPrice'];
                    var id = user.id;
                    transporterWidget.add(ConsignmentComplete(
                      id: id,
                      assignedTo: assignedTo,
                      assignedToID: assignedToID,
                      finalPrice: finalPrice,
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

  Widget tabForCreateConsignment(Size size) {
    return Container(
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
                    labelText:
                        'Consignment Number: ' + consignmentNumber.toString(),
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
                        "currentMinBidBy": "Admin",
                        "currentMinBidByID": "Admin",
                        "dropLocation": dropLocationController.text.trim(),
                        "pickUpLocation": pickUpLocationController.text.trim(),
                        "status": "open",
                        "description": descriptionController.text.trim(),
                        "date": selectedDate.millisecondsSinceEpoch.toString(),
                        "truckDetail": truckDetailsController.text.trim(),
                        "load": loadController.text.trim(),
                        "price": priceController.text.trim(),
                        "created_at":
                            DateTime.now().millisecondsSinceEpoch.toString(),
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
            ],
          ),
        ),
      ),
    );
  }

  // getDistance(var pickUp, var drop, var _apiKey) async {
  //   Dio dio = Dio();

  //   Response pickupResult = await dio.get(
  //       'https://maps.googleapis.com/maps/api/geocode/json?address=$pickUp&region=in&key=$_apiKey');

  //   // print(pickupResult.data);
  //   Response dropResult = await dio.get(
  //       'https://maps.googleapis.com/maps/api/geocode/json?address=$drop&region=in&key=$_apiKey');

  //   // print(dropResult.data);
  //   // print(dropResult.data['results'][0]['geometry']['location']['lat']
  //   //     .toString());

  //   final plat = pickupResult.data['results'][0]['geometry']['location']['lat'];
  //   final plng = pickupResult.data['results'][0]['geometry']['location']['lng'];
  //   final dlat = dropResult.data['results'][0]['geometry']['location']['lat'];
  //   final dlng = dropResult.data['results'][0]['geometry']['location']['lng'];
  //   print('($plat, $plng), ($dlat, $dlng)');

  //   Response responseDistance = await dio.get(
  //       'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=mumbai%2cindia&destinations=nashik%2cindia&key=$_apiKey',
  //       options: Options(headers: {
  //         "Access-Control-Allow-Origin": "*",
  //       }));

  //   print(responseDistance.data);

  //   // print(responseDistance.data['rows'][0]['elements'][0]['distance']['text'].toString());
  //   // print(responseDistance.data['rows'][0]['elements'][0]['duration']['text'].toString());
  // }

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
                            "Open",
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
                            "Completed",
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
                            "Delievered",
                            style: TextStyle(
                                fontSize: 26,
                                color: currentIndex == 2
                                    ? MyColors.primary
                                    : MyColors.secondaryNew),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 3;
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
                                color: currentIndex == 3
                                    ? MyColors.primary
                                    : MyColors.secondaryNew),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 4;
                          });
                          // getDistance('mumbai, india', 'nashik, india');,
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.01,
                          ),
                          child: Text(
                            "Create",
                            style: TextStyle(
                                fontSize: 26,
                                color: currentIndex == 4
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
                // Text(temp),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.02,
                // ),
                currentIndex == 0 ? tabForOpenConsignment(size) : Container(),
                currentIndex == 4 ? tabForCreateConsignment(size) : Container(),
                currentIndex == 1
                    ? tabForCompletedConsignment(size)
                    : Container(),
              ])),
        ));
  }
}

class ConsignmentOpen extends StatelessWidget {
  ConsignmentOpen(
      {this.assignedTo,
      this.id,
      this.assignedToID,
      this.pickUpLocation,
      this.currentMinBid,
      this.currentMinBidBy,
      this.currentMinBidByID,
      this.dropLocation,
      this.status});

  final String assignedTo,
      assignedToID,
      currentMinBid,
      currentMinBidBy,
      currentMinBidByID,
      dropLocation,
      pickUpLocation,
      status,
      id;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_) => ViewOpenConsignment(
                      currentBid: currentMinBid,
                      dropLocation: dropLocation,
                      pickUpLocation: pickUpLocation,
                      currentBidBy: currentMinBidBy,
                      id: id,
                      status: status,
                    )),
          );
        },
        child: Column(children: [
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
                  tag: "idOpenConsignmentValue" + id,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: size.width * 0.25,
                      child: Text(
                        id,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(color: MyColors.secondary, fontSize: 14),
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: "statusOpenConsignmentValue" + id,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: size.width * 0.25,
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(color: Colors.green, fontSize: 14),
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: "currentMinBidByOpenConsignmentValue" + id,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: size.width * 0.25,
                      child: Text(
                        currentMinBidBy,
                        style:
                            TextStyle(color: MyColors.secondary, fontSize: 14),
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: "currentMinOpenConsignmentValue" + id,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: size.width * 0.1,
                      child: Text(
                        currentMinBid,
                        style:
                            TextStyle(color: MyColors.secondary, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: MyColors.secondaryNew,
            height: 2,
          )
        ]));
  }
}

class ConsignmentComplete extends StatelessWidget {
  ConsignmentComplete(
      {this.id,
      this.assignedTo,
      this.assignedToID,
      this.finalPrice,
      this.pickUpLocation,
      this.dropLocation,
      this.status});

  final String dropLocation,
      pickUpLocation,
      status,
      id,
      assignedTo,
      assignedToID,
      finalPrice;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //       builder: (_) => ViewOpenConsignment(
          //             currentBid: currentMinBid,
          //             dropLocation: dropLocation,
          //             pickUpLocation: pickUpLocation,
          //             currentBidBy: currentMinBidBy,
          //             id: id,
          //             status: status,
          //           )),
          // );
        },
        child: Column(children: [
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
                  tag: "idCompleteConsignmentValue" + id,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: size.width * 0.25,
                      child: Text(
                        id,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(color: MyColors.secondary, fontSize: 14),
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: "assignedToIDCompleteConsignmentValue" + id,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: size.width * 0.25,
                      child: Text(
                        assignedToID,
                        style:
                            TextStyle(color: MyColors.secondary, fontSize: 14),
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: "assignedToCompleteConsignmentValue" + id,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: size.width * 0.25,
                      child: Text(
                        assignedTo,
                        style:
                            TextStyle(color: MyColors.secondary, fontSize: 14),
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: "statusCompleteConsignmentValue" + id,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: size.width * 0.1,
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: MyColors.secondaryNew,
            height: 2,
          )
        ]));
  }
}
