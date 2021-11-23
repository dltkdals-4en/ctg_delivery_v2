import 'package:ctg_delivery_v2/database_helper.dart';
import 'package:ctg_delivery_v2/model/map_card_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'contstants/color.dart';
import 'model/todo_card_model.dart';

class DbProvider with ChangeNotifier {
  List<TodoCardModel> todoList = [];
  List<MapCardModel> mapList = [];
  String uiTitle1 = '요청 시간';
  String uiTitle2 = '경과 시간';
  String dateString = '';
  String uiContents1 = '';
  String uiContents2 = '';
  Color uiContents2Color = CoColor.coBlack;
  int mapCardIndex = 0;
  List position = [];
  TabController? tab;
  var mapCardPanelState = PanelState.CLOSED;
  bool visible = false;
  int scheduleCount = 0;
  int sucCount = 0;
  int failCount = 0;
  int totalCount = 0;

  Future<List<TodoCardModel>> getTodoList() async {
    todoList = await DbHelper().getCardList();
    totalCount = todoList.length;
    return todoList;
  }
 
  Future<List<MapCardModel>> getMapList() async {
    mapList = await DbHelper().getMapCardList();
    getPosition();
    return mapList;
  }

  dataInitialization() async {
    await DbHelper().dataInitialization();

    getTodoList();
    getMapList();
    getPosition();
    updateCounts();
    notifyListeners();
  }

  void setUI(index) {
    var data = todoList[index];

    switch (data.state) {
      case 0:
        uiTitle1 = '요청 시간';
        uiTitle2 = '경과 시간';
        uiContents1 = dateFormat(data.lastCallDate);
        defernece(data.lastCallDate);

        break;

      case 10:
        uiTitle1 = '실패 시간';
        uiTitle2 = '실패 사유';
        uiContents1 = dateFormat(data.pickUpDate);
        uiContents2 = data.failReason!;
        uiContents2Color = CoColor.coRedDark;

        break;

      case 11:
        uiTitle1 = '완료 시간';
        uiTitle2 = '수거 총량';
        uiContents1 = dateFormat(data.pickUpDate);
        uiContents2 = "${data.totalWaste!.toStringAsFixed(1)} kg";
        uiContents2Color = Colors.black;
        break;

      case 20:
        uiTitle1 = '1';
        uiTitle2 = '1';

        break;

      case 21:
        uiTitle1 = '2';
        uiTitle2 = '2';

        break;

      default:
        break;
    }
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
    if (data.locationName == '대림창고(성수)') {
      return const AssetImage('assets/images/daerim.jpg');
    } else {
      return NetworkImage("${data.postal}");
    }
  }

  Image setImage(MapCardModel data) {
    if (data.locationName == '포이엔') {
      return Image.asset(
        'assets/images/4enLogo2.png',
        fit: BoxFit.cover,
      );
    } else if (data.locationName == '집하') {
      return Image.asset(
        'assets/images/4en.jpg',
        fit: BoxFit.cover,
      );
    } else if (data.locationName == '대림창고(성수)') {
      return Image.asset(
        'assets/images/daerim.jpg',
        fit: BoxFit.cover,
        width: 98,
        height: 98,
      );
    } else if (data.postal != null) {
      return Image.network(
        '${data.postal}',
        fit: BoxFit.cover,
      );
    } else {
      return Image.network(
        '${data.postal}',
        fit: BoxFit.cover,
      );
    }
  }

  String dateFormat(date) {
    var stringToDate = DateFormat('yy-MM-dd HH:mm').parse(date);
    var format = DateFormat('yy/MM/dd HH:mm');
    return format.format(stringToDate);
  }

  Future<void> getPosition() async {
    position.clear();
    if (position.isEmpty) {
      for (int i = 0; i < mapList.length; i++) {
        position.add({
          'title': mapList[i].locationName,
          'lat': mapList[i].gps_lat,
          'lng': mapList[i].gps_lng,
          'state': mapList[i].state,
          'id': mapList[i].pickOrder,
        });
      }
    }
  }

  updateCounts() {
    scheduleCount = todoList.where((element) => element.state != 0).length;
    sucCount = todoList.where((element) => element.state == 11).length;
    failCount = todoList.where((element) => element.state == 10).length;
    visibleCheck();

  }

  changeMapCard(locationName) {
    for (int i = 0; i < mapList.length; i++) {
      print(mapList[i].locationName);
    }

    mapCardIndex =
        mapList.indexWhere((element) => element.locationName == locationName);
    mapCardPanelState = PanelState.OPEN;
    notifyListeners();
  }

  void visibleCheck() {
    (scheduleCount == totalCount) ? visible = true : visible = false;

  }
}
