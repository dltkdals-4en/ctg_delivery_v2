import 'package:ctg_delivery_v2/database_helper.dart';
import 'package:ctg_delivery_v2/db_provider.dart';
import 'package:ctg_delivery_v2/todo_card.dart';
import 'package:ctg_delivery_v2/todo_card_p.dart';
import 'package:ctg_delivery_v2/visible_card.dart';
import 'package:ctg_delivery_v2/visible_card_p.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/todo_card_model.dart';

class TodoScreenP extends StatefulWidget {
  TodoScreenP({Key? key}) : super(key: key);

  @override
  State<TodoScreenP> createState() => _TodoScreenPState();
}

class _TodoScreenPState extends State<TodoScreenP> {
  bool _visible = false;
  int _totalCount = 0;
  int _successCount = 0;
  int _failCount = 0;

  @override
  void initState() {
    // visibleCheck();
    super.initState();
  }

  // void visibleCheck() {
  //   print('run visibleCheck');
  //   int i = todoList
  //       .where((element) => element['pick_state'] != 0)
  //       .toList()
  //       .length;
  //   int j = todoList
  //       .where((element) => element['pick_state'] == 10)
  //       .toList()
  //       .length;
  //   int k = todoList
  //       .where((element) => element['pick_state'] == 11)
  //       .toList()
  //       .length;
  //   setState(() {
  //     _totalCount = i;
  //     _failCount = j;
  //     _successCount = k;
  //     if (i == todoList.length) {
  //       _visible = true;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var dbHelper = Provider.of<DbHelper>(context);
    var dbProvider = Provider.of<DbProvider>(context);
    // var todolist = Provider.of<List<TodoCardModel>>(context);

    return FutureBuilder(
        future: dbProvider.getTodoList(),
        builder: (context, snapshot) {
          var todolist = dbProvider.todoList;
          dbProvider.updateCounts();
          return (snapshot.hasData)
              ? Column(
                  children: [
                    Visibility(
                      visible: dbProvider.visible,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '?????? ?????????',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Wrap(
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        text: '???????????? ',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                            text: '${dbProvider.sucCount}',
                                            style: const TextStyle(
                                              color: Color(0xFF5A96FF),
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '?? ????????? ',
                                          ),
                                          TextSpan(
                                            text: '${dbProvider.failCount}',
                                            style: const TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                            child: VisibleCardP(),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: '?????? ?????? ????????? \n',
                              style: const TextStyle(fontSize: 24),
                              children: [
                                TextSpan(
                                  text: '${todolist.length}??? ',
                                  style: const TextStyle(
                                      color: Color(0xFF5A96FF),
                                      fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(text: '?????????.'),
                              ],
                            ),
                          ), //?????? text
                          Text.rich(
                            TextSpan(
                              text: '${dbProvider.scheduleCount}',
                              style: const TextStyle(
                                  color: Color(0xFF5A96FF),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                    text: '/${todolist.length}',
                                    style: const TextStyle(
                                        color: Color(0xFF1C1C1C)))
                              ],
                            ),
                          ), //????????????
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: (todolist == null) ? 0 : todolist.length,
                        itemBuilder: (context, index) {
                          return TodoCardP(index);
                        },
                      ),
                    ),
                  ],
                )
              : Container();
        });
  }

  Future<bool> visibleCheck(List<TodoCardModel> todolist, int count) async {
    await (todolist.length == count) ? _visible = true : _visible = false;

    return _visible;
  }
}
