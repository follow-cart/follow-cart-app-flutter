import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main_page.dart';

class SignUpPageName extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPageName> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _checkpasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool isIdAvailable = true;
  bool isButtonEnabled = false;
  bool isPasswordAvailable = true;

  int currentStep = 0;
  int currentTextFieldIndex = 0;
  List<bool> isTextFieldVisibleList = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/image/purple_background.jpeg'),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15.0, top: 170, bottom: 50),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Follow Cart를\n처음 사용하시나요?',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ),
              SizedBox(height:10),
              Container(
                padding: EdgeInsets.only(left: 15.0, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  '순서에 따라 진행해주세요 :)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ),
              SizedBox(height: 0),
              Container(
                width: 370,
                height: 180,
                padding: EdgeInsets.only(left: 20, right: 20, top: !isPasswordAvailable ? 10 : 0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurpleAccent,
                      width: 4.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(45))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: isTextFieldVisibleList[0],
                      child: TextField(
                        controller: _nameController,
                        onChanged: (value) {
                          setState(() {
                            isButtonEnabled = value.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: '이름을 입력해주세요.',
                            suffixIcon: _nameController.text.isNotEmpty ? IconButton(
                              icon: Icon(Icons.clear),
                              color: Colors.deepPurpleAccent,
                              onPressed: () {
                                setState(() {
                                  _nameController.clear();
                                  isButtonEnabled = false;
                                });
                              },
                            ) : null,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurpleAccent,
                                    width: 2
                                )
                            )
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isTextFieldVisibleList[1],
                      child: TextField(
                        controller: _idController,
                        onChanged: (value) {
                          setState(() {
                            isButtonEnabled = isIdAvailable && value.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'ID를 입력해주세요.',
                            errorText: !isIdAvailable ? '이미 사용 중인 아이디입니다.' : null,
                            suffixIcon: _idController.text.isNotEmpty ? IconButton(
                              icon: Icon(Icons.clear),
                              color: Colors.deepPurpleAccent,
                              onPressed: () {
                                setState(() {
                                  _idController.clear();
                                  isButtonEnabled = false;
                                });
                              },
                            ) : null,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurpleAccent,
                                    width: 2
                                )
                            )
                        ),
                      ),
                    ),
                    Visibility(
                        visible: isTextFieldVisibleList[2],
                        child: Column(
                          children: [
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: 'Password를 입력해주세요.',
                                  suffixIcon: _passwordController.text.isNotEmpty ? IconButton(
                                    icon: Icon(Icons.clear),
                                    color: Colors.deepPurpleAccent,
                                    onPressed: () {
                                      setState(() {
                                        isPasswordAvailable = false;
                                        isButtonEnabled = false;
                                        _passwordController.clear();
                                      });
                                    },
                                  ) : null,

                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepPurpleAccent,
                                          width: 2
                                      )
                                  )
                              ),
                            ),
                            TextField(
                              controller: _checkpasswordController,
                              obscureText: true,
                              onChanged: (value) {
                                setState(() {
                                  isPasswordAvailable = value == _passwordController.text;
                                  isButtonEnabled = value == _passwordController.text;
                                });
                              },
                              decoration: InputDecoration(
                                  labelText: '확인을 위한 Password를 입력해주세요.',
                                  errorText: !isPasswordAvailable ? '패스워드가 다릅니다!': null,
                                  suffixIcon: _checkpasswordController.text.isNotEmpty ? IconButton(
                                    icon: Icon(Icons.clear),
                                    color: Colors.deepPurpleAccent,
                                    onPressed: () {
                                      setState(() {
                                        isPasswordAvailable = false;
                                        isButtonEnabled = false;
                                        _checkpasswordController.clear();
                                      });
                                    },
                                  ) : null,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepPurpleAccent,
                                          width: 2
                                      )
                                  )
                              ),
                            ),
                          ],
                        )
                    ),
                    Visibility(
                      visible: isTextFieldVisibleList[3],
                      child: TextField(
                        controller: _emailController,
                        onChanged: (value) {
                          setState(() {
                            isButtonEnabled = value.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'Email를 입력해주세요.',
                            suffixIcon: _emailController.text.isNotEmpty ? IconButton(
                              icon: Icon(Icons.clear),
                              color: Colors.deepPurpleAccent,
                              onPressed: () {
                                setState(() {
                                  _emailController.clear();
                                  isButtonEnabled = false;
                                });
                              },
                            ) : null,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.deepPurpleAccent,
                                    width: 2
                                )
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20,),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: (currentStep + 1) / 4,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        4,
                            (index) {
                          return Container(
                            width: 25,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (index <= currentStep) ? Colors.deepPurpleAccent : Colors.grey,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(300.0, 60.0)),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.grey;
                              }
                              return Colors.deepPurpleAccent;
                            },
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                        onPressed: isButtonEnabled
                            ? () async {
                          if (currentStep == 1) {
                            bool isDuplicate = await _checkIdDuplicate(_idController.text);
                            if (!isDuplicate) {
                              setState(() {
                                currentStep += 1;
                                currentTextFieldIndex = (currentTextFieldIndex + 1) % isTextFieldVisibleList.length;
                                for (int i = 0; i < isTextFieldVisibleList.length; i++) {
                                  isTextFieldVisibleList[i] = false;
                                }
                                isTextFieldVisibleList[currentTextFieldIndex] = true;
                                isButtonEnabled = false;
                              });
                            } else {
                              _showDuplicateIdDialog();
                            }
                          } else {
                            if (currentStep < 3) {
                              setState(() {
                                currentStep += 1;
                                currentTextFieldIndex = (currentTextFieldIndex + 1) % isTextFieldVisibleList.length;
                                for (int i = 0; i < isTextFieldVisibleList.length; i++) {
                                  isTextFieldVisibleList[i] = false;
                                }
                                isTextFieldVisibleList[currentTextFieldIndex] = true;
                                isButtonEnabled = false;
                              });
                            } else if (currentStep == 3) {
                              _signUp();
                            }
                          }
                        }
                            : null,
                        child: Text(
                          '다음으로',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _checkIdDuplicate(String userId) async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/auth/check-userid?userid=$userId'),
    );

    return response.statusCode == 400;
  }

  void _showDuplicateIdDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("아이디 중복"),
          content: Text("이미 사용 중인 아이디입니다.\n다시 입력해주세요."),
          actions: <Widget>[
            TextButton(
              child: Text("확인"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _signUp() async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': _nameController.text,
        'userid': _idController.text,
        'password': _passwordController.text,
        'email': _emailController.text,
      }),
    );

    if (response.statusCode == 200) {
      _showSignUpCompleteDialog();
    } else {
      _showSignUpErrorDialog();
    }
  }

  void _showSignUpCompleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("회원가입 완료"),
          content: Text("회원가입이 성공적으로 완료되었습니다."),
          actions: <Widget>[
            TextButton(
              child: Text("확인"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showSignUpErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("회원가입 실패"),
          content: Text("회원가입에 실패했습니다.\n다시 시도해주세요."),
          actions: <Widget>[
            TextButton(
              child: Text("확인"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _passwordController.dispose();
    _checkpasswordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
