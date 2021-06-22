import 'dart:io';

import 'package:KPPL/Login%20Register/VerifyPhone.dart';
import 'package:KPPL/authentication/UserModel.dart';
import 'package:KPPL/authentication/authenticate.dart';
import 'package:KPPL/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showPass = true;
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _registrationController = TextEditingController();
  final _panController = TextEditingController();
  final _nameCompanyController = TextEditingController();
  final _passController = TextEditingController();
  String dropdownCompanyType = 'Sole Proprietor';
  String dropdownRegistration = 'Incorporation Certificate';
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
                    TextFormField(
                      style: TextStyle(fontSize: 15),
                      controller: _nameController,
                      autocorrect: _autoValidate,
                      keyboardType: TextInputType.name,
                      // validator: (value) {},
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4)),
                          hintStyle:
                              TextStyle(fontSize: 15, color: Color(0xff9D9D9D)),
                          labelText: "Full Name"),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    TextFormField(
                      style: TextStyle(fontSize: 15),
                      controller: _nameCompanyController,
                      autocorrect: _autoValidate,
                      keyboardType: TextInputType.name,
                      // validator: (value) {},
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4)),
                          hintStyle:
                              TextStyle(fontSize: 15, color: Color(0xff9D9D9D)),
                          labelText: "Company Name"),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: dropdownCompanyType,
                        // icon: Icon(Icons.language),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: MyColors.primary),
                        underline: Container(
                          height: 2,
                          color: MyColors.secondary,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownCompanyType = newValue;
                          });
                        },
                        items: <String>[
                          'Sole Proprietor',
                          'Private Limited',
                          'Limited'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    TextFormField(
                      style: TextStyle(fontSize: 15),
                      controller: _emailController,
                      autocorrect: _autoValidate,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => _validateEmail(value.trim()),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4)),
                          hintStyle:
                              TextStyle(fontSize: 15, color: Color(0xff9D9D9D)),
                          labelText: "Email Address"),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    TextFormField(
                      style: TextStyle(fontSize: 15),
                      controller: _passController,
                      autocorrect: _autoValidate,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value.isEmpty || !(value.length > 5)) {
                          return 'Enter valid password';
                        }
                        return null;
                      },
                      obscureText: showPass,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
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
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4)),
                          hintStyle:
                              TextStyle(fontSize: 15, color: Color(0xff9D9D9D)),
                          labelText: "Password"),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: dropdownRegistration,
                        // icon: Icon(Icons.language),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: MyColors.primary),
                        underline: Container(
                          height: 2,
                          color: MyColors.secondary,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownRegistration = newValue;
                          });
                        },
                        items: <String>[
                          'Incorporation Certificate',
                          'GST',
                          'Registration Certificate'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Upload certificate of Registration:",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: MyColors.primary,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          padding: EdgeInsets.all(8.0),
                          child: _image == null
                              ? Image.asset("assets/images/addPhoto.png")
                              : Image.file(
                                  _image,
                                  fit: BoxFit.cover,
                                )),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    TextFormField(
                      style: TextStyle(fontSize: 15),
                      controller: _registrationController,
                      autocorrect: _autoValidate,
                      keyboardType: TextInputType.text,
                      // validator: (value) {},
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4)),
                          hintStyle:
                              TextStyle(fontSize: 15, color: Color(0xff9D9D9D)),
                          labelText: "Registration Number"),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    TextFormField(
                      style: TextStyle(fontSize: 15),
                      controller: _panController,
                      autocorrect: _autoValidate,
                      keyboardType: TextInputType.emailAddress,
                      // validator: (value) {},
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4)),
                          hintStyle:
                              TextStyle(fontSize: 15, color: Color(0xff9D9D9D)),
                          labelText: "PAN Number"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Upload PAN card copy",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: MyColors.primary,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showPickerPan(context);
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          padding: EdgeInsets.all(8.0),
                          child: _imagePan == null
                              ? Image.asset("assets/images/addPhoto.png")
                              : Image.file(
                                  _imagePan,
                                  fit: BoxFit.cover,
                                )),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    TextFormField(
                      style: TextStyle(fontSize: 15),
                      controller: _phoneController,
                      autocorrect: _autoValidate,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      // validator: (value) {},
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4)),
                          hintStyle:
                              TextStyle(fontSize: 15, color: Color(0xff9D9D9D)),
                          labelText: "Mobile Number"),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState.validate()) {
                          registerUser();
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
                          child: Text("Register",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  registerUser() async {
    Map result = await AuthService().signUp(
        typeOfUser: "transporter",
        user: UserModel(
          userType: "transporter",
          companyName: _nameCompanyController.text.trim(),
          email: _emailController.text.trim(),
          panNumber: _panController.text.trim(),
          password: _passController.text.trim(),
          phone: _phoneController.text.trim(),
          registrationNumber: _registrationController.text.trim(),
          username: _nameController.text.trim(),
          verified: false,
          // photoUrl:,
          companyType: dropdownCompanyType,
        ));
    displayResult(result);
  }

  displayResult(Map result) {
    if (result['success']) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
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
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyPhone(
                    _emailController.text.trim().toLowerCase(),
                    'transporter')));
      });
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

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter valid email';
    else
      return null;
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
}
