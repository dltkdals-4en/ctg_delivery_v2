import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _visible = false;
  bool marketingEmail = false;
  bool marketingSms = false;
  bool darkMode = false;
  bool onlyWifi = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '환경설정',
          style: TextStyle(
            color: CoColor.coBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: CoColor.coBlack),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '알림',
                          style: TextStyle(
                              fontSize: 14,
                              color: CoColor.coGrey4,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '푸시 알림 설정',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: CoColor.coBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                            CupertinoSwitch(
                              value: _visible,
                              onChanged: (value) {
                                setState(() {
                                  _visible = !_visible;
                                });
                              },
                              activeColor: CoColor.coPrimary,
                            )
                          ],
                        ),
                        Text(
                          '이벤트, 새로운 소식 등 각종 알림과 혜택을 알려드립니다.',
                          style: TextStyle(
                              fontSize: 14,
                              color: CoColor.coGrey3,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible: _visible,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '마케팅 이메일 수신 동의',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: CoColor.coBlack,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  CupertinoSwitch(
                                    value: marketingEmail,
                                    onChanged: (value) {
                                      setState(() {
                                        marketingEmail = value;
                                      });
                                    },
                                    activeColor: CoColor.coPrimary,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '마케팅 SMS 수신 동의',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: CoColor.coBlack,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  CupertinoSwitch(
                                    value: marketingSms,
                                    onChanged: (value) {
                                      setState(() {
                                        marketingSms = value;
                                      });
                                    },
                                    activeColor: CoColor.coPrimary,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '기타 설정',
                        style: TextStyle(
                            fontSize: 14,
                            color: CoColor.coGrey4,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '다크모드',
                            style: TextStyle(
                                fontSize: 16,
                                color: CoColor.coBlack,
                                fontWeight: FontWeight.bold),
                          ),
                          CupertinoSwitch(
                            value: darkMode,
                            onChanged: (value) {
                              setState(() {
                                darkMode = value;
                              });
                            },
                            activeColor: CoColor.coPrimary,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'WiFi에서만 사용',
                            style: TextStyle(
                                fontSize: 16,
                                color: CoColor.coBlack,
                                fontWeight: FontWeight.bold),
                          ),
                          CupertinoSwitch(
                            value: onlyWifi,
                            onChanged: (value) {
                              setState(() {
                                onlyWifi = value;
                              });
                            },
                            activeColor: CoColor.coPrimary,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            '캐시 데이터 관리',
                            style: TextStyle(
                                fontSize: 16,
                                color: CoColor.coBlack,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
