import 'package:burgza/Pages/Favourites.dart';
import 'package:burgza/Pages/NewScreen.dart';
import 'package:burgza/Services/Get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('CART ITEMS',
              style: GoogleFonts.lato(
                  textStyle: TextStyle(letterSpacing: 2, color: Colors.white))),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.favorite_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Favourites(),
                          type: PageTransitionType.rightToLeftWithFade));
                })
          ],
        ),
        body: FutureBuilder(
            future: Provider.of<Get>(context, listen: false).fetchData('Cart'),
            builder: (context, snapshot) {
              if (snapshot.data != null && snapshot.data.length != 0) {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                child: NewScreen(
                                  snapshots: snapshot.data[index],
                                ),
                                type: PageTransitionType.rightToLeftWithFade,
                              ));
                        },
                        child: Container(
                          child: Column(children: [
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Row(
                                children: [
                                  Container(
                                      height: 90,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: NetworkImage(snapshot.data[index]
                                            .data()['image']),
                                        fit: BoxFit.cover,
                                      ))),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              snapshot.data[index]
                                                  .data()['title']
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 17,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(FontAwesomeIcons.rupeeSign,
                                                color: Colors.white, size: 15),
                                            Text(
                                              snapshot.data[index]
                                                  .data()['price'],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.delete,
                                                  color: Colors.white),
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('Cart')
                                                    .doc(snapshot.data[index]
                                                        .data()['productid'])
                                                    .delete()
                                                    .whenComplete(() {
                                                  Fluttertoast.showToast(
                                                      msg: 'Deleted',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      backgroundColor:
                                                          Colors.yellow[900],
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ]),
                        ),
                      );
                    });
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: 130,
                    ),
                    Container(
                      height: 300,
                      width: 500,
                      child: Lottie.network(
                          'https://assets7.lottiefiles.com/temp/lf20_Celp8h.json'),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'OUCH ! MAKE ME OVERFLOW ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'BY ADDING YOUR BITES',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      )),
                    ),
                  ],
                );
              }
            }));
  }
}
