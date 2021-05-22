import 'package:burgza/Pages/Forget.dart';
import 'package:burgza/Services/ErrorAlertDialog.dart';
import 'package:burgza/Services/SharedPreferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'HomeScreen.dart';
import 'SignUpPage.dart';

String _email, _password;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  Future<void> _login() async {
    User firebaseUser;

    await _firebaseAuth
        .signInWithEmailAndPassword(
            email: emailcontroller.text.trim(),
            password: passwordcontroller.text.trim())
        .then((auth) {
      firebaseUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(message: error.message.toString());
          });
    });
    if (firebaseUser != null) {
      readdata(firebaseUser).then((s) {
        Route route = MaterialPageRoute(builder: (c) => HomeScreen());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  readdata(User fuser) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(fuser.uid)
        .get()
        .then((dataSnapshot) async {
      await SharedPrefernces.sharedPreferences
          .setString('username', dataSnapshot.data()['name']);
      await SharedPrefernces.sharedPreferences
          .setString("uid", dataSnapshot.data()['uid']);
      await SharedPrefernces.sharedPreferences
          .setString("email", dataSnapshot.data()['email']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            width: 200,
            child: Column(
              children: [
                SizedBox(
                  height: 90,
                ),
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
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: TextField(
                cursorColor: Colors.yellow[900],
                controller: emailcontroller,
                onChanged: (value) {
                  _email = value;
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: ('Email'),
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: TextField(
                cursorColor: Colors.yellow[900],
                controller: passwordcontroller,
                style: TextStyle(color: Colors.white),
                obscureText: true,
                onChanged: (value) {
                  _password = value;
                },
                decoration: InputDecoration(
                  hintText: ('Password'),
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                ),
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
                      child: Forget(), type: PageTransitionType.fade));
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 240.0),
                child: Text(
                  'Forgot Password ?',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () async {
              emailcontroller.text.isEmpty && passwordcontroller.text.isEmpty
                  ? showAlertDialog(context)
                  : _login();
            },
            child: Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.yellow[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text(
                'LOGIN',
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
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
              child: Text(
                'NEW ? CREATE AN ACCOUNT',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget button = FlatButton(
    child: Text('OK'),
    onPressed: () {
      Navigator.pushReplacement(context,
          PageTransition(child: MainPage(), type: PageTransitionType.fade));
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text('Please provide valid email and password '),
    actions: [
      button,
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
