import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:ctg_delivery_v2/db_provider.dart';
import 'package:ctg_delivery_v2/map_screen.dart';

import 'package:ctg_delivery_v2/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TodoCardP extends StatefulWidget {
  const TodoCardP(
    this.index, {
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  State<TodoCardP> createState() => _TodoCardPState();
}

class _TodoCardPState extends State<TodoCardP> {
  @override
  void initState() {
    Provider.of<DbProvider>(context, listen: false).setUI(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DbProvider>(context);
    var data = provider.todoList[widget.index];
    var textFactor = MediaQuery.of(context).textScaleFactor;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: InkWell(
        onTap: () {},
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
                          TodoProvider.nameSpilt(data, 'forward'),
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
                          TodoProvider.nameSpilt(data, 'behind'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CoColor.coGrey3,
                            fontSize: 13,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        TodoProvider.stateText(data.state, 'todo'),
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
                                backgroundImage: provider.checkImage(data),
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
                                        provider.uiTitle1,
                                        style: const TextStyle(
                                          color: CoColor.coGrey2,
                                        ),
                                      ),
                                      Text(
                                        provider.uiContents1,
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
                                        provider.uiTitle2,
                                        style: const TextStyle(
                                          color: CoColor.coGrey2,
                                        ),
                                      ),
                                      Text(
                                        provider.uiContents2,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: provider.uiContents2Color,
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
                                              launch("tel://${data.tel}");
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
                                                  'https://map.kakao.com/link/to/${data.locationName},${data.gps_lat},${data.gps_lng}');
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
}
