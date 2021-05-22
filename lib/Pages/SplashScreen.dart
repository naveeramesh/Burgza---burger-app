import 'dart:async';
import 'package:burgza/Pages/HomeScreen.dart';
import 'package:burgza/Pages/Login.dart';
import 'package:burgza/Services/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userid;
  @override
  void initState() {
    userid = SharedPrefernces.sharedPreferences.getString('email');

    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                child: userid == null ? Login() : HomeScreen(),
                type: PageTransitionType.rightToLeftWithFade)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 300,
          width: 500,
        ),
        Container(
          height: 200,
          child: Lottie.network(
              'https://assets5.lottiefiles.com/private_files/lf30_o7BLXG.json'),
        ),
        Text(
          'BURGZA',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontSize: 25),
        ),
        SizedBox(
          height: 350,
        ),
        Text('FROM THE HOUSE OF GERMANY',
            style: GoogleFonts.lato(
              textStyle: TextStyle(color: Colors.white, letterSpacing: 2),
            )),
      ],
    ));
  }
}
