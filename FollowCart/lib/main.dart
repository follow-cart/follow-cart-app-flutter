import 'dart:async';
import 'package:flutter/material.dart';
import 'package:appFollowCart/pages/main_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Cafe24OhsquareAir"
      ),
      home: LodingState(),
    );
  }
}

class LodingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      },
    );

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Container(
              child: Column(
                children: [
                  Text(
                    "Welcome to the",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Follow Cart!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            ),
            SizedBox(height: 40,),
            Container(
              child: SpinKitFadingCube( // FadingCube 모양 사용
                color: Colors.white, // 색상 설정
                size: 50.0, // 크기 설정
                duration: Duration(seconds: 2), //속도 설정
              ),
            ),
          ],
        ),
      ),
    );
  }
}
