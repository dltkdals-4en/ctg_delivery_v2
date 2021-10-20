import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:ctg_delivery_v2/login/login_screen.dart';
import 'package:flutter/material.dart';

class InputPhoneScreen extends StatefulWidget {
  const InputPhoneScreen({Key? key}) : super(key: key);

  @override
  State<InputPhoneScreen> createState() => _InputPhoneScreenState();
}

class _InputPhoneScreenState extends State<InputPhoneScreen> {
  TextEditingController t = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    t.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String phoneNumber = '01099544115';
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset : false,
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
                Text(
                  '전화번호를 입력해주세요',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: t,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: CoColor.coPrimary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: phoneNumber),
                  keyboardType: TextInputType.phone,

                ),
                const Expanded(child: SizedBox()),
                ElevatedButton(
                  onPressed: () {

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return (t.text.isEmpty)
                          ? LoginScreen(phoneNumber)
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
}
