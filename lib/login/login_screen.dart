import 'dart:async';

import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen(this.phoneNumber, {Key? key}) : super(key: key);
  final String phoneNumber;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController t = TextEditingController();
  Timer? _smsTimer;
  Timer? _resendTimer;
  var smsTime = const Duration(seconds: 180);
  var leftTime;
  var leftMin;
  var leftSec;
  int resend = 0;
  String smsText = '*SMS 재전송은 3회까지 가능합니다.';
  Color smsTextColor = CoColor.coGrey3;

  @override
  void initState() {
    setSmsTimer();

    super.initState();
  }

  @override
  void dispose() {
    if (_smsTimer != null) _smsTimer!.cancel();
    if (_resendTimer != null) _resendTimer!.cancel();

    t.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  setResendTimer() {
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (resend < 30) {
          resend++;
        } else {
          _resendTimer!.cancel();
          resend = 0;
        }
      });
    });
  }

  setSmsTimer() {
    if (_smsTimer != null) _smsTimer!.cancel();
    leftTime = smsTime.inSeconds;
    leftMin = smsTime.inMinutes;
    leftSec = smsTime.inSeconds % 60;
    _smsTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (leftTime > 0) {
          leftTime--;
          leftMin = leftTime ~/ 60;
          leftSec = leftTime % 60;
        } else {
          print(leftTime);
          smsText = '*3분이 지나 인증할 수 없습니다. \n재전송 버튼을 눌러주세요.';
          smsTextColor = CoColor.coRed;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: CoColor.coBlack),
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '홍길동님 안녕하세요 :)\n인증번호를 입력해주세요.',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 3, color: CoColor.coPrimary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: widget.phoneNumber),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: t,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: CoColor.coPrimary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: '인증번호 입력',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            (leftSec > 9)
                                ? '$leftMin:$leftSec'
                                : '$leftMin:0$leftSec',
                            style: const TextStyle(
                                color: CoColor.coPrimary, fontSize: 17),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            child: const Text('재전송'),
                            onPressed: () {
                              if (resend == 0) {
                                setState(() {
                                  smsText = '*SMS 재전송은 3회까지 가능합니다.';
                                  smsTextColor = CoColor.coGrey2;
                                });
                                setSmsTimer();
                                setResendTimer();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                    content: Text('${30-resend}초 후 다시 시도하세요.'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1, color: CoColor.coPrimary),
                              primary: CoColor.coPrimary,
                              elevation: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                  child: Text(
                    smsText,
                    style: TextStyle(
                        color: smsTextColor, fontWeight: FontWeight.bold),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Center(
                    child: Text(
                  '로그인 문제 해결 > $resend',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(widget.phoneNumber),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(width: 1, color: CoColor.coPrimary),
                    primary: CoColor.coPrimary,
                    elevation: 0,
                  ),
                  child: SizedBox(
                    width: size.width,
                    height: 60,
                    child: const Center(
                      child: Text(
                        '다음',
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
