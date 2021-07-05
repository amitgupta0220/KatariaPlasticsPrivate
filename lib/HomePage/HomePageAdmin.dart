import 'dart:ui';
import 'package:KPPL/HomePage/CreateUser.dart';
import 'package:KPPL/HomePage/Marketing.dart';
import 'package:KPPL/authentication/authenticate.dart';
import 'package:KPPL/styles.dart';
import 'package:KPPL/HomePage/AddConsignment.dart';
import 'package:KPPL/HomePage/HomePage.dart';
import 'package:KPPL/HomePage/ViewTransporterApplications.dart';
import 'package:KPPL/views/NewLogin.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int currentIndex = 0;
  double widthOfContainer;
  bool expanded = false;
  List<Widget> widgetList = [
    HomePage(),
    ViewTransporterApplications(),
    AddConsignment(),
    CreateUser(),
    Marketing(),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: size.height,
          width: size.width,
          child: Row(
            children: [
              Container(
                width: widthOfContainer ??
                    MediaQuery.of(context).size.width * 0.03,
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = 0;
                              });
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.08,
                                height:
                                    MediaQuery.of(context).size.width * 0.028,
                                decoration: currentIndex == 0
                                    ? BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                            colors: [
                                            Color.fromRGBO(0, 149, 255, 0.0001),
                                            Color.fromRGBO(
                                                0, 149, 255, 0.288134),
                                          ]))
                                    : BoxDecoration(color: Colors.black),
                                // margin: EdgeInsets.only(
                                //     top: MediaQuery.of(context).size.width * 0.01),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.home,
                                      color: currentIndex == 0
                                          ? MyColors.primaryNew
                                          : Colors.white,
                                    ),
                                    expanded
                                        ? Text(
                                            "Home",
                                            style: TextStyle(
                                              color: currentIndex == 0
                                                  ? MyColors.primaryNew
                                                  : Colors.white,
                                            ),
                                          )
                                        : Container()
                                  ],
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = 1;
                              });
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.08,
                                height:
                                    MediaQuery.of(context).size.width * 0.028,
                                decoration: currentIndex == 1
                                    ? BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                            colors: [
                                            Color.fromRGBO(0, 149, 255, 0.0001),
                                            Color.fromRGBO(
                                                0, 149, 255, 0.288134),
                                          ]))
                                    : BoxDecoration(color: Colors.black),
                                // margin: EdgeInsets.only(
                                //     top: MediaQuery.of(context).size.width * 0.01),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: currentIndex == 1
                                          ? MyColors.primaryNew
                                          : Colors.white,
                                    ),
                                    expanded
                                        ? Text(
                                            "Transporter",
                                            style: TextStyle(
                                              color: currentIndex == 1
                                                  ? MyColors.primaryNew
                                                  : Colors.white,
                                            ),
                                          )
                                        : Container()
                                  ],
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = 2;
                              });
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.08,
                                height:
                                    MediaQuery.of(context).size.width * 0.028,
                                decoration: currentIndex == 2
                                    ? BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                            colors: [
                                            Color.fromRGBO(0, 149, 255, 0.0001),
                                            Color.fromRGBO(
                                                0, 149, 255, 0.288134),
                                          ]))
                                    : BoxDecoration(color: Colors.black),
                                // margin: EdgeInsets.only(
                                //     top: MediaQuery.of(context).size.width * 0.01),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.file_copy,
                                      color: currentIndex == 2
                                          ? MyColors.primaryNew
                                          : Colors.white,
                                    ),
                                    expanded
                                        ? Text(
                                            "Consignment",
                                            style: TextStyle(
                                              color: currentIndex == 2
                                                  ? MyColors.primaryNew
                                                  : Colors.white,
                                            ),
                                          )
                                        : Container()
                                  ],
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = 3;
                              });
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.08,
                                height:
                                    MediaQuery.of(context).size.width * 0.028,
                                decoration: currentIndex == 3
                                    ? BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                            colors: [
                                            Color.fromRGBO(0, 149, 255, 0.0001),
                                            Color.fromRGBO(
                                                0, 149, 255, 0.288134),
                                          ]))
                                    : BoxDecoration(color: Colors.black),
                                // margin: EdgeInsets.only(
                                //     top: MediaQuery.of(context).size.width * 0.01),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: currentIndex == 3
                                          ? MyColors.primaryNew
                                          : Colors.white,
                                    ),
                                    expanded
                                        ? Text(
                                            "Create",
                                            style: TextStyle(
                                              color: currentIndex == 3
                                                  ? MyColors.primaryNew
                                                  : Colors.white,
                                            ),
                                          )
                                        : Container()
                                  ],
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = 4;
                              });
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.08,
                                height:
                                    MediaQuery.of(context).size.width * 0.028,
                                decoration: currentIndex == 4
                                    ? BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                            colors: [
                                            Color.fromRGBO(0, 149, 255, 0.0001),
                                            Color.fromRGBO(
                                                0, 149, 255, 0.288134),
                                          ]))
                                    : BoxDecoration(color: Colors.black),
                                // margin: EdgeInsets.only(
                                //     top: MediaQuery.of(context).size.width * 0.01),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person_pin,
                                      color: currentIndex == 4
                                          ? MyColors.primaryNew
                                          : Colors.white,
                                    ),
                                    expanded
                                        ? Text(
                                            "Marketing",
                                            style: TextStyle(
                                              color: currentIndex == 4
                                                  ? MyColors.primaryNew
                                                  : Colors.white,
                                            ),
                                          )
                                        : Container()
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            expanded
                                ? setState(() {
                                    widthOfContainer =
                                        MediaQuery.of(context).size.width *
                                            0.03;
                                    expanded = !expanded;
                                  })
                                : setState(() {
                                    widthOfContainer =
                                        MediaQuery.of(context).size.width *
                                            0.08;
                                    expanded = !expanded;
                                  });
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.08,
                              height: MediaQuery.of(context).size.width * 0.028,
                              decoration: BoxDecoration(color: Colors.black),
                              // margin: EdgeInsets.only(
                              //     top: MediaQuery.of(context).size.width * 0.01),
                              child: expanded
                                  ? Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_back_ios_rounded,
                                          color: Colors.white,
                                        ),
                                        expanded
                                            ? Text(
                                                "Hide",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Container()
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white,
                                        ),
                                      ],
                                    )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await AuthService().signOut();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (_) => LoginPageTab()));
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.08,
                              height: MediaQuery.of(context).size.width * 0.028,
                              decoration: BoxDecoration(color: Colors.black),
                              // margin: EdgeInsets.only(
                              //     top: MediaQuery.of(context).size.width * 0.01),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.exit_to_app,
                                    color: Colors.white,
                                  ),
                                  expanded
                                      ? Text(
                                          "Sign Out",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      : Container()
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.01,
                    right: MediaQuery.of(context).size.width * 0.01,
                    top: MediaQuery.of(context).size.width * 0.01,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      )),
                  child: widgetList[currentIndex],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
