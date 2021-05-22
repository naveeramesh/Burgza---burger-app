import 'package:burgza/Pages/SplashScreen.dart';
import 'package:burgza/Pages/admin.dart';
import 'package:burgza/Services/Get.dart';
import 'package:burgza/Services/SharedPreferences.dart';
import 'package:burgza/Services/location.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPrefernces.sharedPreferences=await SharedPreferences.getInstance();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
     @override
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Get()),
             ChangeNotifierProvider.value(
            value: GenerateMaps()),

            
        ],
        child: MaterialApp(
          title: 'BURGZA',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            primarySwatch: Colors.green,
          ),
          home:SplashScreen(),
        ),
        );
  }
}
