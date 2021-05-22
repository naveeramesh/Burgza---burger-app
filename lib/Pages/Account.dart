import 'package:burgza/Pages/Cart.dart';
import 'package:burgza/Pages/Favourites.dart';
import 'package:burgza/Pages/Info.dart';
import 'package:burgza/Pages/Login.dart';
import 'package:burgza/Services/Authentication.dart';
import 'package:burgza/Services/SharedPreferences.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Authentication authentication = Authentication();

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('ACCOUNT SETTINGS',
                style: TextStyle(color: Colors.white, letterSpacing: 2)),
          ),
          body: Container(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 400,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                              SharedPrefernces.sharedPreferences
                                  .getString('username'),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 80,
                          ),
                          Icon(EvaIcons.google, color: Colors.yellow[800]),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                                SharedPrefernces.sharedPreferences
                                    .getString('email'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 125,
                ),
                Container(
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[800],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text('ADD TO CART',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'All your cart items will be available',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        trailing: IconButton(
                            icon: Align(
                              child: Icon(Icons.arrow_forward_ios_outlined,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: Cart(),
                                      type: PageTransitionType
                                          .rightToLeftWithFade));
                            }),
                      ),
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text('ADD TO FAVOURITES',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'All your favourite items will be available',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        trailing: IconButton(
                            icon: Align(
                              child: Icon(Icons.arrow_forward_ios_outlined,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: Favourites(),
                                      type: PageTransitionType
                                          .rightToLeftWithFade));
                            }),
                      ),
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: [
                              Text('INFO',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Icon(Icons.info_outline,
                                    color: Colors.white, size: 15),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'All the information regarding the app and food available ',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        trailing: IconButton(
                            icon: Align(
                              child: Icon(Icons.arrow_forward_ios_outlined,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: Info(),
                                      type: PageTransitionType
                                          .rightToLeftWithFade));
                            }),
                      ),
                      SizedBox(height: 100),
                      GestureDetector(
                        onTap: () async {
                          await authentication.googleSignOut()
                             .whenComplete(() {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: Login(),
                                    type: PageTransitionType
                                        .leftToRightWithFade));
                          });
                        },
                        child: Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.yellow[700],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text('SIGN OUT',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
