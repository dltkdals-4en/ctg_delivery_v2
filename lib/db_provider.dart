import 'package:ctg_delivery_v2/database_helper.dart';
import 'package:flutter/cupertino.dart';

import 'model/todo_card_model.dart';

class DbProvider with ChangeNotifier{
  List<TodoCardModel> todoList = [];
  List mapList =[];

  Future<void> getTodoList() async{
    todoList =await DbHelper().getCardList();
    notifyListeners();
  }

}