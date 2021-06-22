import 'package:KPPL/HomeScreen.dart/HomePage.dart';
import 'package:KPPL/authentication/authenticate.dart';
import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'RegisterPageNew.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPageNew extends StatefulWidget {
  @override
  _LoginPageNewState createState() => _LoginPageNewState();
}

class _LoginPageNewState extends State<LoginPageNew> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showPass = true;
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  double spinning = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: MyColors.backgroundNewPage,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: size.height * 0.02),
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/logo.png",
                  height: size.height * 0.22,
                ),
              ),
              Hero(
                tag: "loginToSideBar",
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    height: size.height * 0.55,
                    margin: EdgeInsets.only(
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                    ),
                    padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                      bottom: size.width * 0.05,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.all(size.width * 0.035),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.05,
                                ),
                                Container(
                                  height: 55,
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 12),
                                    controller: _emailController,
                                    autocorrect: _autoValidate,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) =>
                                        _validateEmail(value.trim()),
                                    decoration: InputDecoration(
                                        filled: true,
                                        hoverColor: Colors.transparent,
                                        fillColor: Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: MyColors.secondaryNew),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: MyColors.secondaryNew),
                                        ),
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xffB3B3B3)),
                                        // hintText: 'abc@def.com',
                                        hintText: "Email Address"),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Container(
                                  height: 55,
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 12),
                                    controller: _passController,
                                    autocorrect: _autoValidate,
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
                                        suffixIcon: IconButton(
                                          icon: showPass
                                              ? Icon(
                                                  Icons.remove_red_eye,
                                                  color: MyColors.secondaryNew,
                                                )
                                              : Icon(
                                                  Icons.remove_red_eye,
                                                  color: MyColors.red,
                                                ),
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
                                              width: 1,
                                              color: MyColors.secondaryNew),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: MyColors.secondaryNew),
                                        ),
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xffB3B3B3)),
                                        // hintText: 'abc@def.com',
                                        hintText: "Password"),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.045,
                                ),
                                spinning == 0
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            spinning = 20;
                                          });
                                          if (_formKey.currentState
                                              .validate()) {
                                            _checkIfUserExists();
                                          } else {
                                            setState(() {
                                              spinning = 0;
                                              _autoValidate = true;
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: size.width,
                                          height: size.height * 0.07,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Color(0xff0A48A3),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 8,
                                                offset: Offset(
                                                  0,
                                                  1,
                                                ),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SpinKitThreeBounce(
                                        size: spinning,
                                        color: MyColors.red,
                                      ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                Center(
                                  child: Text(
                                    "Forgot Password ?",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: MyColors.primaryNew),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Center(
                                  child: Text(
                                    "Need Help ?",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: MyColors.secondary),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // right: size.width * 0.07,
              //   top: size.height * 0.805,
              Hero(
                tag: "signUpFromLogin",
                child: Material(
                  color: Colors.transparent,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 1000),
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return RegisterPageNew();
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
                      child: Container(
                        // width: size.width * 0.3,
                        margin: EdgeInsets.only(
                          top: size.width * 0.01,
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                        ),
                        height: size.height * 0.08,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            )),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // top: size.height * 0.89,
              //   right: size.width * 0.07,
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
                      "Create an account\nin just 3 steps",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: MyColors.primaryNew,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
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

  _checkIfUserExists() async {
    final user = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: _emailController.text.trim().toLowerCase())
        .limit(1)
        .get();
    if (user.docs.length == 0) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "User is not registered",
          style: TextStyle(color: Colors.white, fontFamily: 'Lato'),
        ),
        elevation: 0,
        duration: Duration(seconds: 2),
        backgroundColor: MyColors.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5), topLeft: Radius.circular(5))),
      ));
      if (mounted)
        setState(() {
          spinning = 0;
        });
    } else {
      signInUser();
    }
  }

  signInUser() async {
    Map result = await AuthService().signIn(
        email: _emailController.text.trim(),
        password: _passController.text.trim(),
        typeOfUser: "transporter");
    displayMessage(result);
  }

  displayMessage(Map result) {
    if (result['success']) {
      Future.delayed(Duration(seconds: 1), () {
        // Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "Login Successful",
          style: TextStyle(color: Colors.white, fontFamily: 'Lato'),
        ),
        elevation: 0,
        duration: Duration(milliseconds: 500),
        backgroundColor: MyColors.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5), topLeft: Radius.circular(5))),
      ));
    } else {
      if (mounted)
        setState(() {
          spinning = 0;
        });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
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
}
