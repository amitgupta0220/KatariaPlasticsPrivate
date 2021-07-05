import 'package:KPPL/authentication/UserModel.dart';
import 'package:KPPL/authentication/authenticate.dart';
import 'package:KPPL/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController userByAdminEmail = TextEditingController();
  final TextEditingController _rPhoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userByAdminPassword = TextEditingController();
  bool autoValidate = false;
  String _currentItem = 'Admin';
  @override
  Widget build(BuildContext context) {
    // Size cardSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 4.0,
              spreadRadius: 5.0,
              offset: Offset(
                0.0,
                0.0,
              ),
            )
          ],
        ),
        // height: cardSize.height / 4,
        // width: cardSize.width / 2,
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextFormField(
                autoValidate: autoValidate,
                keyboardType: TextInputType.name,
                labelText: 'Name',
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xFF03045E),
                ),
                controller: nameController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Enter name';
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
                controller: userByAdminEmail,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Email is required';
                  }
                },
              ),
              MyTextFormField(
                autoValidate: autoValidate,
                keyboardType: TextInputType.visiblePassword,
                labelText: 'Password',
                obsecureText: true,
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: Color(0xFF03045E),
                ),
                controller: userByAdminPassword,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Password is required';
                  }
                },
              ),
              MyTextFormField(
                autoValidate: autoValidate,
                maxLength: 10,
                keyboardType: TextInputType.phone,
                labelText: 'Phone',
                prefixIcon: Icon(
                  Icons.phone,
                  color: Color(0xFF03045E),
                ),
                controller: _rPhoneController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter phone number';
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: _currentItem,
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
                      _currentItem = newValue;
                    });
                  },
                  items: <String>['Admin', 'Marketer']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Center(
                  child: FlatButton(
                      onPressed: () async {
                        Map result = await AuthService().createUser(
                            email: userByAdminEmail.text.trim(),
                            password: userByAdminPassword.text.trim(),
                            user: UserModelByAdmin(
                              email: userByAdminEmail.text.trim(),
                              userType: _currentItem.toLowerCase(),
                              name: nameController.text,
                              phoneNumber: _rPhoneController.text,
                            ));
                        displayMessage(result);
                      },
                      color: Colors.black,
                      child: Text(
                        "Create",
                        style: TextStyle(color: Colors.white),
                      )))
            ],
          ),
        ),
      ),
    );
  }

  displayMessage(Map result) {
    if (result['success']) {
      _rPhoneController.clear();
      nameController.clear();
      userByAdminEmail.clear();
      userByAdminPassword.clear();
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
  final int maxLength;

  const MyTextFormField(
      {this.labelText,
      this.maxLength,
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
        maxLength: maxLength,
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
