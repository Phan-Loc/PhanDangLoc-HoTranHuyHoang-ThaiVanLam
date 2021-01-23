import 'package:flutter/material.dart';
import 'package:flutter_edmt_quiz_app/screens/home_page.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: splash(),
  ));
}

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/homePage");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 350, width: 350,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/que.png"),
              fit: BoxFit.fill
            )
          ),
        )
      ),
    );
  }
}
