import 'package:burgza/Pages/Email.dart';
import 'package:burgza/Services/Authentication.dart';
import 'package:burgza/Services/SharedPreferences.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'HomeScreen.dart';
import 'MainPage.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Authentication authentication = new Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          Center(
            child: Container(
              height: 200,
              width: 200,
              child: Column(
                children: [
                  Lottie.network(
                      'https://assets5.lottiefiles.com/private_files/lf30_o7BLXG.json'),
                  Text(
                    'BURGZA',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: EmailPage(),
                      type: PageTransitionType.leftToRightWithFade));
            },
            child: Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.email,
                        color: Colors.black,
                        size: 20,
                      ),
                      onPressed: null),
                  Text('SIGN UP WITH EMAIL',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              )),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 15),
                  child: Divider(
                    color: Colors.grey,
                    height: 50,
                  ),
                ),
              ),
              Text('OR', style: TextStyle(color: Colors.white)),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 15),
                  child: Divider(
                    color: Colors.grey,
                    height: 50,
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () async {
              await authentication.googleSignIn().whenComplete(() {
              
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: HomeScreen(),
                        type: PageTransitionType.leftToRightWithFade));
              });
            },
            child: Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        EvaIcons.google,
                        color: Colors.black,
                        size: 20,
                      ),
                      onPressed: null),
                  Text('SIGN UP WITH GOOGLE',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an acoount?',
                style: TextStyle(color: Colors.white),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: MainPage(),
                          type: PageTransitionType.leftToRightWithFade));
                },
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.yellow,
                      decorationThickness: 3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
