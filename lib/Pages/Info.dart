import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:lottie/lottie.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  String chat = loremIpsum(words: 800, paragraphs: 4, initWithLorem: true);
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
                    Text('BURGZA INFO',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: 2,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                    SizedBox(
                      width: 100,
                    ),
                    IconButton(
                      icon: Icon(Icons.info_outline, color: Colors.white),
                      onPressed: null,
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text('WHY DO WE USE IT ?',
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold)),
                subtitle: Text(
                  chat,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}