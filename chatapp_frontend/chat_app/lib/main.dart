import 'package:chat_app/locator.dart';
import 'package:chat_app/ui/landing_page.dart';
import 'package:flutter/material.dart';

void main() {
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: LandindPage(),
    );
  }
}
