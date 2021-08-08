import 'package:chat_app/ui/home_page.dart';
import 'package:flutter/material.dart';

class LandindPage extends StatelessWidget {
  const LandindPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          color: Colors.blue,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: Text(
            'Start Chat',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
