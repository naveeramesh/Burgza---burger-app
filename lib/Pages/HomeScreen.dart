import 'package:burgza/Services/Get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../Services/location.dart';
import 'Account.dart';
import 'Cart.dart';
import 'NewScreen.dart';
import 'Search.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<GenerateMaps>(context, listen: false).getCurrentLocation();
    super.initState();
  }

  String name;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                                  type:
                                      PageTransitionType.rightToLeftWithFade));
                        }),
                    IconButton(
                        icon: Icon(EvaIcons.shoppingCartOutline,
                            color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: Cart(),
                                  type:
                                      PageTransitionType.rightToLeftWithFade));
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                        child: Search(),
                        type: PageTransitionType.rightToLeftWithFade,
                      ));
                },
                child: Container(
                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text('Search your first bite..',
                          style: TextStyle(color: Colors.white)),
                      Padding(
                        padding: const EdgeInsets.only(left: 220.0),
                        child: IconButton(
                            icon: Icon(Icons.search,
                                size: 20, color: Colors.white),
                            onPressed: null),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 156,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://d4t7t8y8xqo0t.cloudfront.net/resized/1080X400/pages%2F506%2Fimage20190216045948.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text('HOT SALE',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FutureBuilder(
                      future: Provider.of<Get>(context, listen: false)
                          .getData('Hot', '1'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.yellow),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
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
                                        type: PageTransitionType
                                            .rightToLeftWithFade,
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Stack(children: [
                                        Container(
                                          height: 130,
                                          width: 180,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                snapshot.data[index]
                                                    .data()['image'],
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            top: 90,
                                            left: 140,
                                            child: IconButton(
                                                icon: Icon(
                                                    Icons.favorite_outlined,
                                                    size: 20,
                                                    color: Colors.white),
                                                onPressed: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Favourites')
                                                      .doc(snapshot.data[index]
                                                          .data()['productid'])
                                                      .set({
                                                    'title': snapshot
                                                        .data[index]
                                                        .data()['title'],
                                                    'image': snapshot
                                                        .data[index]
                                                        .data()['image'],
                                                    'price': snapshot
                                                        .data[index]
                                                        .data()['price'],
                                                    'description': snapshot
                                                        .data[index]
                                                        .data()['description'],
                                                    'productid': snapshot
                                                        .data[index]
                                                        .data()['productid'],
                                                  }).whenComplete(() {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'Added to Favourites',
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        backgroundColor:
                                                            Colors.yellow[900],
                                                        textColor: Colors.white,
                                                        fontSize: 16.0);
                                                  });
                                                })),
                                      ]),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          snapshot.data[index]
                                              .data()['title']
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          Icon(FontAwesomeIcons.rupeeSign,
                                              size: 15, color: Colors.white),
                                          Text(
                                              snapshot.data[index]
                                                  .data()['price'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    )),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text('PIZZA',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FutureBuilder(
                      future: Provider.of<Get>(context, listen: false)
                          .getData('Hot', '2'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.yellow),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
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
                                        type: PageTransitionType
                                            .rightToLeftWithFade,
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Stack(children: [
                                        Container(
                                          height: 130,
                                          width: 180,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                snapshot.data[index]
                                                    .data()['image'],
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            top: 90,
                                            left: 140,
                                            child: IconButton(
                                                icon: Icon(
                                                    Icons.favorite_outlined,
                                                    size: 20,
                                                    color: Colors.white),
                                                onPressed: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Favourites')
                                                      .add({
                                                    'description': snapshot
                                                        .data[index]
                                                        .data()['description'],
                                                    'image1': snapshot
                                                        .data[index]
                                                        .data()['image1'],
                                                    'image2': snapshot
                                                        .data[index]
                                                        .data()['image2'],
                                                    'image3': snapshot
                                                        .data[index]
                                                        .data()['image3'],
                                                    'price': snapshot
                                                        .data[index]
                                                        .data()['price'],
                                                    'title': snapshot
                                                        .data[index]
                                                        .data()['title'],
                                                    'image': snapshot
                                                        .data[index]
                                                        .data()['image'],
                                                  }).whenComplete(() {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'Added to favourites',
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        backgroundColor:
                                                            Colors.yellow[900],
                                                        textColor: Colors.white,
                                                        fontSize: 16.0);
                                                  });
                                                }))
                                      ]),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          snapshot.data[index]
                                              .data()['title']
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          Icon(FontAwesomeIcons.rupeeSign,
                                              size: 15, color: Colors.white),
                                          Text(
                                              snapshot.data[index]
                                                  .data()['price'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
