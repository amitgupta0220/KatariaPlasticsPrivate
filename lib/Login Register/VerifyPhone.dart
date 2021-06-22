import 'package:KPPL/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPhone extends StatefulWidget {
  final String phone, type;
  VerifyPhone(this.phone, this.type);
  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController textEditingController = TextEditingController();
  String currentText = "", vericationID = "";
  final _formKey = GlobalKey<FormState>();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  void initState() {
    super.initState();
    // verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width * 0.11,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () => {Navigator.of(context).pop()},
            child: Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03),
                child: SvgPicture.asset('assets/images/arrow.svg'))),
      ),
      backgroundColor: MyColors.background,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.16),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('OTP',
                      style: TextStyle(color: Color(0xff1c1c1c), fontSize: 22)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Text(
                    'Please enter the code we just sent to\n your phone to proceed.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Color(0xff858585)),
                  ),
                  SizedBox(height: 20),
                  Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        textStyle: TextStyle(fontFamily: 'Lato'),
                        appContext: context,
                        pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato'),
                        length: 6,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v.length < 6) {
                            return "Enter all Digits properly";
                          } else {
                            return null;
                          }
                        },
                        backgroundColor: MyColors.background,
                        pinTheme: PinTheme(
                          inactiveColor: Color(0xffc5c5c5),
                          selectedColor: MyColors.primary,
                          shape: PinCodeFieldShape.box,
                          fieldHeight: 50,
                          fieldWidth: 40,
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        // backgroundColor: Colors.blue.shade50,
                        // enableActiveFill: true,
                        autoDismissKeyboard: true,
                        // errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        onCompleted: (v) {
                          // print("Done");
                        },
                        // onTap: () {
                        // },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          return true;
                        },
                      )),
                  GestureDetector(
                    onTap: () async {
                      AuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: vericationID,
                        smsCode: currentText,
                      );
                      print(credential.toString());
                      UserCredential result;
                      try {
                        result = await _auth.currentUser
                            .linkWithCredential(credential);
                      } catch (e) {
                        //   // throw e;
                        print("negative");
                      }
                      print(result);

                      if (result.user.uid != null) print("done");
                      print("negative");
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.05),
                      decoration: BoxDecoration(
                          color: MyColors.primary,
                          borderRadius: BorderRadius.circular(4)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Center(
                        child: Text("Confirm",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.085,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Didn’t receive OTP?',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff858585)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        child: Text(
                          'Resend',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 14, color: MyColors.primary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91 8097847708", //widget.phone,
      verificationCompleted: (PhoneAuthCredential credential) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            "Verification Done",
            style: TextStyle(color: Colors.white, fontFamily: 'Lato'),
          ),
          elevation: 0,
          duration: Duration(seconds: 2),
          backgroundColor: MyColors.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5), topLeft: Radius.circular(5))),
        ));
      },
      verificationFailed: (FirebaseAuthException e) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            "Verification Failed",
            style: TextStyle(color: Colors.white, fontFamily: 'Lato'),
          ),
          elevation: 0,
          duration: Duration(seconds: 2),
          backgroundColor: MyColors.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5), topLeft: Radius.circular(5))),
        ));
      },
      codeSent: (String verificationId, int resendToken) {
        this.vericationID = verificationId;
        setState(() {});
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            "Code sent to ${widget.phone}",
            style: TextStyle(color: Colors.white, fontFamily: 'Lato'),
          ),
          elevation: 0,
          duration: Duration(seconds: 2),
          backgroundColor: MyColors.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5), topLeft: Radius.circular(5))),
        ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.vericationID = verificationId;
        setState(() {});
      },
    );
  }
}
