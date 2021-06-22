import 'package:KPPL/HomeScreen.dart/HomePage.dart';
import 'package:KPPL/authentication/authenticate.dart';
import 'package:KPPL/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showPass = true;
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: MyColors.background,
        body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  // Text(
                  //   "Email address",
                  //   style: TextStyle(fontSize: 14, color: Color(0xff222222)),
                  // ),
                  TextFormField(
                    style: TextStyle(fontSize: 15),
                    controller: _emailController,
                    autocorrect: _autoValidate,
                    // style: TextStyle(fontSize: 20, fontFamily: 'Roboto'),
                    keyboardType: TextInputType.emailAddress,
                    // onSaved: (value) => _email = value.trim(),
                    validator: (value) => _validateEmail(value.trim()),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4)),
                        hintStyle:
                            TextStyle(fontSize: 15, color: Color(0xff9D9D9D)),
                        // hintText: 'abc@def.com',
                        labelText: "Email Address"),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  // Text(
                  //   "Password",
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(fontSize: 14, color: Color(0xff222222)),
                  // ),
                  TextFormField(
                    style: TextStyle(fontSize: 15),
                    controller: _passController,
                    autocorrect: _autoValidate,
                    // style: TextStyle(fontSize: 20, fontFamily: 'Roboto'),
                    // onSaved: (value) => _email = value.trim(),
                    validator: (value) {
                      if (value.isEmpty || !(value.length > 5)) {
                        return 'Enter valid password';
                      }
                      return null;
                    },
                    obscureText: showPass, obscuringCharacter: '*',
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4)),
                        suffixIcon: IconButton(
                          icon: showPass
                              ? SvgPicture.asset(
                                  "assets/images/feather_eye.svg")
                              : SvgPicture.asset(
                                  "assets/images/hide_feather_eye.svg"),
                          onPressed: () {
                            setState(() {
                              showPass = !showPass;
                            });
                          },
                        ),
                        hintStyle:
                            TextStyle(fontSize: 15, color: Color(0xff9D9D9D)),
                        // hintText: 'Password',
                        labelText: "Password"),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState.validate()) {
                        _checkIfUserExists();
                      } else {
                        setState(() {
                          _autoValidate = true;
                        });
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                          color: MyColors.primary,
                          borderRadius: BorderRadius.circular(4)),
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      child: Center(
                        child: Text("Login",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
