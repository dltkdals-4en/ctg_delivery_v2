import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:ctg_delivery_v2/database_helper.dart';
import 'package:ctg_delivery_v2/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

class InputPhoneScreen extends StatefulWidget {
  const InputPhoneScreen({Key? key}) : super(key: key);

  @override
  State<InputPhoneScreen> createState() => _InputPhoneScreenState();
}

class _InputPhoneScreenState extends State<InputPhoneScreen> {
  TextEditingController t = TextEditingController();
  SmsAutoFill _autoFill = SmsAutoFill();
  String _mobileNumber = '';
  List<SimCard> _simCard = <SimCard>[];
  String rNum = '';

  @override
  void initState() {
    super.initState();
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {
        print('error');
      }
    });
    initMobileNumberState();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();

    t.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    String mobileNumber = '';
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      mobileNumber = (await MobileNumber.mobileNumber)!;
      _simCard = (await MobileNumber.getSimCards)!;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _mobileNumber = formatPhoneNumber(mobileNumber);
    });
  }

  formatPhoneNumber(phone) {
    if (phone.contains("+")) {
      var nationCode = phone.split('+')[0];

      return phone.replaceAll('$nationCode+$nationCode', '0').trim();
    } else {
      return phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<DbHelper>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  '전화번호를 입력해주세요',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: t,
                  autofillHints: const [AutofillHints.telephoneNumber],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: CoColor.coPrimary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: _mobileNumber,
                  ),
                  // onChanged: (value) {
                  //   // setState(() {
                  //   //   t.text = value;
                  //   // });
                  // },
                  keyboardType: TextInputType.phone,
                ),
                const Expanded(child: SizedBox()),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      (t.text.isEmpty)
                          ? rNum = _mobileNumber
                          : rNum = t.value.text;
                    });
                    final prefs = await SharedPreferences.getInstance();
                    setState(() {
                      prefs.setString('phone', rNum);
                    });
                    int i = await data.findUser(rNum);

                    (i == 0)
                        ? _showDialog(size)
                        :

                        // (data.findUser(_mobileNumber) == 0)
                        //     ?Navigator.pop(context):
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen(rNum)));
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

  _showDialog(Size size) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: Container(
            width: size.width * 0.9,
            height: size.height * 0.55,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
              child: Column(
                children: [
                  Center(
                      child: Text(
                    '커피 투고 고객 전용',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022 본 페이지는 커피 투고 고객 전용입니다.',
                          style: TextStyle(
                            fontSize: 16,
                            color: CoColor.coGrey1,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text('\u2022 커피 투고 고객인데 아이디/비밀번호를 모르시는 경우, 담당자에게 문의해주세요.',
                          style: TextStyle(
                            fontSize: 16,
                            color: CoColor.coGrey1,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text('\u2022 커피 투고 고객이 아니시라면, 상담문의를 신청해주세요.',
                          style: TextStyle(
                            fontSize: 16,
                            color: CoColor.coGrey1,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '상담문의',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: (size.width * 0.9 - 41) / 2,
                              child: Column(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/loginValidatePhone.png',
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '070-000-0000',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: CoColor.coGrey2,
                              width: 1,
                              height: 22,
                            ),
                            Container(
                              width: (size.width * 0.9 - 41) / 2,
                              child: Column(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/loginValidateEmail.png',
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'admin@4en.co.kr',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Container(
                          color: CoColor.coPrimary,
                          width: size.width * 0.9 - 40,
                          height: 50,
                          child: Center(child: Text('확인'))))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
