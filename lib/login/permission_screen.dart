import 'dart:ui';

import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:flutter/material.dart';
import 'app_explain.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = MediaQuery.of(context).devicePixelRatio;
    Size rsize = window.physicalSize;
    print(ratio);
    Size size = MediaQuery.of(context).size;
    List permission = [
      {
        'title': '기기 및 앱 기록',
        'image': 'perPhone.png',
        'contents': '앱 서비스 최적화 및 기기 오류',
        'choice': '필수'
      },
      {
        'title': 'GPS',
        'image': 'perGps.png',
        'contents': '내 위치 및 수거지 표시',
        'choice': '필수'
      },
      {
        'title': 'SMS',
        'image': 'perSms.png',
        'contents': '회원가입 및 로그인 인증',
        'choice': '필수'
      },
      {
        'title': '알림',
        'image': 'perAlarm.png',
        'contents': '푸시 알림 등록 및 수신',
        'choice': '선택'
      },
      {
        'title': '마이크',
        'image': 'perMic.png',
        'contents': '고객센터 전화 문의 연결',
        'choice': '선택'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '앱 접근 권한 안내',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '커피투고 앱을 이용하기 위해서 \n다음의 앱 권한을 허용해주세요.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: permission.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: CoColor.coPrimary2,
                              ),
                              child: SizedBox(
                                width: 48,
                                height: 48,
                                child: Image.asset(
                                    "assets/images/${permission[index]['image']}"),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${permission[index]['title']}${permission[index]['choice']}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${permission[index]['contents']}",
                                  style: const TextStyle(
                                      fontSize: 12, color: CoColor.coGrey2),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/textInfo.png'),
                    const Expanded(
                      child: Text(
                        '선택적 접근 권한에 동의하지 않으셔도 앱을 이용하실 수 있으나,일부 서비스 이용이 제한될 수 있습니다.',
                        style: TextStyle(color: CoColor.coGrey2),
                        softWrap: true,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppExplain(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(width: 1, color: CoColor.coPrimary),
                    primary: CoColor.coPrimary,
                    elevation: 0,
                  ),
                  child: Container(
                    width: size.width,
                    height: 60,
                    child: const Center(
                      child: Text(
                        '확인',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
