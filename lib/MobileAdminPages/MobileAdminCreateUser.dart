import 'dart:math';

import 'package:KPPL/authentication/UserModel.dart';
import 'package:KPPL/authentication/authenticate.dart';
import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MobileAdminCreateUser extends StatefulWidget {
  @override
  _MobileAdminCreateUserState createState() => _MobileAdminCreateUserState();
}

class _MobileAdminCreateUserState extends State<MobileAdminCreateUser> {
  final TextEditingController _userByAdminEmail = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userByAdminPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showPass = true, gotNumber = false;
  bool autoValidate = false;
  String _currentItem = 'Admin';
  int userID;

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
  void initState() {
    super.initState();
    getUserNumber();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
          child: Column(
        children: [
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
                        "Create User",
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
          Container(
            margin: EdgeInsets.only(
              top: size.height * 0.01,
            ),
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
            ),
            padding: EdgeInsets.only(
              top: size.width * 0.03,
              bottom: size.width * 0.03,
              left: size.width * 0.02,
              right: size.width * 0.02,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    style: TextStyle(fontSize: 15),
                    controller: _nameController,
                    autocorrect: autoValidate,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter valid name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        hoverColor: Colors.transparent,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: MyColors.secondaryNew),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: MyColors.secondaryNew),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4)),
                        hintStyle:
                            TextStyle(fontSize: 14, color: Color(0xffB3B3B3)),
                        // hintText: 'abc@def.com',
                        hintText: "Enter name"),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 15),
                    controller: _userByAdminEmail,
                    autocorrect: autoValidate,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => _validateEmail(value.trim()),
                    decoration: InputDecoration(
                        filled: true,
                        hoverColor: Colors.transparent,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: MyColors.secondaryNew),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: MyColors.secondaryNew),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4)),
                        hintStyle:
                            TextStyle(fontSize: 14, color: Color(0xffB3B3B3)),
                        // hintText: 'abc@def.com',
                        hintText: "Email Address"),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 15),
                    controller: _userByAdminPassword,
                    autocorrect: autoValidate,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter valid password";
                      } else if (value.length < 6) {
                        return "Enter minimum 6 letter password";
                      }
                      return null;
                    },
                    obscureText: showPass,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: MyColors.secondaryNew),
                        ),
                        suffixIcon: IconButton(
                          icon: showPass
                              ? Icon(
                                  Icons.remove_red_eye,
                                  color: MyColors.secondary,
                                )
                              : Icon(Icons.remove_red_eye, color: MyColors.red),
                          onPressed: () {
                            setState(() {
                              showPass = !showPass;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hoverColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: MyColors.secondaryNew),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4)),
                        hintStyle:
                            TextStyle(fontSize: 14, color: Color(0xffB3B3B3)),
                        // hintText: 'abc@def.com',
                        hintText: "Password"),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 15),
                    controller: _phoneController,
                    autocorrect: autoValidate,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter valid phone number";
                      }
                      return null;
                    },
                    maxLength: 10,
                    decoration: InputDecoration(
                        filled: true,
                        hoverColor: Colors.transparent,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: MyColors.secondaryNew),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: MyColors.secondaryNew),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4)),
                        hintStyle:
                            TextStyle(fontSize: 14, color: Color(0xffB3B3B3)),
                        // hintText: 'abc@def.com',
                        hintText: "Enter Phone Number"),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: size.width * 0.1 + 80,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                            border: Border.all(color: MyColors.secondaryNew)),
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropdownButton<String>(
                              focusColor: Colors.white,
                              icon: Container(),
                              dropdownColor: Colors.white,
                              underline: Container(),
                              value: _currentItem,
                              // icon: Icon(Icons.language),
                              // isExpanded: true,
                              // iconSize: 0,
                              elevation: 1,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xffB3B3B3),
                              ),
                              autofocus: false,
                              onChanged: (String newValue) {
                                setState(() {
                                  _currentItem = newValue;
                                });
                              },
                              items: <String>[
                                'Admin',
                                'Marketer',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                      margin: EdgeInsets.only(right: 18),
                                      width: size.width * 0.1 + 20,
                                      child: Text(value)),
                                );
                              }).toList(),
                            ),
                            GestureDetector(
                              child: Container(
                                  width: 18,
                                  child: Image.asset("assets/dropDown.png")),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "User ID : " + userID.toString() ?? "",
                            style: TextStyle(
                              color: Color(0xffB3B3B3),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (_formKey.currentState.validate()) {
                Map result = await AuthService().createUser(
                    email: _userByAdminEmail.text.trim(),
                    password: _userByAdminPassword.text.trim(),
                    user: UserModelByAdmin(
                      userID: userID.toString(),
                      email: _userByAdminEmail.text.trim(),
                      userType: _currentItem.toLowerCase(),
                      name: _nameController.text,
                      phoneNumber: _phoneController.text,
                    ));
                displayMessage(result);
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
                  "Create User",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  displayMessage(Map result) {
    if (result['success']) {
      _phoneController.clear();
      _nameController.clear();
      _userByAdminEmail.clear();
      _userByAdminPassword.clear();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          "User Created successfull",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        duration: Duration(milliseconds: 500),
        backgroundColor: MyColors.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5), topLeft: Radius.circular(5))),
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          "Error : ${result['msg']}",
          style: TextStyle(color: Colors.white),
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

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter valid email';
    else
      return null;
  }
}
