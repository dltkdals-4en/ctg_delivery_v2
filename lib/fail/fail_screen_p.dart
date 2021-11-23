import 'package:ctg_delivery_v2/cafe_info.dart';
import 'package:ctg_delivery_v2/collect/cafe_info_p.dart';
import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:ctg_delivery_v2/database_helper.dart';
import 'package:ctg_delivery_v2/fail/fail_reason_tile.dart';
import 'package:ctg_delivery_v2/model/map_card_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../db_provider.dart';
import '../main.dart';

class FailScreenP extends StatefulWidget {
  const FailScreenP(this.index, {Key? key}) : super(key: key);

  final int index;

  @override
  _FailScreenPState createState() => _FailScreenPState();
}

class _FailScreenPState extends State<FailScreenP> {
  FToast? fToast;
  int _value = 6;
  bool _visible = false;
  List failList = [
    {"icon": "assets/images/failExcess.png", "reason": '수거량 초과'},
    {"icon": "assets/images/failAbsence.png", "reason": '고객 부재'},
    {"icon": "assets/images/failTimeout.png", "reason": '시간 초과'},
    {"icon": "assets/images/failInput.png", "reason": '직접 입력'},
  ];
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    fToast = FToast();
    fToast!.init(context);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DbProvider>(context);
    MapCardModel cardData = provider.mapList[provider.mapCardIndex];
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
                CafeInfoP(cardData),
                const SizedBox(
                  height: 12,
                ),

                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          if (index == 4) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(20,0,20,0),
                              child: Visibility(
                                visible: _visible,
                                child: SizedBox(
                                  height: 200,
                                  child: TextField(
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
              padding: const EdgeInsets.fromLTRB(20, 0 ,20, 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      '고객센터 연결하기 >',
                      style: TextStyle(
                          color: CoColor.coBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: CoColor.coPrimary,
                    ),
                    onPressed: () {
                      if (_value == 6) {
                        customToast(size, _value);
                      } else if( _controller.text.isEmpty && _value ==3){
                        customToast(size, _value);
                      }else {
                        var failCode = _value + 1;
                        var failReason = '';
                        if (_value == 3 ) {
                         failReason = _controller.text;
                        } else {
                          failReason = failList[_value]['reason'];
                        }

                        DbHelper()
                            .updateFail(cardData.pickId, failCode, failReason);

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => MyApp(),
                            ),
                            (route) => false);
                      }
                    },
                    child: const SizedBox(
                      height: 60,
                      child: Center(
                          child: Text(
                        '실패 사유 전송',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void customToast(size, value) {
    Widget toast = Container(
      width: size.width - 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CoColor.coGrey2,
      ),
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            (value == 6)?'실패 사유를 선택해주세요.':'실패 사유를 입력해주세요',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
    fToast!.showToast(
      child: toast,
      positionedToastBuilder: (context, child) {
        return Positioned(
          child: child,
          bottom: 120,
          left: 20,
        );
      },
    );
  }
}
