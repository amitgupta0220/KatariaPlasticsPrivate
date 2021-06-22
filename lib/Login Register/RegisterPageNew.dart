import 'dart:io';
import 'dart:math';
import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'LoginPageNew.dart';
import 'package:KPPL/authentication/authenticate.dart';
import 'package:KPPL/HomeScreen.dart/HomePage.dart';
import 'package:KPPL/authentication/UserModel.dart';

class RegisterPageNew extends StatefulWidget {
  @override
  _RegisterPageNewState createState() => _RegisterPageNewState();
}

class _RegisterPageNewState extends State<RegisterPageNew>
    with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String actualCode;
  double spinning = 0;
  AuthCredential _authCredential;
  bool showPass = true,
      otpSent = false,
      clickResend = false,
      loadVerify = false;
  AnimationController _animationController;
  String dropdownCompanyType = 'Sole Proprietor';
  String dropdownRegistration = 'Incorporation Certificate';
  Animation _animation;
  ConfirmationResult confirmationResult;
  String currentText = "";
  String panUrl, docUrl;
  int userID;
  bool gotNumber = false;
  Reference storage = FirebaseStorage.instance
      .refFromURL("gs://logistics-katariaplastics.appspot.com/");
  final firebaseAuth = FirebaseAuth.instance;
  // bool _autoValidate = false;
  // final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final otpController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _companyTypeController = TextEditingController();
  final _regNumberController = TextEditingController();
  final _panNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _passController = TextEditingController();
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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

  final ImagePicker _picker = ImagePicker();
  File _image;
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    PickedFile image =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  _imgFromGallery() async {
    PickedFile image =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  final ImagePicker _pickerPan = ImagePicker();
  File _imagePan;
  void _showPickerPan(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        _imgFromGalleryPan();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCameraPan();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCameraPan() async {
    PickedFile image =
        await _pickerPan.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _imagePan = File(image.path);
    });
  }

  _imgFromGalleryPan() async {
    PickedFile image = await _pickerPan.getImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _imagePan = File(image.path);
    });
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
        backgroundColor: Color(0xffffeeee),
        key: _scaffoldKey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/images/logo.png",
                height: size.height * 0.17,
              ),
            ),
            Hero(
              tag: "signUpFromLogin",
              child: Material(
                color: Colors.transparent,
                child: Container(
                  height: size.height * 0.7,
                  // height: size.height * 0.7,
                  // width: size.width * 0.85,
                  margin: EdgeInsets.only(
                    left: size.width * 0.05,
                    right: size.width * 0.05,
                  ),
                  padding: EdgeInsets.all(size.width * 0.05),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
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
                        margin: EdgeInsets.all(size.height * 0.01),
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) =>
                              setState(() => _currentIndex = index),
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            return SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  index == 0
                                      ? SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                              Container(
                                                height: 55,
                                                child: TextFormField(
                                                  style:
                                                      TextStyle(fontSize: 12),
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
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: MyColors
                                                                .secondaryNew),
                                                      ),
                                                      hintStyle: TextStyle(
                                                          fontSize: 12,
                                                          color: Color(
                                                              0xffB3B3B3)),
                                                      hintText: "Full Name"),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                              Container(
                                                height: 55,
                                                child: TextFormField(
                                                  style:
                                                      TextStyle(fontSize: 12),
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
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: MyColors
                                                                .secondaryNew),
                                                      ),
                                                      hintStyle: TextStyle(
                                                          fontSize: 12,
                                                          color: Color(
                                                              0xffB3B3B3)),
                                                      hintText: "Address"),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                              Container(
                                                height: 55,
                                                child: TextFormField(
                                                  style:
                                                      TextStyle(fontSize: 12),
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
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: MyColors
                                                                .secondaryNew),
                                                      ),
                                                      hintStyle: TextStyle(
                                                          fontSize: 12,
                                                          color: Color(
                                                              0xffB3B3B3)),
                                                      hintText:
                                                          "Email Address"),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                              Container(
                                                height: 55,
                                                child: TextFormField(
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                  controller: _passController,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
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
                                                            ? Icon(
                                                                Icons
                                                                    .remove_red_eye,
                                                                color: MyColors
                                                                    .secondaryNew,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .remove_red_eye,
                                                                color: MyColors
                                                                    .red,
                                                              ),
                                                        onPressed: () {
                                                          setState(() {
                                                            showPass =
                                                                !showPass;
                                                          });
                                                        },
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: MyColors
                                                                .secondaryNew),
                                                      ),
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
                                                          fontSize: 12,
                                                          color: Color(
                                                              0xffB3B3B3)),
                                                      hintText: "Password"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : index == 1
                                          ? SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: size.height * 0.02,
                                                  ),
                                                  Container(
                                                    height: 55,
                                                    child: TextFormField(
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                      controller:
                                                          _companyNameController,
                                                      keyboardType:
                                                          TextInputType.name,
                                                      decoration:
                                                          InputDecoration(
                                                              filled: true,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              fillColor:
                                                                  Colors.white,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: MyColors
                                                                        .secondaryNew),
                                                              ),
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4)),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: MyColors
                                                                        .secondaryNew),
                                                              ),
                                                              hintStyle: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Color(
                                                                      0xffB3B3B3)),
                                                              // hintText: 'abc@def.com',
                                                              hintText:
                                                                  "Company Name"),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.02,
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
                                                        DropdownButton<String>(
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
                                                              "assets/images/dropDown.png"),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.02,
                                                  ),
                                                  dropdownCompanyType == "Other"
                                                      ? Container(
                                                          height: 55,
                                                          child: TextFormField(
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                            controller:
                                                                _companyTypeController,
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
                                                                        borderRadius: BorderRadius
                                                                            .circular(
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
                                              ? SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      // SizedBox(
                                                      //   height: size.height * 0.02,
                                                      // ),
                                                      Container(
                                                        width: size.width,
                                                        height:
                                                            size.width * 0.08,
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
                                                              icon: Container(),
                                                              dropdownColor:
                                                                  Colors.white,
                                                              underline:
                                                                  Container(),
                                                              value:
                                                                  dropdownRegistration,
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
                                                                  dropdownRegistration =
                                                                      newValue;
                                                                });
                                                              },
                                                              items: <String>[
                                                                'Incorporation Certificate',
                                                                'GST',
                                                                'Registration Certificate'
                                                              ].map<
                                                                  DropdownMenuItem<
                                                                      String>>((String
                                                                  value) {
                                                                return DropdownMenuItem<
                                                                    String>(
                                                                  value: value,
                                                                  child: Text(
                                                                      value),
                                                                );
                                                              }).toList(),
                                                            ),
                                                            GestureDetector(
                                                              child: Image.asset(
                                                                  "assets/images/dropDown.png"),
                                                            )
                                                          ],
                                                        ),
                                                      ),
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
                                                              _regNumberController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .name,
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
                                                                    borderSide: BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: MyColors
                                                                            .secondaryNew),
                                                                  ),
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4)),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: MyColors
                                                                            .secondaryNew),
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
                                                            size.height * 0.02,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () =>
                                                            _showPicker(
                                                                context),
                                                        child: Container(
                                                          height:
                                                              size.width * 0.08,
                                                          child: FDottedLine(
                                                            space: 6,
                                                            strokeWidth: 1,
                                                            color: MyColors
                                                                .secondaryNew,
                                                            child:
                                                                _image != null
                                                                    ? Center(
                                                                        child: Text(
                                                                            "${_image.path.split('/').last}",
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: TextStyle(fontSize: 12, color: MyColors.secondary)),
                                                                      )
                                                                    : Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Image.asset(
                                                                              "assets/images/addDocument.png"),
                                                                          SizedBox(
                                                                            width:
                                                                                8,
                                                                          ),
                                                                          Center(
                                                                              child: Text("Upload certificate",
                                                                                  style: TextStyle(
                                                                                    color: MyColors.secondary,
                                                                                    fontSize: 13,
                                                                                  ))),
                                                                        ],
                                                                      ),
                                                          ),
                                                        ),
                                                      ),
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
                                                              _panNumberController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .name,
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
                                                                    borderSide: BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: MyColors
                                                                            .secondaryNew),
                                                                  ),
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4)),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: MyColors
                                                                            .secondaryNew),
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
                                                            size.height * 0.02,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () =>
                                                            _showPickerPan(
                                                                context),
                                                        child: Container(
                                                          height:
                                                              size.width * 0.08,
                                                          child: FDottedLine(
                                                            space: 6,
                                                            strokeWidth: 1,
                                                            color: MyColors
                                                                .secondaryNew,
                                                            child:
                                                                _imagePan !=
                                                                        null
                                                                    ? Center(
                                                                        child: Text(
                                                                            "${_imagePan.path.split('/').last}",
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: TextStyle(fontSize: 12, color: MyColors.secondary)),
                                                                      )
                                                                    : Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Image.asset(
                                                                              "assets/images/addDocument.png"),
                                                                          SizedBox(
                                                                            width:
                                                                                8,
                                                                          ),
                                                                          Center(
                                                                              child: Text("Upload PAN card",
                                                                                  style: TextStyle(
                                                                                    color: MyColors.secondary,
                                                                                    fontSize: 13,
                                                                                  ))),
                                                                        ],
                                                                      ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : index == 3
                                                  ? SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.02,
                                                          ),
                                                          !otpSent
                                                              ? Container(
                                                                  height: 65,
                                                                  child:
                                                                      TextFormField(
                                                                    maxLength:
                                                                        10,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                    controller:
                                                                        _phoneController,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    decoration: InputDecoration(
                                                                        filled: true,
                                                                        hoverColor: Colors.transparent,
                                                                        fillColor: Colors.white,
                                                                        enabledBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              width: 1,
                                                                              color: MyColors.secondaryNew),
                                                                        ),
                                                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                                                                        focusedBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              width: 1,
                                                                              color: MyColors.secondaryNew),
                                                                        ),
                                                                        hintStyle: TextStyle(fontSize: 12, color: Color(0xffB3B3B3)),
                                                                        hintText: "Enter phone number"),
                                                                  ),
                                                                )
                                                              : Container(),
                                                          SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.02,
                                                          ),
                                                          otpSent
                                                              ? Container(
                                                                  height: 55,
                                                                  child:
                                                                      TextFormField(
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                    controller:
                                                                        otpController,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    decoration: InputDecoration(
                                                                        filled: true,
                                                                        hoverColor: Colors.transparent,
                                                                        fillColor: Colors.white,
                                                                        enabledBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              width: 1,
                                                                              color: MyColors.secondaryNew),
                                                                        ),
                                                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                                                                        focusedBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              width: 1,
                                                                              color: MyColors.secondaryNew),
                                                                        ),
                                                                        hintStyle: TextStyle(fontSize: 12, color: Color(0xffB3B3B3)),
                                                                        hintText: "Enter OTP"),
                                                                  ),
                                                                )
                                                              : Container(),
                                                          SizedBox(
                                                            height:
                                                                size.height *
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
                                                                              color: MyColors.secondary,
                                                                              fontSize: 13),
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              otpSent = false;
                                                                              _phoneController.clear();
                                                                            });
                                                                            otpController.clear();
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            "Click Here",
                                                                            style:
                                                                                TextStyle(color: MyColors.red, fontSize: 13),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: size
                                                                              .height *
                                                                          0.01,
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        clickResend
                                                                            ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                content: Text(
                                                                                  "Already sent OTP",
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                                elevation: 0,
                                                                                duration: Duration(milliseconds: 1500),
                                                                                backgroundColor: MyColors.primaryNew,
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(5), topLeft: Radius.circular(5))),
                                                                              ))
                                                                            : sendOtp();
                                                                        setState(
                                                                            () {
                                                                          clickResend =
                                                                              true;
                                                                        });
                                                                        otpController
                                                                            .clear();
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Resend OTP",
                                                                        style: TextStyle(
                                                                            color:
                                                                                MyColors.primaryNew,
                                                                            fontSize: 13),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              : Container()
                                                        ],
                                                      ),
                                                    )
                                                  : Container()
                                ],
                              ),
                            );
                          },
                          itemCount: 4,
                        ),
                      )),
                      _currentIndex == 0
                          ? GestureDetector(
                              onTap: () async {
                                if (_nameController.text.trim().isNotEmpty &&
                                    _addressController.text.trim().isNotEmpty &&
                                    _passController.text.trim().length >= 6 &&
                                    _validateEmail(
                                        _emailController.text.trim())) {
                                  bool res = await checkUserExists();
                                  res
                                      ? _scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                          content: Text(
                                            "This email is already resgistered",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          elevation: 0,
                                          duration:
                                              Duration(milliseconds: 1500),
                                          backgroundColor: MyColors.primary,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(5),
                                                  topLeft: Radius.circular(5))),
                                        ))
                                      : _pageController.animateToPage(
                                          _currentIndex + 1,
                                          curve: Curves.easeIn,
                                          duration:
                                              Duration(milliseconds: 200));
                                } else {
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "Fill details properly",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    elevation: 0,
                                    duration: Duration(milliseconds: 1500),
                                    backgroundColor: MyColors.primary,
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                )),
                              ),
                            )
                          : _currentIndex == 1
                              ? Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (_companyNameController.text
                                                .trim()
                                                .isNotEmpty &&
                                            (dropdownCompanyType == "Other"
                                                ? _companyTypeController.text
                                                    .trim()
                                                    .isNotEmpty
                                                : true)) {
                                          _pageController.animateToPage(
                                              _currentIndex + 1,
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 200));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                              "Fill details properly",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            elevation: 0,
                                            duration:
                                                Duration(milliseconds: 1500),
                                            backgroundColor:
                                                MyColors.primaryNew,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5),
                                                    topLeft:
                                                        Radius.circular(5))),
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
                                              fontSize: 16,
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
                                            duration:
                                                Duration(milliseconds: 200));
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
                                              fontSize: 16,
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
                                            if (_regNumberController.text
                                                    .trim()
                                                    .isNotEmpty &&
                                                _panNumberController.text
                                                    .trim()
                                                    .isNotEmpty) {
                                              if (_image != null &&
                                                  _imagePan != null) {
                                                _pageController.animateToPage(
                                                    _currentIndex + 1,
                                                    curve: Curves.easeIn,
                                                    duration: Duration(
                                                        milliseconds: 200));
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                    "Select Images",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
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
                                                              topLeft: Radius
                                                                  .circular(
                                                                      5))),
                                                ));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  "Fill Details properly",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
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
                                                  fontSize: 16,
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
                                                  fontSize: 16,
                                                  letterSpacing: 0.3,
                                                  fontWeight: FontWeight.w700),
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
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: Text(
                                                          "Enter valid OTP",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Lato'),
                                                        ),
                                                        elevation: 0,
                                                        duration: Duration(
                                                            milliseconds: 1500),
                                                        backgroundColor:
                                                            MyColors.primaryNew,
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
                                                      confirmOtp(otpController
                                                          .text
                                                          .trim());
                                                    }
                                                  } else {
                                                    if (_phoneController.text
                                                            .trim()
                                                            .isEmpty ||
                                                        _phoneController.text
                                                                .trim()
                                                                .length <
                                                            10) {
                                                      setState(() {
                                                        spinning = 0;
                                                      });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: Text(
                                                          "Enter valid phone number",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Lato'),
                                                        ),
                                                        elevation: 0,
                                                        duration: Duration(
                                                            milliseconds: 1500),
                                                        backgroundColor:
                                                            MyColors.primaryNew,
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
                                                      sendOtp();
                                                    }
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
                                                    !otpSent
                                                        ? "Send OTP"
                                                        : "Verify OTP",
                                                    style: TextStyle(
                                                        letterSpacing: 0.3,
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )),
                                                ),
                                              )
                                            : SpinKitThreeBounce(
                                                size: spinning,
                                                color: MyColors.red,
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
                                                  fontSize: 16,
                                                  letterSpacing: 0.3,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                          ),
                                        ),
                                      ],
                                    ),
                      Container(
                          margin: EdgeInsets.fromLTRB(5, 15, 5, 0),
                          child: Center(
                            child: _buildIndicator(),
                          ))
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
                      Navigator.of(context).pushReplacement(PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 1000),
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return LoginPageNew();
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
          ],
        ),
      ),
    );
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

  sendOtp() async {
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91" + _phoneController.text.trim(),
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential creds) {
          firebaseAuth
              .signInWithCredential(_authCredential)
              .then((UserCredential value) {
            if (value.user != null) {
              FirebaseStorage.instance
                  .refFromURL("gs://logistics-katariaplastics.appspot.com/")
                  .child("/images/${DateTime.now().microsecondsSinceEpoch}")
                  .putFile(_image)
                  .then((v) async {
                docUrl = await v.ref.getDownloadURL();
                FirebaseStorage.instance
                    .refFromURL("gs://logistics-katariaplastics.appspot.com/")
                    .child("/images/${DateTime.now().microsecondsSinceEpoch}")
                    .putFile(_imagePan)
                    .then((e) async {
                  panUrl = await e.ref.getDownloadURL();
                  value.user.delete();
                  await AuthService().signOut();
                  AuthService()
                      .signUp(
                          typeOfUser: "transporter",
                          user: UserModel(
                            regUrl: docUrl,
                            panUrl: panUrl,
                            userID: userID.toString(),
                            address: _addressController.text.trim(),
                            companyName: _companyNameController.text.trim(),
                            companyType: dropdownCompanyType == "Other"
                                ? _companyTypeController.text.trim()
                                : dropdownCompanyType,
                            email: _emailController.text.trim(),
                            panNumber: _panNumberController.text.trim(),
                            password: _passController.text.trim(),
                            phone: _phoneController.text.trim(),
                            registrationNumber:
                                _regNumberController.text.trim(),
                            userType: "transporter",
                            username: _nameController.text.trim(),
                            verified: false,
                          ))
                      .then((value) => displayResult(value));
                });
              });
            } else {
              setState(() {
                spinning = 0;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Invalid code/invalid authentication",
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
          }).catchError((error) {
            setState(() {
              spinning = 0;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Something has gone wrong, please try later" + error.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              elevation: 0,
              duration: Duration(milliseconds: 1500),
              backgroundColor: MyColors.primaryNew,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      topLeft: Radius.circular(5))),
            ));
          });
        },
        verificationFailed: (FirebaseAuthException authException) {
          if (authException.message.contains('not authorized')) {
            setState(() {
              spinning = 0;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Something has gone wrong, please try later" +
                    authException.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              elevation: 0,
              duration: Duration(milliseconds: 1500),
              backgroundColor: MyColors.primaryNew,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      topLeft: Radius.circular(5))),
            ));
          } else if (authException.message.contains('Network')) {
            setState(() {
              spinning = 0;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Please check your internet connection and try again",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              elevation: 0,
              duration: Duration(milliseconds: 1500),
              backgroundColor: MyColors.primaryNew,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      topLeft: Radius.circular(5))),
            ));
          } else {
            setState(() {
              spinning = 0;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Something has gone wrong, please try later" +
                    authException.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
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
        codeSent: (String verificationId, [int forceResendingToken]) {
          if (mounted)
            setState(() {
              otpSent = true;
              spinning = 0;
              actualCode = verificationId;
            });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Enter the code sent to " + _phoneController.text.trim(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            elevation: 0,
            duration: Duration(milliseconds: 1500),
            backgroundColor: MyColors.primaryNew,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5), topLeft: Radius.circular(5))),
          ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (mounted)
            setState(() {
              spinning = 0;
              actualCode = verificationId;
            });
        });
  }

  void confirmOtp(String smsCode) async {
    _authCredential = PhoneAuthProvider.credential(
        verificationId: actualCode, smsCode: smsCode);
    firebaseAuth.signInWithCredential(_authCredential).catchError((error) {
      setState(() {
        spinning = 0;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Something has gone wrong, please try later" + error.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
        duration: Duration(milliseconds: 1500),
        backgroundColor: MyColors.primaryNew,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5), topLeft: Radius.circular(5))),
      ));
    }).then((UserCredential user) async {
      try {
        FirebaseStorage.instance
            .refFromURL("gs://logistics-katariaplastics.appspot.com/")
            .child("/images/${DateTime.now().microsecondsSinceEpoch}")
            .putFile(_image)
            .then((v) async {
          docUrl = await v.ref.getDownloadURL();
          FirebaseStorage.instance
              .refFromURL("gs://logistics-katariaplastics.appspot.com/")
              .child("/images/${DateTime.now().microsecondsSinceEpoch}")
              .putFile(_imagePan)
              .then((e) async {
            panUrl = await e.ref.getDownloadURL();
            user.user.delete();
            await AuthService().signOut();
            AuthService()
                .signUp(
                    typeOfUser: "transporter",
                    user: UserModel(
                      regUrl: docUrl,
                      panUrl: panUrl,
                      userID: userID.toString(),
                      address: _addressController.text.trim(),
                      companyName: _companyNameController.text.trim(),
                      companyType: dropdownCompanyType == "Other"
                          ? _companyTypeController.text.trim()
                          : dropdownCompanyType,
                      email: _emailController.text.trim(),
                      panNumber: _panNumberController.text.trim(),
                      password: _passController.text.trim(),
                      phone: _phoneController.text.trim(),
                      registrationNumber: _regNumberController.text.trim(),
                      userType: "transporter",
                      username: _nameController.text.trim(),
                      verified: false,
                    ))
                .then((value) => displayResult(value));
          });
        });
      } catch (e) {
        setState(() {
          spinning = 0;
        });
      }
    });
  }

  displayResult(Map result) {
    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Sign-up Successful",
          style: TextStyle(
            color: Colors.white,
          ),
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
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      });
    } else {
      setState(() {
        spinning = 0;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Error : ${result['msg']}",
          style: TextStyle(
            color: Colors.white,
          ),
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
}
