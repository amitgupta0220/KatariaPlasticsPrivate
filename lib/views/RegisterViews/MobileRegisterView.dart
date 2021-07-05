import 'dart:html';
import 'dart:math';

import 'package:KPPL/TransporterHomePage/TransporterNavPage.dart';
import 'package:KPPL/authentication/UserModel.dart';
import 'package:KPPL/authentication/authenticate.dart';
import 'package:KPPL/styles.dart';
import 'package:KPPL/views/NewLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MobileRegisterPageTab extends StatefulWidget {
  @override
  _MobileRegisterPageTabState createState() => _MobileRegisterPageTabState();
}

class _MobileRegisterPageTabState extends State<MobileRegisterPageTab>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKeyMobile = GlobalKey<ScaffoldState>();
  bool showPass = true, otpSent = false, clickResend = false;
  AnimationController _animationController;
  Animation _animation;
  ConfirmationResult confirmationResult;
  String currentText = "";
  // bool _autoValidate = false;
  // final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final otpController = TextEditingController();
  final companyNameController = TextEditingController();
  final companyTypeController = TextEditingController();
  final _addressController = TextEditingController();
  final _passController = TextEditingController();
  final _regController = TextEditingController();
  final _panController = TextEditingController();
  int _currentIndex = 0;
  String dropdownCompanyType = 'Sole Proprietor';
  String dropdownRegistration = 'Incorporation Certificate';
  PageController _pageController = PageController(initialPage: 0);
  String panUrl, docUrl;
  File fileDoc, fileDocPan;
  int userID;
  bool gotNumber = false;
  double spinning = 0;

  checkUserExists() async {
    final value = await FirebaseFirestore.instance
        .collection("users")
        .doc(_emailController.text.trim())
        .get();
    if (value.exists) {
      return true;
    } else {
      return false;
    }
  }

  void _showPickerDoc() async {
    InputElement ie = FileUploadInputElement()..accept = 'image/*';
    ie.click();
    ie.onChange.listen((event) {
      fileDoc = ie.files.first;
      final reader = FileReader();
      reader.readAsDataUrl(fileDoc);
      reader.onLoadEnd.listen((event) {
        setState(() {});
      });
    });
  }

  void _showPickerDocPan() async {
    InputElement ie = FileUploadInputElement()..accept = 'image/*';
    ie.click();
    ie.onChange.listen((event) {
      fileDocPan = ie.files.first;
      final reader = FileReader();
      reader.readAsDataUrl(fileDocPan);
      reader.onLoadEnd.listen((event) {
        setState(() {});
        // FirebaseStorage.instance
        //     .refFromURL("gs://logistics-katariaplastics.appspot.com/")
        //     .child("/images/${DateTime.now().microsecondsSinceEpoch}")
        //     .putBlob(fileDoc);
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getUserNumber();
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _animation = Tween<Offset>(begin: Offset(-100, 0), end: Offset(0, 0))
        .animate(_animationController);
    _animationController.forward().whenComplete(() {});
  }

  getUserNumber() async {
    userID = Random().nextInt(100000000);
    await FirebaseFirestore.instance
        .collection("users")
        .where("userID", isEqualTo: userID)
        .get()
        .then((value) {
      if (value.docs.length != 0) {
        do {
          getUserNumber();
        } while (gotNumber);
      } else {
        setState(() {
          gotNumber = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          key: _scaffoldKeyMobile,
          backgroundColor: Color(0xffffeeee),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/logo.png",
                    height: size.height * 0.13,
                  ),
                ),
                Hero(
                  tag: "signUpFromLogin",
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      height: size.height * 0.75,
                      margin: EdgeInsets.only(
                        left: size.width * 0.05,
                        right: size.width * 0.05,
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(size.width * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(
                              0,
                              1,
                            ),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(1.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    _currentIndex == 0
                                        ? Text(
                                            "Personal Details",
                                            style: TextStyle(
                                                color: MyColors.red,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(
                                            "",
                                            style: TextStyle(
                                                color: MyColors.red,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                    Container(
                                      width: _currentIndex == 0
                                          ? size.width * 0.5
                                          : size.width * 0.072,
                                      height: 2,
                                      color: MyColors.red,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(1.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    _currentIndex == 1
                                        ? Text(
                                            "Company Details",
                                            style: TextStyle(
                                                color: MyColors.red,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(
                                            "",
                                            style: TextStyle(
                                                color: MyColors.red,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      child: Container(
                                        width: _currentIndex == 1
                                            ? size.width * 0.5
                                            : size.width * 0.072,
                                        height: 2,
                                        color: MyColors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(1.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    _currentIndex == 2
                                        ? Text(
                                            "Upload Documents",
                                            style: TextStyle(
                                                color: MyColors.red,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(
                                            "",
                                            style: TextStyle(
                                                color: MyColors.red,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                    Container(
                                      width: _currentIndex == 2
                                          ? size.width * 0.5
                                          : size.width * 0.072,
                                      height: 2,
                                      color: MyColors.red,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(1.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _currentIndex == 3
                                        ? Text(
                                            "Phone Verification",
                                            style: TextStyle(
                                                color: MyColors.red,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(
                                            "",
                                            style: TextStyle(
                                                color: MyColors.red,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      child: Container(
                                        width: _currentIndex == 3
                                            ? size.width * 0.5
                                            : size.width * 0.072,
                                        height: 2,
                                        color: MyColors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                              child: Container(
                            // margin: EdgeInsets.only(bottom: size.height * 0.15),
                            child: PageView.builder(
                              controller: _pageController,
                              onPageChanged: (index) =>
                                  setState(() => _currentIndex = index),
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (_, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    index == 0
                                        ? SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: size.height * 0.02,
                                                ),
                                                TextFormField(
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                  controller: _nameController,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      fillColor: Colors.white,
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: MyColors
                                                                .secondaryNew),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                      hintStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: Color(
                                                              0xffB3B3B3)),
                                                      // hintText: 'abc@def.com',
                                                      labelText: "Full Name"),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.02,
                                                ),
                                                TextFormField(
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                  controller:
                                                      _addressController,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      fillColor: Colors.white,
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: MyColors
                                                                .secondaryNew),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                      hintStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: Color(
                                                              0xffB3B3B3)),
                                                      // hintText: 'abc@def.com',
                                                      labelText: "Address"),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.02,
                                                ),
                                                TextFormField(
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                  controller: _emailController,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      fillColor: Colors.white,
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: MyColors
                                                                .secondaryNew),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                      hintStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: Color(
                                                              0xffB3B3B3)),
                                                      // hintText: 'abc@def.com',
                                                      labelText:
                                                          "Email Address"),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.02,
                                                ),
                                                TextFormField(
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                  controller: _passController,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return "Enter valid password";
                                                    } else if (value.length <
                                                        6) {
                                                      return "Enter minimum 6 letter password";
                                                    }
                                                    return null;
                                                  },
                                                  obscureText: showPass,
                                                  obscuringCharacter: '*',
                                                  decoration: InputDecoration(
                                                      suffixIcon: IconButton(
                                                        icon: showPass
                                                            ? Icon(Icons
                                                                .remove_red_eye)
                                                            : Icon(Icons
                                                                .no_encryption_outlined),
                                                        onPressed: () {
                                                          setState(() {
                                                            showPass =
                                                                !showPass;
                                                          });
                                                        },
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: MyColors
                                                                .secondaryNew),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)),
                                                      hintStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: Color(
                                                              0xffB3B3B3)),
                                                      // hintText: 'abc@def.com',
                                                      labelText: "Password"),
                                                ),
                                              ],
                                            ),
                                          )
                                        : index == 1
                                            ? SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                                    Container(
                                                      height: 55,
                                                      child: TextFormField(
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                        controller:
                                                            companyNameController,
                                                        keyboardType:
                                                            TextInputType.name,
                                                        decoration:
                                                            InputDecoration(
                                                                filled: true,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              MyColors.secondaryNew),
                                                                ),
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4)),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              MyColors.secondaryNew),
                                                                ),
                                                                hintStyle: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Color(
                                                                        0xffB3B3B3)),
                                                                // hintText: 'abc@def.com',
                                                                hintText:
                                                                    "Company Name"),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                                    Container(
                                                      width: size.width,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          color: MyColors
                                                              .secondaryNew,
                                                          border: Border.all(
                                                              color: MyColors
                                                                  .secondaryNew)),
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 8.0,
                                                        right: 8.0,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          DropdownButton<
                                                              String>(
                                                            icon: Container(),
                                                            dropdownColor:
                                                                Colors.white,
                                                            underline:
                                                                Container(),
                                                            value:
                                                                dropdownCompanyType,
                                                            // icon: Icon(Icons.language),
                                                            // isExpanded: true,
                                                            // iconSize: 0,
                                                            elevation: 1,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xffB3B3B3),
                                                            ),

                                                            onChanged: (String
                                                                newValue) {
                                                              setState(() {
                                                                dropdownCompanyType =
                                                                    newValue;
                                                              });
                                                            },
                                                            items: <String>[
                                                              'Sole Proprietor',
                                                              'Private Limited',
                                                              'Limited',
                                                              'Other'
                                                            ].map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                              );
                                                            }).toList(),
                                                          ),
                                                          GestureDetector(
                                                            child: Image.asset(
                                                                "assets/dropDown.png"),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                                    dropdownCompanyType ==
                                                            "Other"
                                                        ? Container(
                                                            height: 55,
                                                            child:
                                                                TextFormField(
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                              controller:
                                                                  companyTypeController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .name,
                                                              decoration:
                                                                  InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                MyColors.secondaryNew),
                                                                      ),
                                                                      border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              4)),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                MyColors.secondaryNew),
                                                                      ),
                                                                      hintStyle: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color: Color(
                                                                              0xffB3B3B3)),
                                                                      // hintText: 'abc@def.com',
                                                                      hintText:
                                                                          "Enter Company Type"),
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                              )
                                            : index == 2
                                                ? Expanded(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.02,
                                                          ),
                                                          Container(
                                                            width: size.width,
                                                            height: size.width *
                                                                0.08,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                color: MyColors
                                                                    .secondaryNew,
                                                                border: Border.all(
                                                                    color: MyColors
                                                                        .secondaryNew)),
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              left: 8.0,
                                                              right: 8.0,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                DropdownButton<
                                                                    String>(
                                                                  icon:
                                                                      Container(),
                                                                  dropdownColor:
                                                                      Colors
                                                                          .white,
                                                                  underline:
                                                                      Container(),
                                                                  value:
                                                                      dropdownRegistration,
                                                                  // icon: Icon(Icons.language),
                                                                  // isExpanded: true,
                                                                  // iconSize: 0,
                                                                  elevation: 1,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Color(
                                                                        0xffB3B3B3),
                                                                  ),

                                                                  onChanged: (String
                                                                      newValue) {
                                                                    setState(
                                                                        () {
                                                                      dropdownRegistration =
                                                                          newValue;
                                                                    });
                                                                  },
                                                                  items: <
                                                                      String>[
                                                                    'Incorporation Certificate',
                                                                    'GST',
                                                                    'Registration Certificate'
                                                                  ].map<
                                                                      DropdownMenuItem<
                                                                          String>>((String
                                                                      value) {
                                                                    return DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          value,
                                                                      child: Text(
                                                                          value),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                                GestureDetector(
                                                                  child: Image
                                                                      .asset(
                                                                          "assets/dropDown.png"),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.01,
                                                          ),
                                                          Container(
                                                            height: 55,
                                                            child:
                                                                TextFormField(
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                              controller:
                                                                  _regController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .name,
                                                              decoration:
                                                                  InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                MyColors.secondaryNew),
                                                                      ),
                                                                      border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              4)),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                MyColors.secondaryNew),
                                                                      ),
                                                                      hintStyle: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color: Color(
                                                                              0xffB3B3B3)),
                                                                      // hintText: 'abc@def.com',
                                                                      hintText:
                                                                          "Registration Number"),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.01,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () =>
                                                                _showPickerDoc(),
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .all(8),
                                                              height:
                                                                  size.width *
                                                                      0.08,
                                                              child: FDottedLine(
                                                                  space: 6,
                                                                  strokeWidth: 1,
                                                                  color: MyColors.secondaryNew,
                                                                  child: fileDoc != null
                                                                      ? Center(
                                                                          child: Text(
                                                                              "${fileDoc.name}",
                                                                              style: TextStyle(fontSize: 16, color: MyColors.secondary)),
                                                                        )
                                                                      : Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Image.asset("assets/addDocument.png"),
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
                                                            height:
                                                                size.height *
                                                                    0.02,
                                                          ),
                                                          Container(
                                                            height: 55,
                                                            child:
                                                                TextFormField(
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                              controller:
                                                                  _panController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .name,
                                                              decoration:
                                                                  InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                MyColors.secondaryNew),
                                                                      ),
                                                                      border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              4)),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                MyColors.secondaryNew),
                                                                      ),
                                                                      hintStyle: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color: Color(
                                                                              0xffB3B3B3)),
                                                                      // hintText: 'abc@def.com',
                                                                      hintText:
                                                                          "PAN Number"),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.02,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () =>
                                                                _showPickerDocPan(),
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .all(8),
                                                              height:
                                                                  size.width *
                                                                      0.08,
                                                              child: FDottedLine(
                                                                  space: 6,
                                                                  strokeWidth: 1,
                                                                  color: MyColors.secondaryNew,
                                                                  child: fileDocPan != null
                                                                      ? Center(
                                                                          child: Text(
                                                                              "${fileDocPan.name}",
                                                                              style: TextStyle(fontSize: 16, color: MyColors.secondary)),
                                                                        )
                                                                      : Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Image.asset("assets/addDocument.png"),
                                                                            SizedBox(
                                                                              width: 8,
                                                                            ),
                                                                            Center(
                                                                                child: Text("Upload PAN",
                                                                                    style: TextStyle(
                                                                                      color: MyColors.secondary,
                                                                                      fontSize: 13,
                                                                                    ))),
                                                                          ],
                                                                        )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: size.height *
                                                              0.02,
                                                        ),
                                                        otpSent
                                                            ? Container()
                                                            : TextFormField(
                                                                maxLength: 10,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                                controller:
                                                                    _phoneController,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration:
                                                                    InputDecoration(
                                                                        filled:
                                                                            true,
                                                                        hoverColor:
                                                                            Colors
                                                                                .transparent,
                                                                        fillColor:
                                                                            Colors
                                                                                .white,
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              width: 1,
                                                                              color: MyColors.secondaryNew),
                                                                        ),
                                                                        border: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                4)),
                                                                        hintStyle: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color: Color(
                                                                                0xffB3B3B3)),
                                                                        // hintText: 'abc@def.com',
                                                                        labelText:
                                                                            "Enter phone number"),
                                                              ),
                                                        SizedBox(
                                                          height: size.height *
                                                              0.02,
                                                        ),
                                                        otpSent
                                                            ? TextFormField(
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                                controller:
                                                                    otpController,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration:
                                                                    InputDecoration(
                                                                        filled:
                                                                            true,
                                                                        hoverColor:
                                                                            Colors
                                                                                .transparent,
                                                                        fillColor:
                                                                            Colors
                                                                                .white,
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              width: 1,
                                                                              color: MyColors.secondaryNew),
                                                                        ),
                                                                        border: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                4)),
                                                                        hintStyle: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color: Color(
                                                                                0xffB3B3B3)),
                                                                        // hintText: 'abc@def.com',
                                                                        labelText:
                                                                            "Enter OTP"),
                                                              )
                                                            : Container(),
                                                        SizedBox(
                                                          height: size.height *
                                                              0.02,
                                                        ),
                                                        otpSent
                                                            ? Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "Change number ? ",
                                                                        style: TextStyle(
                                                                            color:
                                                                                MyColors.secondary,
                                                                            fontSize: 14),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            otpSent =
                                                                                false;
                                                                            _phoneController.clear();
                                                                          });
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          "Click Here",
                                                                          style: TextStyle(
                                                                              color: MyColors.red,
                                                                              fontSize: 14),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      clickResend
                                                                          ? _scaffoldKeyMobile
                                                                              .currentState
                                                                              .showSnackBar(SnackBar(
                                                                              content: Text(
                                                                                "Already sent OTP",
                                                                                style: TextStyle(color: Colors.white, fontFamily: 'Lato'),
                                                                              ),
                                                                              elevation: 0,
                                                                              duration: Duration(milliseconds: 1500),
                                                                              backgroundColor: MyColors.primaryNew,
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5))),
                                                                            ))
                                                                          : sendOTP();
                                                                      setState(
                                                                          () {
                                                                        clickResend =
                                                                            true;
                                                                      });
                                                                    },
                                                                    child: Text(
                                                                      "Resend OTP",
                                                                      style: TextStyle(
                                                                          color: MyColors
                                                                              .primaryNew,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            : Container()
                                                      ],
                                                    ),
                                                  )
                                  ],
                                );
                              },
                              itemCount: 4,
                            ),
                          )),
                          _currentIndex == 0
                              ? GestureDetector(
                                  onTap: () async {
                                    if (_nameController.text
                                            .trim()
                                            .isNotEmpty &&
                                        _addressController.text
                                            .trim()
                                            .isNotEmpty &&
                                        _passController.text.trim().length >=
                                            6 &&
                                        _validateEmail(
                                            _emailController.text.trim())) {
                                      bool res = await checkUserExists();
                                      res
                                          ? _scaffoldKeyMobile.currentState
                                              .showSnackBar(SnackBar(
                                              content: Text(
                                                "This email is already resgistered",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Lato'),
                                              ),
                                              elevation: 0,
                                              duration:
                                                  Duration(milliseconds: 1500),
                                              backgroundColor:
                                                  MyColors.primaryNew,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  5),
                                                          topLeft:
                                                              Radius.circular(
                                                                  5))),
                                            ))
                                          : _pageController.animateToPage(
                                              _currentIndex + 1,
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 200));
                                    } else {
                                      _scaffoldKeyMobile.currentState
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          "Fill details properly",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Lato'),
                                        ),
                                        elevation: 0,
                                        duration: Duration(milliseconds: 1500),
                                        backgroundColor: MyColors.primaryNew,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5),
                                                topLeft: Radius.circular(5))),
                                      ));
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: MyColors.red,
                                        borderRadius: BorderRadius.circular(4)),
                                    width: size.width,
                                    height: size.height * 0.06,
                                    child: Center(
                                        child: Text(
                                      "Next",
                                      style: TextStyle(
                                          letterSpacing: 0.3,
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    )),
                                  ),
                                )
                              : _currentIndex == 1
                                  ? Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (companyNameController.text
                                                    .trim()
                                                    .isNotEmpty &&
                                                (dropdownCompanyType == "Other"
                                                    ? companyTypeController.text
                                                        .trim()
                                                        .isNotEmpty
                                                    : true)) {
                                              _pageController.animateToPage(
                                                  _currentIndex + 1,
                                                  curve: Curves.easeIn,
                                                  duration: Duration(
                                                      milliseconds: 200));
                                            } else {
                                              _scaffoldKeyMobile.currentState
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  "Fill details properly",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Lato'),
                                                ),
                                                elevation: 0,
                                                duration: Duration(
                                                    milliseconds: 1500),
                                                backgroundColor:
                                                    MyColors.primaryNew,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(5),
                                                            topLeft:
                                                                Radius.circular(
                                                                    5))),
                                              ));
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: MyColors.red,
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            width: size.width,
                                            height: size.height * 0.06,
                                            child: Center(
                                                child: Text(
                                              "Next",
                                              style: TextStyle(
                                                  letterSpacing: 0.3,
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _pageController.animateToPage(
                                                _currentIndex - 1,
                                                curve: Curves.easeIn,
                                                duration: Duration(
                                                    milliseconds: 200));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                  color: MyColors.red,
                                                  width: 1,
                                                )),
                                            width: size.width,
                                            height: size.height * 0.06,
                                            child: Center(
                                                child: Text(
                                              "Back",
                                              style: TextStyle(
                                                  color: MyColors.red,
                                                  fontSize: 18,
                                                  letterSpacing: 0.3,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                          ),
                                        ),
                                      ],
                                    )
                                  : _currentIndex == 2
                                      ? Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (_regController.text
                                                        .trim()
                                                        .isNotEmpty &&
                                                    _panController.text
                                                        .trim()
                                                        .isNotEmpty) {
                                                  if (fileDoc != null &&
                                                      fileDocPan != null) {
                                                    _pageController
                                                        .animateToPage(
                                                            _currentIndex + 1,
                                                            curve:
                                                                Curves.easeIn,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    200));
                                                  } else {
                                                    _scaffoldKeyMobile
                                                        .currentState
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                        "Select Images",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: 'Lato'),
                                                      ),
                                                      elevation: 0,
                                                      duration: Duration(
                                                          milliseconds: 1500),
                                                      backgroundColor:
                                                          MyColors.primaryNew,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5))),
                                                    ));
                                                  }
                                                } else {
                                                  _scaffoldKeyMobile
                                                      .currentState
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                      "Fill Details properly",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Lato'),
                                                    ),
                                                    elevation: 0,
                                                    duration: Duration(
                                                        milliseconds: 1500),
                                                    backgroundColor:
                                                        MyColors.primaryNew,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        5),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        5))),
                                                  ));
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: MyColors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                width: size.width,
                                                height: size.height * 0.06,
                                                child: Center(
                                                    child: Text(
                                                  "Next",
                                                  style: TextStyle(
                                                      letterSpacing: 0.3,
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )),
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _pageController.animateToPage(
                                                    _currentIndex - 1,
                                                    curve: Curves.easeIn,
                                                    duration: Duration(
                                                        milliseconds: 200));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    border: Border.all(
                                                      color: MyColors.red,
                                                      width: 1,
                                                    )),
                                                width: size.width,
                                                height: size.height * 0.06,
                                                child: Center(
                                                    child: Text(
                                                  "Back",
                                                  style: TextStyle(
                                                      color: MyColors.red,
                                                      fontSize: 18,
                                                      letterSpacing: 0.3,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            spinning == 0
                                                ? GestureDetector(
                                                    onTap: () async {
                                                      setState(() {
                                                        spinning = 20;
                                                      });
                                                      if (otpSent) {
                                                        if (otpController.text
                                                                .trim()
                                                                .isEmpty ||
                                                            otpController.text
                                                                    .trim()
                                                                    .length <
                                                                6) {
                                                          setState(() {
                                                            spinning = 0;
                                                          });
                                                          _scaffoldKeyMobile
                                                              .currentState
                                                              .showSnackBar(
                                                                  SnackBar(
                                                            content: Text(
                                                              "Enter valid OTP",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'Lato'),
                                                            ),
                                                            elevation: 0,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    1500),
                                                            backgroundColor:
                                                                MyColors
                                                                    .primaryNew,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            5),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            5))),
                                                          ));
                                                        } else {
                                                          confirmOTP();
                                                        }
                                                      } else {
                                                        if (_phoneController
                                                                .text
                                                                .trim()
                                                                .isEmpty ||
                                                            _phoneController
                                                                    .text
                                                                    .trim()
                                                                    .length <
                                                                10) {
                                                          setState(() {
                                                            spinning = 0;
                                                          });
                                                          _scaffoldKeyMobile
                                                              .currentState
                                                              .showSnackBar(
                                                                  SnackBar(
                                                            content: Text(
                                                              "Enter valid phone number",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'Lato'),
                                                            ),
                                                            elevation: 0,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    1500),
                                                            backgroundColor:
                                                                MyColors
                                                                    .primaryNew,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            5),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            5))),
                                                          ));
                                                        } else {
                                                          sendOTP();
                                                        }
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: MyColors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                      width: size.width,
                                                      height:
                                                          size.height * 0.06,
                                                      child: Center(
                                                          child: Text(
                                                        !otpSent
                                                            ? "Register"
                                                            : "Verify OTP",
                                                        style: TextStyle(
                                                            letterSpacing: 0.3,
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      )),
                                                    ),
                                                  )
                                                : SpinKitThreeBounce(
                                                    color: MyColors.red,
                                                    size: spinning),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _pageController.animateToPage(
                                                    _currentIndex - 1,
                                                    curve: Curves.easeIn,
                                                    duration: Duration(
                                                        milliseconds: 200));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    border: Border.all(
                                                      color: MyColors.red,
                                                      width: 1,
                                                    )),
                                                width: size.width,
                                                height: size.height * 0.06,
                                                child: Center(
                                                    child: Text(
                                                  "Back",
                                                  style: TextStyle(
                                                      color: MyColors.red,
                                                      fontSize: 18,
                                                      letterSpacing: 0.3,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                          Container(
                              margin: EdgeInsets.all(8),
                              child: _buildIndicator())
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Hero(
                  tag: "createAccountFromLogin",
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      alignment: Alignment.center,
                      // width: size.width * 0.3,
                      child: Text(
                        "Create an account to get started",
                        style: TextStyle(
                            color: MyColors.primaryNew,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.005,
                ),
                Container(
                  alignment: Alignment.center,
                  // width: size.width * 0.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have an account already ?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 1000),
                            pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) {
                              return LoginPageTab();
                            },
                            transitionsBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ));
                        },
                        child: Text(
                          "Log In",
                          style: TextStyle(
                              color: MyColors.primaryNew,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
    );
  }

  sendOTP() async {
    try {
      confirmationResult = await FirebaseAuth.instance.signInWithPhoneNumber(
        '+91' + _phoneController.text.trim(),
      );
      setState(() {
        otpSent = true;
        spinning = 0;
      });
    } catch (e) {
      _scaffoldKeyMobile.currentState.showSnackBar(SnackBar(
        content: Text(
          e.toString(),
          style: TextStyle(color: Colors.white, fontFamily: 'Lato'),
        ),
        elevation: 0,
        duration: Duration(milliseconds: 1500),
        backgroundColor: MyColors.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5), topLeft: Radius.circular(5))),
      ));
      setState(() {
        otpSent = false;
        spinning = 0;
      });
    }
  }

  confirmOTP() async {
    try {
      UserCredential userCredential =
          await confirmationResult.confirm(otpController.text.trim());
      if (userCredential.user != null) {
        FirebaseStorage.instance
            .refFromURL("gs://logistics-katariaplastics.appspot.com/")
            .child("/images/${DateTime.now().microsecondsSinceEpoch}")
            .putBlob(fileDoc)
            .then((v) async {
          docUrl = await v.ref.getDownloadURL();
          FirebaseStorage.instance
              .refFromURL("gs://logistics-katariaplastics.appspot.com/")
              .child("/images/${DateTime.now().microsecondsSinceEpoch}")
              .putBlob(fileDocPan)
              .then((e) async {
            panUrl = await e.ref.getDownloadURL();
            FirebaseAuth.instance.currentUser.delete();
            await AuthService().signOut();
            AuthService()
                .signUp(
                    typeOfUser: "transporter",
                    user: UserModel(
                      regUrl: docUrl,
                      panUrl: panUrl,
                      userID: userID.toString(),
                      address: _addressController.text.trim(),
                      companyName: companyNameController.text.trim(),
                      companyType: dropdownCompanyType == "Other"
                          ? companyTypeController.text.trim()
                          : dropdownCompanyType,
                      email: _emailController.text.trim(),
                      panNumber: _panController.text.trim(),
                      password: _passController.text.trim(),
                      phone: _phoneController.text.trim(),
                      registrationNumber: _regController.text.trim(),
                      userType: "transporter",
                      username: _nameController.text.trim(),
                      verified: false,
                    ))
                .then((value) => displayResult(value));
          });
        });
        // await userCredential.user
        //     .reauthenticateWithCredential(userCredential.credential);

        // FirebaseAuth.instance.signInWithCredential(userCredential.credential);
      } else {
        setState(() {
          spinning = 0;
        });
        _scaffoldKeyMobile.currentState.showSnackBar(SnackBar(
          content: Text(
            "Failed",
            style: TextStyle(color: Colors.white, fontFamily: 'Lato'),
          ),
          elevation: 0,
          duration: Duration(milliseconds: 1500),
          backgroundColor: MyColors.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5), topLeft: Radius.circular(5))),
        ));
      }
    } catch (e) {
      setState(() {
        spinning = 0;
      });
      _scaffoldKeyMobile.currentState.showSnackBar(SnackBar(
        content: Text(
          e.toString(),
          style: TextStyle(color: Colors.white, fontFamily: 'Lato'),
        ),
        elevation: 0,
        duration: Duration(milliseconds: 500),
        backgroundColor: MyColors.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5), topLeft: Radius.circular(5))),
      ));
    }
  }

  displayResult(Map result) {
    if (result['success']) {
      _scaffoldKeyMobile.currentState.showSnackBar(SnackBar(
        content: Text(
          "Sign-up Successful",
          style: TextStyle(color: Colors.white, fontFamily: 'Lato'),
        ),
        elevation: 0,
        duration: Duration(milliseconds: 500),
        backgroundColor: MyColors.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5), topLeft: Radius.circular(5))),
      ));
      Future.delayed(const Duration(seconds: 1), () async {
        // Navigator.of(context).pop();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => TransporterNavPage()));
      });
    } else {
      setState(() {
        spinning = 0;
      });
      _scaffoldKeyMobile.currentState.showSnackBar(SnackBar(
        content: Text(
          "Error : ${result['msg']}",
          style: TextStyle(color: Colors.white, fontFamily: 'Lato'),
        ),
        elevation: 0,
        duration: Duration(seconds: 2),
        backgroundColor: MyColors.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5), topLeft: Radius.circular(5))),
      ));
    }
  }

  bool _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  Row _buildIndicator() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
            4, (index) => _pageIndicator(_currentIndex == index)));
  }

  Widget _pageIndicator(bool isCurrent) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 14,
      height: 14,
      padding: EdgeInsets.all(1.5),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border:
              isCurrent ? Border.all(color: MyColors.red, width: 1) : Border()),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: isCurrent ? MyColors.red : Color(0xffffeeee)),
      ),
    );
  }
}
