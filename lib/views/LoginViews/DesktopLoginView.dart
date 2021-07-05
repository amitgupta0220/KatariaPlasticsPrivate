import 'package:KPPL/authentication/authenticate.dart';
import 'package:KPPL/main.dart';
import 'package:KPPL/styles.dart';
import 'package:KPPL/views/NewRegisterPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:html' as html;

class DesktopLoginView extends StatefulWidget {
  @override
  _DesktopLoginViewState createState() => _DesktopLoginViewState();
}

class _DesktopLoginViewState extends State<DesktopLoginView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget playStoreWidget = Image.asset("assets/PlayStore.png");
  bool showPass = true;
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  double spinning = 0;
  @override
  void initState() {
    super.initState();

    // getDistance('mumbai, maharashtra, india', 'nashik, maharashtra, india');
  }

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
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: size.width * 0.04),
              alignment: Alignment.topLeft,
              child: Image.asset(
                "assets/logo.png",
                height: size.height * 0.18,
              ),
            ),
            Container(
              height: size.height * 0.65,
              margin: EdgeInsets.only(
                left: size.width * 0.1,
                top: size.height * 0.2,
              ),
              color: Colors.transparent,
              child: Image.asset("assets/loginVector.png"),
            ),
            Positioned(
              top: size.height * 0.1,
              right: size.width * 0.07,
              height: size.height * 0.7,
              width: size.width * 0.3,
              child: Material(
                color: Colors.transparent,
                child: Container(
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.all(size.width * 0.035),
                            child: Column(
                              children: [
                                TextFormField(
                                  style: TextStyle(fontSize: 15),
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
                                      hintStyle: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xffB3B3B3)),
                                      // hintText: 'abc@def.com',
                                      labelText: "Email Address"),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                TextFormField(
                                  style: TextStyle(fontSize: 15),
                                  controller: _passController,
                                  autocorrect: _autoValidate,
                                  keyboardType: TextInputType.name,
                                  onEditingComplete: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    if (_formKey.currentState.validate()) {
                                      _checkIfUserExists();
                                    } else {
                                      setState(() {
                                        _autoValidate = true;
                                      });
                                    }
                                  },
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
                                            ? Icon(Icons.remove_red_eye)
                                            : Icon(
                                                Icons.no_encryption_outlined),
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
                                      hintStyle: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xffB3B3B3)),
                                      // hintText: 'abc@def.com',
                                      labelText: "Password"),
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
                                              _autoValidate = true;
                                              spinning = 0;
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
                                                  letterSpacing: 1.3,
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SpinKitThreeBounce(
                                        color: MyColors.red,
                                        size: spinning,
                                      ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                Center(
                                  child: Text(
                                    "Forgot Password ?",
                                    style: TextStyle(
                                        fontSize: 14,
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
                                        fontSize: 14,
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
            ),
            Positioned(
              right: size.width * 0.07,
              top: size.height * 0.805,
              child: Hero(
                tag: "signUpFromLogin",
                child: Material(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 1000),
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return RegisterPageTab();
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
                      width: size.width * 0.3,
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
                              letterSpacing: 1.3,
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
            Positioned(
              top: size.height * 0.89,
              right: size.width * 0.07,
              child: Hero(
                tag: "createAccountFromLogin",
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width * 0.3,
                    child: Text(
                      "Create an account in just 3 steps",
                      style: TextStyle(
                          color: MyColors.primaryNew,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
            // https://play.google.com/store/apps/details?id=com.KatariaPlastics.KPPL
            Positioned(
              bottom: 25,
              left: 10,
              child: Container(
                color: Colors.transparent,
                height: 50,
                child: InkWell(
                    onTap: () {
                      html.AnchorElement anchorElement = new html.AnchorElement(
                          href:
                              "https://play.google.com/store/apps/details?id=com.KatariaPlastics.KPPL");
                      anchorElement.download =
                          "https://play.google.com/store/apps/details?id=com.KatariaPlastics.KPPL";
                      anchorElement.target = "__blank";
                      anchorElement.click();
                    },
                    onHover: (boolean) {
                      if (boolean) {
                        print("hovered");
                        setState(() {
                          playStoreWidget = Image.asset(
                            "assets/hoveredPlayStore.png",
                            width: 150,
                          );
                        });
                      } else {
                        setState(() {
                          playStoreWidget =
                              Image.asset("assets/PlayStore.png", width: 150);
                        });
                      }
                    },
                    child: playStoreWidget),
              ),
            )
          ],
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
      setState(() {
        spinning = 0;
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "User is not registered",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        duration: Duration(seconds: 2),
        backgroundColor: MyColors.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5), topLeft: Radius.circular(5))),
      ));
    } else {
      signInUser();
    }
  }

  signInUser() async {
    Map result = await AuthService().signIn(
      email: _emailController.text.trim(),
      password: _passController.text.trim(),
    );
    displayMessage(result);
  }

  displayMessage(Map result) {
    if (result['success']) {
      // Future.delayed(Duration(seconds: 1), () {
      //   // Navigator.of(context).pop();
      //   Navigator.of(context).pushReplacement(MaterialPageRoute(
      //     builder: (context) => AdminPage(),
      //     // builder: (context) => MarketingView(),
      //   ));
      // });
      // _scaffoldKey.currentState.showSnackBar(SnackBar(
      //   content: Text(
      //     "Login Successful",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   elevation: 0,
      //   duration: Duration(milliseconds: 500),
      //   backgroundColor: MyColors.primary,
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.only(
      //           topRight: Radius.circular(5), topLeft: Radius.circular(5))),
      // ));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => SplashScreen(),
        // builder: (context) => MarketingView(),
      ));
    } else {
      setState(() {
        spinning = 0;
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
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
}
