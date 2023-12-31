


import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:interviews/screens/navigation.dart';

import 'firebase_options.dart';







void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );




  runApp(const MyApp());


}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();




  }






  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/icons/eclipse.png"), context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData.dark(),

      home: MainNavigationPage(),
    );
  }
}