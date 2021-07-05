import 'package:KPPL/styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _currentIndex = 0;
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showPass = true;
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.9), BlendMode.dstATop),
                    image: new NetworkImage(
                      "https://image.freepik.com/free-vector/smooth-white-wave-background_52683-55288.jpg",
                    ),
                  )),
            ),
            Center(
              child: Container(
                height: size.height * 0.8,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: Offset(
                          0,
                          1,
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width * 0.4,
                      height: size.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                        color: MyColors.primary,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: size.height * 0.4,
                              // aspectRatio: 16 / 9,
                              onPageChanged: (index, _) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 2),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                            ),
                            items: imgList
                                .map((item) => Image.network(
                                      item,
                                      fit: BoxFit.cover,
                                      height: size.height * 0.4,
                                      width: size.width * 0.4,
                                    ))
                                .toList(),
                          ),
                          Container(
                              alignment: Alignment.bottomCenter,
                              // height: 150,
                              margin: EdgeInsets.fromLTRB(
                                16,
                                size.height * 0.27,
                                16,
                                size.height * 0.06,
                              ),
                              child: _buildIndicator())
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Form(
                          key: _formKey,
                          child: Container(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            // height: size.height,
                            width: size.width * 0.4,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: size.height * 0.2),
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
                                    validator: (value) =>
                                        _validateEmail(value.trim()),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        hintStyle: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff9D9D9D)),
                                        // hintText: 'abc@def.com',
                                        labelText: "Email Address"),
                                  ),
                                  SizedBox(height: size.height * 0.05),
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
                                      if (value.isEmpty ||
                                          !(value.length > 5)) {
                                        return 'Enter valid password';
                                      }
                                      return null;
                                    },
                                    obscureText: showPass,
                                    obscuringCharacter: '*',
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
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
                                        hintStyle: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff9D9D9D)),
                                        // hintText: 'Password',
                                        labelText: "Password"),
                                  ),
                                  SizedBox(height: size.height * 0.05),
                                  GestureDetector(
                                    onTap: () async {},
                                    child: Container(
                                      margin: EdgeInsets.only(top: 16),
                                      decoration: BoxDecoration(
                                          color: MyColors.primary,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      width: size.width * 0.1,
                                      height: size.height * 0.08,
                                      child: Center(
                                        child: Text("Login",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(size.width * 0.02),
                          alignment: Alignment.bottomRight,
                          child: Row(
                            children: [
                              Text("Don't have an account yet? "),
                              Text(
                                "REGISTER",
                                style: TextStyle(color: MyColors.primary),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
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

  Row _buildIndicator() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
            imgList.length, (index) => _pageIndicator(_currentIndex == index)));
  }

  Widget _pageIndicator(bool isCurrent) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: isCurrent ? 16 : 4,
      height: isCurrent ? 4 : 4,
      decoration: BoxDecoration(
          // border: Border.all(color: MyColors.primary, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          // shape: BoxShape.circle,
          color:
              isCurrent ? Colors.white : Color.fromRGBO(255, 255, 255, 0.43)),
    );
  }
}
