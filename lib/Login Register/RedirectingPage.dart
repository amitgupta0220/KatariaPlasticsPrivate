import 'package:KPPL/Login%20Register/LoginPage.dart';
import 'package:KPPL/Login%20Register/RegisterPage.dart';
import 'package:KPPL/styles.dart';
import 'package:flutter/material.dart';

class RedirectingPage extends StatefulWidget {
  @override
  _RedirectingPageState createState() => _RedirectingPageState();
}

class _RedirectingPageState extends State<RedirectingPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 2);
    tabController.addListener(_tabSelect);
  }

  void _tabSelect() {
    setState(() {
      _currentIndex = tabController.index;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.background,
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.05,
                // ),
                Center(
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.12,
                      margin: EdgeInsets.only(
                          bottom: 5,
                          top: MediaQuery.of(context).size.height * 0.05),
                      child: Image.asset("assets/images/logo.png")),
                ),
                Row(children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        tabController.index = 0;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: _currentIndex == 0
                            ? MyColors.primary
                            : MyColors.secondary,
                      ),
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.25),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: _currentIndex == 0
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.23,
                      height: MediaQuery.of(context).size.width * 0.08,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        tabController.index = 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: _currentIndex == 1
                                ? MyColors.primary
                                : MyColors.secondary,
                          ),
                          child: Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: _currentIndex == 1
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.23),
                          width: MediaQuery.of(context).size.width * 0.23,
                          height: MediaQuery.of(context).size.width * 0.08),
                    ),
                  ),
                ]),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[LoginPage(), RegisterPage()],
                    controller: tabController,
                  ),
                )
              ],
            )));
  }
}
