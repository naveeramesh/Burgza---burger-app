import 'package:burgza/Pages/SignUpPage.dart';
import 'package:burgza/Pages/admin.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import 'MainPage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
            ),
            Center(
              child: Container(
                height: 300,
                width: 400,
                child: Lottie.network(
                    'https://assets5.lottiefiles.com/private_files/lf30_o7BLXG.json'),
              ),
            ),
            Text(
              'BURGZA',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
            SizedBox(
              height: 200,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: MainPage(),
                      type: PageTransitionType.leftToRightWithFade,
                    ));
              },
              child: Container(
                height: 40,
                width: 150,
                child: Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.yellow[900],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: SignUp(),
                        type: PageTransitionType.leftToRightWithFade));
              },
              child: Container(
                height: 40,
                width: 150,
                child: Center(
                  child: Text(
                    'SIGNUP',
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.yellow[900],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height:10
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: Admin(),
                        type: PageTransitionType.leftToRightWithFade));
              },
              child: Container(child: Text('IF YOU ARE AN ADMIN? LOGIN',style: TextStyle(color:Colors.white,fontSize: 10),)),
            ),
          ],
        ),
      ),
    );
  }
}
