import 'package:ctg_delivery_v2/previous_history.dart';
import 'package:ctg_delivery_v2/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'contstants/color.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '마이페이지',
          style: TextStyle(
            color: CoColor.coBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: CoColor.coBlack),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingScreen(),
                    ));
              },
              icon: Image.asset('assets/images/setting.png'))
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: '홍길동님!\n',
                          style: const TextStyle(fontSize: 20),
                          children: [
                            TextSpan(
                              text: '오늘 수거 일정이 ',
                            ),
                            TextSpan(
                              text: '4건 ',
                              style: const TextStyle(
                                  color: CoColor.coPrimary,
                                  fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(text: '있어요.'),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '75% 완료',
                            style: const TextStyle(
                                color: CoColor.coGrey2, fontSize: 14),
                          ),
                          Text.rich(
                            TextSpan(
                              text: '3',
                              style: const TextStyle(
                                  color: CoColor.coPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26),
                              children: [
                                TextSpan(
                                  text: '/4',
                                  style: const TextStyle(
                                    color: CoColor.coBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: CoColor.coGrey4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/myPageList.png'),
                              SizedBox(
                                width: 10,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: '총 수거 횟수 ',
                                  style: const TextStyle(
                                      color: CoColor.coBlack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: '201 ',
                                      style: const TextStyle(
                                        color: CoColor.coPrimary,
                                      ),
                                    ),
                                    TextSpan(text: '회'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Image.asset('assets/images/myPageRate.png'),
                              SizedBox(
                                width: 10,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: '나의 평균 달성률 ',
                                  style: const TextStyle(
                                      color: CoColor.coBlack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: '89 ',
                                      style: const TextStyle(
                                        color: CoColor.coPrimary,
                                      ),
                                    ),
                                    TextSpan(text: '%'),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: ListTile(
                title: const Text(
                  '이전 수거내역',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreviousHistory(),
                      ));
                },
                minLeadingWidth: 0,
                contentPadding: EdgeInsets.all(0),
                leading: Container(
                    child: Image.asset('assets/images/myPageBefore.png')),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        '약관 및 정책',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {},
                      minLeadingWidth: 0,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                          child: Image.asset('assets/images/myPagePolicy.png')),
                    ),
                    ListTile(
                      title: const Text(
                        '공지사항',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {},
                      minLeadingWidth: 0,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                          child: Image.asset('assets/images/myPageNotice.png')),
                    ),
                    ListTile(
                      title: const Text(
                        '고객센터',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {},
                      minLeadingWidth: 0,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                          child:
                              Image.asset('assets/images/myPageService.png')),
                    ),
                    ListTile(
                      title: const Text(
                        '현재 버전 2.7.4',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {},
                      minLeadingWidth: 0,
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                          child:
                              Image.asset('assets/images/myPageVersion.png')),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
