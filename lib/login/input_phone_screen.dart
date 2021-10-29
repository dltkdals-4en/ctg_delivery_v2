import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:ctg_delivery_v2/database_helper.dart';
import 'package:ctg_delivery_v2/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:provider/provider.dart';
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
                    print(t.value.text);

                    var i = (t.value.text == null)
                        ? await data.findUser(_mobileNumber)
                        : await data.findUser(t.value.text);
                    print(i);
                    (i == 0)
                        ? _showDialog(size)
                        :

                        // (data.findUser(_mobileNumber) == 0)
                        //     ?Navigator.pop(context):
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                            return (t.text.isEmpty)
                                ? LoginScreen(_mobileNumber)
                                : LoginScreen(t.text);
                          }));
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
        return AlertDialog(
          title: Center(
              child: Text(
            '커피 투고 고객 전용',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
          content: Container(
            width: size.width * 1.4,
            child: Column(
              children: [
                const Text.rich(
                  TextSpan(text: '\u2022 본 페이지는 커피 투고 고객 전용입니다.\n', children: [
                    TextSpan(
                        text:
                            '\u2022 커피 투고 고객인데 아이디/ 비밀번호를 모르시는 경우, 담당자에게 문의해주세요.\n'),
                    TextSpan(text: '\u2022 커피 투고 고객이 아니시라면, 상담문의를 신청해주세요.'),
                  ]),
                  style: TextStyle(fontSize: 16, color: CoColor.coGrey1),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Text(
                      '상담문의',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Row(
                      children: [],
                    )
                  ],
                )
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context), child: Text('확인'))
          ],
        );
      },
    );
  }
}
