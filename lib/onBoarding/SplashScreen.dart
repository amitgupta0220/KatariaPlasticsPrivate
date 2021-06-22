import 'package:KPPL/HomeScreen.dart/HomePage.dart';
import 'package:KPPL/authentication/authenticate.dart';
import 'package:KPPL/onBoarding/OnBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:KPPL/styles.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  margin: EdgeInsets.only(
                      bottom: 5,
                      top: MediaQuery.of(context).size.height * 0.05),
                  child: Image.asset("assets/images/logo.png")),
            ),
            // Center(child: Text("Kataria Pipes"))
          ],
        ),
      ),
    );
  }

  splash() async {
    var isSignedIn = await AuthService().handleAuth();
    setState(() {});
    if (!isSignedIn) {
      await Future.delayed(Duration(milliseconds: 1500));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => OnBoardingScreens()));
    } else {
      await Future.delayed(Duration(milliseconds: 1500));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
    }
  }
}
