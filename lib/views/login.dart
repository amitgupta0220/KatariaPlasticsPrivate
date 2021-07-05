import 'package:KPPL/HomePage/HomePageAdmin.dart';
import 'package:KPPL/authentication/UserModel.dart';
import 'package:KPPL/authentication/authenticate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:KPPL/styles.dart';
import 'package:flutter/services.dart';
import 'package:KPPL/HomePage/HomePage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool autoValidate = false;
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            children: [
              MyTextFormField(
                autoValidate: autoValidate,
                keyboardType: TextInputType.emailAddress,
                labelText: 'Email',
                prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xFF03045E),
                ),
                controller: _emailController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter your Email';
                  }
                },
              ),
              MyTextFormField(
                autoValidate: autoValidate,
                labelText: 'Password',
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xFF03045E),
                ),
                controller: _passwordController,
                obsecureText: true,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter your Password';
                  }
                  if (value.length < 6) {
                    return 'Min. Characters should be 6';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _checkIfUserExists();
                    } else {
                      setState(() {
                        autoValidate = true;
                      });
                    }
                  },
                  color: Color(0xFF03045E),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _checkIfUserExists() async {
    final user = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: _emailController.text.trim().toLowerCase())
        .limit(1)
        .get();
    if (user.docs.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
        password: _passwordController.text.trim(),
        typeOfUser: "transporter");
    displayMessage(result);
  }

  displayMessage(Map result) {
    if (result['success']) {
      Future.delayed(Duration(seconds: 1), () {
        // Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AdminPage(),
        ));
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Login Successful",
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _rformKey = GlobalKey<FormState>();

  final TextEditingController _rNameController = TextEditingController();
  final TextEditingController _rPhoneController = TextEditingController();
  final TextEditingController _rEmailController = TextEditingController();
  final TextEditingController _rPasswordController = TextEditingController();
  final TextEditingController _rCompanyNameController = TextEditingController();
  final TextEditingController _rRegNumberController = TextEditingController();
  final TextEditingController _rPANController = TextEditingController();
  bool autoValidate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            // autovalidateMode: AutovalidateMode.always,
            key: _rformKey,
            child: Column(
              children: [
                MyTextFormField(
                  autoValidate: autoValidate,
                  keyboardType: TextInputType.text,
                  labelText: 'Full Name',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color(0xFF03045E),
                  ),
                  controller: _rNameController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter your Name';
                    }
                  },
                ),
                MyTextFormField(
                  autoValidate: autoValidate,
                  keyboardType: TextInputType.phone,
                  labelText: 'Contact',
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Color(0xFF03045E),
                  ),
                  controller: _rPhoneController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter your Contact';
                    }
                  },
                ),
                MyTextFormField(
                  autoValidate: autoValidate,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Email',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Color(0xFF03045E),
                  ),
                  controller: _rEmailController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter your Email';
                    }
                  },
                ),
                MyTextFormField(
                  autoValidate: autoValidate,
                  labelText: 'Password',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color(0xFF03045E),
                  ),
                  controller: _rPasswordController,
                  obsecureText: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter your Password';
                    }
                    if (value.length < 6) {
                      return 'Min. Characters should be 6';
                    }
                  },
                ),
                MyTextFormField(
                  autoValidate: autoValidate,
                  keyboardType: TextInputType.text,
                  labelText: 'Comapany Name',
                  prefixIcon: Icon(
                    Icons.business_center,
                    color: Color(0xFF03045E),
                  ),
                  controller: _rCompanyNameController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter your Company Name';
                    }
                  },
                ),
                MyTextFormField(
                  autoValidate: autoValidate,
                  keyboardType: TextInputType.text,
                  labelText: 'Registration Number',
                  prefixIcon: Icon(
                    Icons.app_registration,
                    color: Color(0xFF03045E),
                  ),
                  controller: _rRegNumberController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter Registration Number';
                    }
                  },
                ),
                MyTextFormField(
                  autoValidate: autoValidate,
                  keyboardType: TextInputType.text,
                  labelText: 'PAN Number',
                  prefixIcon: Icon(
                    Icons.contact_page,
                    color: Color(0xFF03045E),
                  ),
                  controller: _rPANController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter PAN Number';
                    }
                  },
                ),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: RaisedButton(
                    onPressed: () {
                      if (_rformKey.currentState.validate()) {
                        registerUser();
                      } else {
                        setState(() {
                          autoValidate = true;
                        });
                      }
                    },
                    color: Color(0xFF03045E),
                    child: Text(
                      'Signup',
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    ),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  registerUser() async {
    Map result = await AuthService().signUp(
        typeOfUser: "transporter",
        user: UserModel(
          userType: "transporter",
          companyName: _rCompanyNameController.text.trim(),
          email: _rEmailController.text.trim(),
          panNumber: _rPANController.text.trim(),
          password: _rPasswordController.text.trim(),
          phone: _rPhoneController.text.trim(),
          registrationNumber: _rRegNumberController.text.trim(),
          username: _rNameController.text.trim(),
          verified: false,
          // photoUrl:,
          // companyType: "",
        ));
    displayResult(result);
  }

  displayResult(Map result) {
    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Sign-up Successful",
          style: TextStyle(color: Colors.white),
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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

class MyTextFormField extends StatelessWidget {
  final String labelText;
  final Function validator;
  final TextEditingController controller;
  final TextStyle style;
  final TextInputType keyboardType;
  final bool obsecureText, autoValidate;
  final Icon prefixIcon;
  final List<TextInputFormatter> inputFormatter;

  const MyTextFormField(
      {this.labelText,
      this.autoValidate,
      this.validator,
      this.controller,
      this.style,
      this.keyboardType = TextInputType.text,
      this.obsecureText = false,
      this.prefixIcon,
      this.inputFormatter});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
        autocorrect: autoValidate,
        // autovalidateMode: AutovalidateMode.always,
        style: style,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Color(0xFF03045E),
          ),
          prefixIcon: prefixIcon,
          prefixText: '  ',
          contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xFF03045E),
          )),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF03045E))),
          errorBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        ),
        validator: validator,
        obscureText: obsecureText,
        controller: controller,
        keyboardType: keyboardType,
      ),
    );
  }
}
