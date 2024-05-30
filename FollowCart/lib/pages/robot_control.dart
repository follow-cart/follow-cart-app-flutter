import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:appFollowCart/web_Socket.dart';

class RobotControl extends StatefulWidget {
  @override
  _RobotControlState createState() => _RobotControlState();
}

class _RobotControlState extends State<RobotControl> {
  final RobotController robotController = RobotController();

  void sendCommand(String command, double x, double y, double theta) {
    var message = jsonEncode({
      'command': command,
      'x': x,
      'y': y,
      'theta': theta,
    });
    robotController.sendCommand(command, x, y, theta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로봇 상태 및 제어'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '후미로봇 대형 상태',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
              ),
            ),
            SizedBox(height: 10), // 텍스트와 컨테이너 간격
            Container(
              width: 400,
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.deepPurpleAccent, width: 3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/image/delivery.png',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            '지휘로봇',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/image/logistics.png',
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            '후미로봇',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/image/logistics.png',
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            '후미로봇',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/image/logistics.png',
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            '후미로봇',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          robotController.sendPositionCommand('POSITION_TRIANGLE');
                        },
                        child: Image.asset(
                          'assets/image/three-dot.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(110.0, 70.0)),
                          maximumSize: MaterialStateProperty.all(Size(110.0, 70.0)),
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.grey;
                              }
                              return Colors.white;
                            },
                          ),
                          side: MaterialStateProperty.all(BorderSide(color: Colors.deepPurpleAccent, width: 1.0)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          robotController.sendPositionCommand('POSITION_HORIZON');
                        },
                        child: Image.asset(
                          'assets/image/horizontal_three_dot.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(110.0, 70.0)),
                          maximumSize: MaterialStateProperty.all(Size(110.0, 70.0)),
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.grey;
                              }
                              return Colors.white;
                            },
                          ),
                          side: MaterialStateProperty.all(BorderSide(color: Colors.deepPurpleAccent, width: 1.0)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          robotController.sendPositionCommand('POSITION_VERTICAL');
                        },
                        child: Image.asset(
                          'assets/image/vertical_three_dot.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(110.0, 70.0)),
                          maximumSize: MaterialStateProperty.all(Size(110.0, 70.0)),
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.grey;
                              }
                              return Colors.white;
                            },
                          ),
                          side: MaterialStateProperty.all(BorderSide(color: Colors.deepPurpleAccent, width: 1.0)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    robotController.sendLeaderDriveCommand('STOP_LEADER_ROBOT');
                  },
                  child: Text(
                    '정지 모드',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(200.0, 70.0)),
                    maximumSize: MaterialStateProperty.all(Size(200.0, 70.0)),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.grey;
                        }
                        return Colors.white;
                      },
                    ),
                    side: MaterialStateProperty.all(BorderSide(color: Colors.deepPurpleAccent, width: 1.0)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    sendCommand('CALL_LEADER_ROBOT', 3.0, 2.0, 0.1);
                  },
                  child: Text(
                    '주행 모드',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(200.0, 70.0)),
                    maximumSize: MaterialStateProperty.all(Size(200.0, 70.0)),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.grey;
                        }
                        return Colors.deepPurpleAccent;
                      },
                    ),
                    side: MaterialStateProperty.all(BorderSide(color: Colors.deepPurpleAccent, width: 1.0)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    sendCommand('RETURN', 0.0, -2.0, 0.1);
                  },
                  child: Text(
                    '로봇 반납',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(410.0, 100.0)),
                    maximumSize: MaterialStateProperty.all(Size(410.0, 100.0)),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.grey;
                        }
                        return Colors.deepPurpleAccent;
                      },
                    ),
                    side: MaterialStateProperty.all(BorderSide(color: Colors.deepPurpleAccent, width: 1.0)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}