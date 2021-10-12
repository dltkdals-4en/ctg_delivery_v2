import 'package:ctg_delivery_v2/cafe_info.dart';
import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:ctg_delivery_v2/database_helper.dart';
import 'package:ctg_delivery_v2/fail_reason_tile.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class FailScreen extends StatefulWidget {
  const FailScreen(this.data, {Key? key}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  _FailScreenState createState() => _FailScreenState();
}

class _FailScreenState extends State<FailScreen> {
  int _value = 6;
  bool _visible = false;
  List failList = [
    {"icon": Icons.monitor_weight, "reason": '수거량 초과'},
    {"icon": Icons.no_accounts, "reason": '고객 부재'},
    {"icon": Icons.more_time, "reason": '시간 초과'},
    {"icon": Icons.edit, "reason": '직접 입력'},
  ];
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,

            // backgroundColor: Colors.white,
            title: const Center(
              child: Text(
                '수거 실패 사유',
                style: TextStyle(
                    color: CoColor.coBlack, fontWeight: FontWeight.bold),
              ),
            ),

            elevation: 0,
          ),
          body: Container(
            color: CoColor.coGrey6,
            child: Column(
              children: [
                CafeInfo(widget.data),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        if (index == 4) {
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Visibility(
                              visible: _visible,
                              child: SizedBox(
                                height: 200,
                                child: TextFormField(
                                  controller: _controller,
                                  cursorColor: CoColor.coPrimary,
                                  style: TextStyle(color: CoColor.coBlack),
                                  decoration: InputDecoration(
                                    hintStyle:
                                        TextStyle(color: CoColor.coGrey3),
                                    hintText: '내용을 입력해주세요.',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    fillColor: CoColor.coGrey5,
                                    filled: true,
                                  ),
                                  minLines: 3,
                                  maxLines: 4,
                                  focusNode: _focusNode,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return FailReasonTile(
                            index: index,
                            value: index,
                            groupValue: _value,
                            onChanged: (value) => setState(() {
                              print(_value);
                              if (value == 3) {
                                _visible = true;
                                _value = value as int;
                                _focusNode.requestFocus();
                              } else {
                                _visible = false;
                                _value = value as int;
                              }
                            }),
                            icon: failList[index]['icon'],
                            title: failList[index]['reason'],
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            width: size.width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      '고객센터 연결하기 >',
                      style: TextStyle(color: CoColor.coBlack, fontSize: 13),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: CoColor.coPrimary,
                      ),
                      onPressed: () {
                        var failCode = _value + 1;
                        var failReason = '';
                        if (_value == 3) {
                          failReason = _controller.text;
                        }else{
                          failReason = failList[_value]['reason'];
                        }

                        print(
                            '${widget.data["pick_id"]}, $failCode, $failReason');
                        DbHelper().updateFail(
                            widget.data['pick_id'], failCode, failReason);
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(),));
                      },
                      child: const SizedBox(
                        height: 50,
                        child: Center(
                            child: Text(
                          '실패 사유 전송',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )),
                      ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
