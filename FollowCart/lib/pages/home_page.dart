import 'package:appFollowCart/pages/robot_control.dart';
import 'package:flutter/material.dart';
import 'package:appFollowCart/web_Socket.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isSelectRobotButton = true;
  bool isCheckCallRobots = false;

  int checkButtonNum = 0;
  int _availableReaderRobots = 1; // 사용 가능한 지휘 로봇의 수를 출력하는 변수
  int _availableRearRobots = 3; // 사용 가능한 후미 로봇을 나타내는 변수
  int selectedRobotCount = 1; // Initial selected robot count
  List<int> robotCountOptions = [];
  final RobotController robotController = RobotController();

  @override
  void initState() {
    super.initState();
    _updateRobotCountOptions();
  }

  void _updateRobotCountOptions() {
    robotCountOptions =
        List.generate(_availableRearRobots, (index) => index + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FOLLOW CART 로봇 선택'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurpleAccent,
        actions: [
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20.0, top: 40),
              child: Row(
                children: [
                  Text(
                    '로봇 호출을 도와드리겠습니다.\n아래의 버튼을 클릭하여 진행해주세요.',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width, // 화면 전체 가로 넓이
              height: 450,
              padding: EdgeInsets.only(top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 좌측 정렬
                children: [
                  if (isCheckCallRobots) Padding(
                    padding: EdgeInsets.only(left: 20), // 왼쪽 여백 추가
                    child: Text(
                      '사용하실 후미 로봇의 갯수를 선택하신 후\n아래의 로봇 호출 버튼을 클릭해주세요.\n(사용 가능한 후미 로봇 : $_availableRearRobots)',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  if (isCheckCallRobots) DropdownButtonFormField<int>(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20), // 왼쪽 여백 추가
                    value: selectedRobotCount,
                    decoration: InputDecoration(
                      labelText: '사용할 로봇 개수',
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: !isSelectRobotButton ? null : (int? value) {
                      setState(() {
                        selectedRobotCount = value!;
                      });
                    },
                    items: List.generate(_availableRearRobots, (index) {
                      return DropdownMenuItem<int>(
                        value: index + 1,
                        child: Text('${index + 1} 대',
                        ),
                      );
                    }),
                  ),

                ],
              ),
            ), // 로봇의 정보를 나타내는 상자
            SizedBox(height: 10,),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 10, bottom: 3),
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            Size(360.0, 100.0)),
                        // 최소 크기 지정
                        maximumSize: MaterialStateProperty.all(
                            Size(360.0, 100.0)),
                        // 최소 크기 지정
                        foregroundColor: MaterialStateProperty.all(
                            Colors.white),
                        backgroundColor: MaterialStateProperty.resolveWith<
                            Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.grey; // 버튼이 비활성화된 상태일 때의 색상
                            }
                            return Colors
                                .deepPurpleAccent; // 버튼이 활성화된 상태일 때의 색상
                          },
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0), // 버튼 모서리 둥글게 설정
                          ),
                        ),
                      ),
                      onPressed: isSelectRobotButton &&
                          _availableReaderRobots > 0
                          ? () {
                        checkButtonNum++;
                        print(checkButtonNum);
                        setState(() {
                          if(checkButtonNum == 1) {
                            robotController.sendLeaderCommand('CALL_LEADER_ROBOT');
                            robotController.sendLeaderDriveCommand('GO_LEADER_ROBOT');
                            isCheckCallRobots = !isCheckCallRobots;
                          } else if(checkButtonNum == 2) {
                            //isSelectRobotButton = false;
                            print('선택된 후미 로봇 수 : $selectedRobotCount');
                            robotController.sendRearCommand('CALL_REAR_ROBOTS, $selectedRobotCount');
                            robotController.sendPositionCommand('POSITION_TRIANGLE');

                             Future.delayed(Duration(seconds: 3), () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => RobotControl()),
                               );
                             });
                          } else {
                          }

                        });
                      }
                          : null,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isCheckCallRobots
                                ? '로봇 호출'
                                : '지휘 로봇 사용하기',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (!isCheckCallRobots)
                            Text(
                              '(호출 가능한 지휘 로봇 : $_availableReaderRobots)',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ),

                  ],
                )
            ), // 지휘 로봇 호출 버튼
            SizedBox(height: 3),
          ],
        ),
      ),
    );
  }

  @override
  void dispose(){
    robotController.dispose();
    super.dispose();
  }
}