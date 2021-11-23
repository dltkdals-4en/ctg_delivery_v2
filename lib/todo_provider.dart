import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:ctg_delivery_v2/model/map_card_model.dart';
import 'package:flutter/material.dart';

class CardUiProvider with ChangeNotifier {
  String uiTitle1 = '요청시간';
  String uiTitle2 = '경과시간';


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

  static checkImage(MapCardModel data) {
    if (data.locationName == '대림창고(성수)') {
      return const AssetImage('assets/images/daerim.jpg');
    } else {
      return NetworkImage("${data.postal}");
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
