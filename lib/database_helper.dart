import 'package:ctg_delivery_v2/db_provider.dart';
import 'package:ctg_delivery_v2/model/map_card_model.dart';
import 'package:ctg_delivery_v2/model/todo_card_model.dart';
import 'package:ctg_delivery_v2/model/user_model.dart';
import 'package:ctg_delivery_v2/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class DbHelper with ChangeNotifier {
  List cardList = [];
  List mapList = [];
  List<TodoCardModel> todoList = [];
  List<MapCardModel> mapCardList = [];
  late TabController tab;
  List user =[];
  bool isLoading = false;

  Future<void> openDB() async {}

  Future<Database> init() async {
    var dbPath = await getDatabasesPath();

    var path = join(dbPath, 'ctgdb8.db');

    bool dbExists = await databaseExists(path);

    if (!dbExists) {
      ByteData data =
          await rootBundle.load(join('assets/database', 'coffeetogo'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await io.File(path).writeAsBytes(bytes, flush: true);
    }
    return await openDatabase(path);
  }

  Future<List<Map<dynamic, dynamic>>> getTodoList() async {
    final db = await init();
    return db.rawQuery(
        'select * from waste_location l, pick_task p where l.location_id = p.location_id and (p.pick_state not in (20,21)) order by p.pick_order');
  }

  Future<List<TodoCardModel>> getCardList() async {
    final db = await init();
    cardList = await db.rawQuery(
        'select * from waste_location l, pick_task p where l.location_id = p.location_id and (p.pick_state not in (20,21)) order by p.pick_order');

    todoList = List.generate(cardList.length, ((i) {
      return TodoCardModel.fromJson(cardList[i]);
    }));

    notifyListeners();
    return todoList;
  }

  Future<List<MapCardModel>> getMapCardList() async {
    final db = await init();
    mapList = await db.rawQuery(
        'select * from waste_location l, pick_task p where l.location_id = p.location_id order by p.pick_order');

    mapCardList = List.generate(mapList.length, ((i) {
      return MapCardModel.fromJson(mapList[i]);
    }));

    notifyListeners();
    return mapCardList;
  }

  Future<List<Map<dynamic, dynamic>>> getMapList() async {
    final db = await init();
    return db.rawQuery(
        'select * from waste_location l, pick_task p where l.location_id = p.location_id order by p.pick_order');
  }

  Future<List<Map<dynamic, dynamic>>> finalLocation() async {
    final db = await init();
    return db.rawQuery(
        'select * from waste_location l, pick_task p where l.location_id = p.location_id and p.pick_state =21 limit 1');
  }

  Future<int> updateSuccess(id, totalVolume, String volumes) async {
    final db = await init();

    final result = await db.rawUpdate(
        "update pick_task set pick_state = 11, pick_details ='$volumes', pick_total_waste = $totalVolume, pick_up_date = '${DateTime.now()}'  where pick_id = $id");
    return result;
  }

  Future<void> updateFail(id, failCode, failReason) async {
    final db = await init();
    await db.rawUpdate(
        "update pick_task set pick_state = 10, pick_fail_code = $failCode, pick_fail_reason = '$failReason', pick_up_date = '${DateTime.now()}'  where pick_id = $id");
  }

  Future<void> getPathList() async {
    final db = await init();
    mapList = await db.rawQuery(
        'select * from waste_location l, pick_task p where l.location_id = p.location_id order by p.pick_order');


    notifyListeners();
  }

  Future<void> dataInitialization() async {
    final db = await init();
    db.rawUpdate(
        "update pick_task set pick_state = 0 , pick_details = '', pick_total_waste = 0, pick_fail_reason= '', pick_fail_code = 0 where pick_state not in (20,21)");
    db.rawUpdate(
        "update waste_location set last_call_date = '${DateTime.now()}'  where location_id in (select location_id from pick_task where pick_state not in(20,21))");
  }

  Future<UserModel> getUserInfo(phone) async {
    final db = await init();


    user = await db.rawQuery(
        "select * from users where user_phone = '$phone'");
    return UserModel.fromJson(user[0]);
  }
  Future<dynamic> findUser(phone) async{
    final db = await init();
    var i = await db.rawQuery("select count(*) from users where user_phone = '$phone'");

    return await i[0]['count(*)'];
  }
  Future<dynamic> verificationNumber(number, phone) async{
    final db = await init();
    var i = await db.rawQuery("select count(*) from users where user_phone = '$phone' and authentication_number = '$number'");
    print(i[0]['count(*)']);
    print(await i[0]['count(*)']);
    return await i[0]['count(*)'];
  }

  Future<int> LoginPreferences() async{
    final prefs = await SharedPreferences.getInstance();
    String phone = (prefs.getString('phone') ?? '');
    String number = (prefs.getString('verifyNumber') ?? '');
    print(phone);
    print(number);
   return await verificationNumber(number, phone);


  }
}
