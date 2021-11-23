import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:ctg_delivery_v2/map_screen.dart';

import 'package:ctg_delivery_v2/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TodoCard extends StatefulWidget {
  const TodoCard(
    this.index,
    this.cafeData,
    this.tab, {
    Key? key,
  }) : super(key: key);

  final int index;
  final List cafeData;
  final TabController tab;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  String uiTitle1 = '요청시간';
  String uiTitle2 = '경과시간';
  String dateString = '';
  String uiContents1 = '';
  String uiContents2 = '';
  Color uiContents2Color = CoColor.coBlack;

  @override
  void initState() {
    setUI();
    super.initState();
  }

  void setUI() {
    var data = widget.cafeData[widget.index];

    switch (data['pick_state']) {
      case 0:
        return setState(() {
          uiContents1 = dateFormat(data['last_call_date']);
          defernece(data['last_call_date']);
        });

      case 10:
        return setState(() {
          uiTitle1 = '실패 시간';
          uiTitle2 = '실패 사유';
          uiContents1 = dateFormat(data['pick_up_date']);
          uiContents2 = data['pick_fail_reason'];
          uiContents2Color = CoColor.coRedDark;
        });

      case 11:
        return setState(() {
          uiTitle1 = '완료 시간';
          uiTitle2 = '수거 총량';
          uiContents1 = dateFormat(data['pick_up_date']);
          uiContents2 = "${data['pick_total_waste'].toStringAsFixed(1)} kg";
        });

      case 20:
        return setState(() {
          uiTitle1 = '1';
          uiTitle2 = '1';
        });

      case 21:
        return setState(() {
          uiTitle1 = '2';
          uiTitle2 = '2';
        });

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CardUiProvider>(context);
    var data = widget.cafeData[widget.index];
    var textFactor = MediaQuery.of(context).textScaleFactor;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: InkWell(
        onTap: () {
          provider.changeMapIndex(data['location_id']);
          widget.tab.animateTo(1);
        },
        child: Card(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 170,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          CardUiProvider.nameSpilt(data, 'forward'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CoColor.coBlack,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          CardUiProvider.nameSpilt(data, 'behind'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CoColor.coGrey3,
                            fontSize: 13,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        CardUiProvider.stateText(data['pick_state'], 'todo'),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 85,
                            height: 85,
                            child: CircleAvatar(
                              radius: 42.5,
                              backgroundColor: CoColor.coGrey5,
                              child: CircleAvatar(
                                backgroundImage: checkImage(data),
                                // (data['location_postal'] != null)
                                //     ? NetworkImage(
                                //         "${data['location_postal']}")
                                //     : const NetworkImage(
                                //         'https://picsum.photos/200/300'),
                                radius: 42,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        uiTitle1,
                                        style: const TextStyle(
                                          color: CoColor.coGrey2,
                                        ),
                                      ),
                                      Text(
                                        uiContents1,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        uiTitle2,
                                        style: const TextStyle(
                                          color: CoColor.coGrey2,
                                        ),
                                      ),
                                      Text(
                                        uiContents2,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: uiContents2Color,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    180) /
                                                2,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              launch(
                                                  "tel://${data['location_tel']}");
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/phone.png',
                                                  fit: BoxFit.cover,
                                                  width: 14 * textFactor,
                                                  height: 14 * textFactor,
                                                  alignment: Alignment.center,
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  '전화걸기',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          14 * textFactor),
                                                ),
                                              ],
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(3),
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Color(0xFFDDDDDD)),
                                              primary: Colors.white,
                                              elevation: 0,
                                            )),
                                      ),
                                      SizedBox(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    180) /
                                                2,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              launch(
                                                  'https://map.kakao.com/link/to/${data['location_name']},${data['location_gps_lat']},${data['location_gps_long']}');
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/navi.png',
                                                  fit: BoxFit.cover,
                                                  width: 14 * textFactor,
                                                  height: 14 * textFactor,
                                                  alignment: Alignment.center,
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  '길 안내',
                                                  style: TextStyle(
                                                    color: Color(0xFF5A96FF),
                                                    fontSize: (14 * textFactor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(3),
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Color(0xFF5A96FF)),
                                              primary: Colors.white,
                                              elevation: 0,
                                            )),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void defernece(date) {
    var stringToDate = DateFormat('yy-MM-dd HH:mm').parse(date);
    final now = DateTime.now();

    int dif = now.difference(stringToDate).inHours;
    if (dif < 2) {
      uiContents2 = '1시간 이내';
      uiContents2Color = CoColor.coGreen;
    } else if (dif >= 2 && dif < 6) {
      uiContents2 = '$dif시간 경과';
      uiContents2Color = CoColor.coGreen;
    } else if (dif >= 6 && dif < 12) {
      uiContents2 = '$dif시간 경과';
      uiContents2Color = CoColor.coOrange;
    } else if (dif >= 12 && dif < 24) {
      uiContents2 = '$dif시간 경과';
      uiContents2Color = CoColor.coYellowC;
    } else {
      uiContents2 = '1일 이상 지남';
      uiContents2Color = CoColor.coRed;
    }
  }

  checkImage(data) {
    if (data['location_name'] == '대림창고(성수)') {
      return const AssetImage('assets/images/daerim.jpg');
    } else {
      return NetworkImage("${data['location_postal']}");
    }
  }


}

String dateFormat(date) {
  var stringToDate = DateFormat('yy-MM-dd HH:mm').parse(date);
  var format = DateFormat('yy/MM/dd HH:mm');
  return format.format(stringToDate);
}
