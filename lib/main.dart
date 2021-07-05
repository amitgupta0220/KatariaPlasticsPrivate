import 'package:KPPL/AdminHomePage/AdminPageNavigation.dart';
import 'package:KPPL/HomePage/marketingView.dart';
import 'package:KPPL/TransporterHomePage/TransporterNavPage.dart';
import 'package:KPPL/authentication/AuthService.dart';
import 'package:KPPL/views/NewLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationProvider>().authState,
        )
      ],
      child: MaterialApp(
        title: 'Kataria Projects',
        debugShowCheckedModeBanner: false,
        // initialRoute: '/login',
        // routes: {
        //   'login':(context)=>LoginTab(),
        //   '/main': (context) => AdminPage(),
        //   '/addConsignment': (context) => AddConsignment(),
        //   '/createUser': (context) => CreateUser(),
        //   '/HomePage': (context) => HomePage(),
        //   '/marketing': (context) => Marketing(),
        //   '/viewTransporter': (context) => ViewTransporterApplications(),
        // },
        theme: ThemeData(
            textTheme: GoogleFonts.latoTextTheme(),
            primaryColor: Color(0xFF03045E),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            textSelectionTheme:
                TextSelectionThemeData(cursorColor: Color(0xFF03045E))),
        home: Authenticate(),
      ),
    );
  }
}

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     splash();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }

//   splash() async {
//     var isSignedIn = await AuthService().handleAuth();
//     setState(() {});
//     if (!isSignedIn) {
//       // await Future.delayed(Duration(milliseconds: 1000));
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => LoginPageTab()));
//     } else {
//       // await Future.delayed(Duration(milliseconds: 1000));
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => AdminPage()));
//     }
//   }
// }

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print(FirebaseAuth.instance.currentUser.uid);
    //Instance to know the authentication state.
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      //Means that the user is logged in already and hence navigate to HomePage
      return SplashScreen();
    } else {
      return LoginPageTab();
    }
    //The user isn't logged in and hence navigate to SignInPage.
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String type = "";
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.email)
        .get()
        .then((value) {
      type = value.data()["userType"];
      if (mounted) temp();
    });
    super.initState();
  }

  temp() {
    if (type == "marketer") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => MarketingView()));
    } else if (type == "transporter") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => TransporterNavPage()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => AdminNavigation()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
