import 'package:flutter/material.dart';

class ManagerPage extends StatefulWidget {
  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Management System',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurpleAccent,
          ),
        ), // 페이지 제목
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                    Size(360.0, 100.0)),// 최소 크기 지정
                maximumSize: MaterialStateProperty.all(
                    Size(360.0, 100.0)),// 최소 크기 지정
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor:MaterialStateProperty.all(Colors.deepPurpleAccent),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0), // 버튼 모서리 둥글게 설정
                  ),
                ),
              ),
              onPressed: () {
                // 로봇 관리 페이지로 이동
              },
              child: Text(
                '로봇 관리',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ), // 로봇 관리 버튼
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

}