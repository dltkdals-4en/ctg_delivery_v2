import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:flutter/material.dart';

class TodoProvider with ChangeNotifier {
  String uiTitle1 = '요청시간';
  String uiTitle2 = '경과시간';

  static Widget CardWidget(List cafeData, int index, String perpose) {
    return Card(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${cafeData[index]['location_name']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    stateText(cafeData[index]['pick_state'], perpose),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xFFDDDDDD),
                          child: CircleAvatar(
                            radius: 39,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundImage: (cafeData[index]
                                          ['location_postal'] !=
                                      null)
                                  ? NetworkImage(
                                      "${cafeData[index]['location_postal']}")
                                  : const NetworkImage(
                                      'https://picsum.photos/200/300'),
                              radius: 38,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CardText1(),
                              CardText2(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 110,
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.phone,
                                              color: CoColor.coBlack,
                                            ),
                                            Text(
                                              '전화걸기',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          side: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFDDDDDD)),
                                          primary: Colors.white,
                                          elevation: 0,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 110,
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.directions,
                                              color: Color(0xFF5A96FF),
                                            ),
                                            Text(
                                              '길 안내',
                                              style: TextStyle(
                                                  color: Color(0xFF5A96FF)),
                                            ),
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
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
    );
  }

  static Row CardText2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '경과시간',
          style: TextStyle(
            color: Color(0xffA8A8A8),
          ),
        ),
        Text(
          '1시간 이내',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  static Row CardText1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          '요청시간',
          style: TextStyle(
            color: Color(0xffA8A8A8),
          ),
        ),
        Text(
          '2021/09/24 14:00',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  static Widget stateText(state, perpose) {
    switch (state) {
      case 0:
        return RichText(
          text: TextSpan(
            children: [
              (perpose == 'map')
                  ? const WidgetSpan(
                      child: Icon(
                        Icons.remove_circle_outline,
                        size: 16,
                        color: CoColor.coYellow,
                      ),
                    )
                  : const WidgetSpan(child: SizedBox()),
              const TextSpan(
                text: '대기',
                style: TextStyle(
                  color: CoColor.coYellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      case 10:
        return RichText(
          text: TextSpan(
            children: [
              (perpose == 'map')
                  ? const WidgetSpan(
                      child: Icon(
                        Icons.clear_rounded,
                        size: 16,
                        color: Colors.red,
                      ),
                    )
                  : const WidgetSpan(child: SizedBox()),
              const TextSpan(
                text: '실패',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      case 11:
        return RichText(
          text: TextSpan(
            children: [
              (perpose == 'map')
                  ? const WidgetSpan(
                      child: Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: Colors.greenAccent,
                      ),
                    )
                  : const WidgetSpan(child: SizedBox()),
              const TextSpan(
                text: '완료',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      default:
        return const SizedBox();
    }
  }

  Widget CardUI(state, perpose) {
    switch (perpose) {
      case 'todo':
        switch (state) {
          case 0:
            break;
          case 10:
            break;
          case 11:
            break;
          case 20:
            break;
          case 21:
            break;
          default:
            return const Text('에러');
        }
        break;
      case 'map':
        break;
    }

    return Container();
  }

  static String nameSpilt(data, compose) {
    String originString = data.locationName;
    String parseData = '(';
    String parseString = '';
    if (originString.contains('(')) {
      var parseText = originString.indexOf(parseData);
      switch (compose) {
        case 'forward':
          parseString = originString.substring(0, parseText);
          break;
        case 'behind':
          parseString =
              originString.substring(parseText + 1, originString.length - 1);
          break;
      }
      return parseString;
    } else {
      (compose == 'forward') ? parseString = originString : parseString = '';

      return parseString;
    }
  }

  static checkImage(data) {
    if (data['location_name'] == '대림창고(성수)') {
      return const AssetImage('assets/images/daerim.jpg');
    } else {
      return NetworkImage("${data['location_postal']}");
    }
  }

  int mapLocId = 0;
  int mapIndex = 0;

  void changeMapIndex(i) {
    print('qweqweqwe $i');
    mapLocId = i;
    (mapIndex < 1) ? mapIndex = 0 : mapIndex = i - 1;
    notifyListeners();
  }
}
