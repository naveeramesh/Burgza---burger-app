import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import 'Account.dart';
import 'Cart.dart';
import 'NewScreen.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchcontroller = new TextEditingController();
  String name;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 60,
              child: Row(
                children: [
                  Lottie.network(
                      'https://assets5.lottiefiles.com/private_files/lf30_o7BLXG.json'),
                  Text('BURGZA',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))),
                  SizedBox(
                    width: 120,
                  ),
                  IconButton(
                      icon: Icon(Icons.account_circle_rounded,
                          color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: Account(),
                                type: PageTransitionType.rightToLeftWithFade));
                      }),
                  IconButton(
                      icon: Icon(EvaIcons.shoppingCartOutline,
                          color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: Cart(),
                                type: PageTransitionType.rightToLeftWithFade));
                      })
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 400,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                  cursorColor: Colors.yellow,
                  controller: searchcontroller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: 'Search your first bite..',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                    suffixIcon:
                        Icon(Icons.search, color: Colors.white, size: 20),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: (name != "" && name != null)
                      ? FirebaseFirestore.instance
                          .collection('Hot')
                          .where('Search', arrayContains: name)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('Hot')
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return new ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => NewScreen(
                                                      snapshots: snapshot
                                                          .data.docs[index],
                                                    )));
                                      },
                                      child: Container(
                                        height: 100,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(snapshot
                                              .data.docs[index]
                                              .data()["image"]),
                                        )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                            maxHeight: 180,
                                            maxWidth: 200,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                snapshot.data.docs[index]
                                                    .data()['title']
                                                    .toUpperCase(),
                                                style: (TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Icon(Icons.star,
                                                    color: Colors.yellow,
                                                    size: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(FontAwesomeIcons.rupeeSign,
                                                color: Colors.white, size: 10),
                                            Text(
                                              snapshot.data.docs[index]
                                                  .data()['price'],
                                              style: (TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            );
                          });
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
