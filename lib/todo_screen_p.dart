import 'package:ctg_delivery_v2/database_helper.dart';
import 'package:ctg_delivery_v2/db_provider.dart';
import 'package:ctg_delivery_v2/todo_card.dart';
import 'package:ctg_delivery_v2/todo_card_p.dart';
import 'package:ctg_delivery_v2/visible_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoScreenP extends StatefulWidget {
  TodoScreenP( {Key? key})
      : super(key: key);



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
    var data = Provider.of<DbHelper>(context);
    var data2 = Provider.of<DbProvider>(context);
    var todolist = data2.todoList;
    print(todolist);
    return Column(
      children: [
        Visibility(
          visible: _visible,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '최종 집하지',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: '수거완료 ',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '$_successCount ',
                                style: const TextStyle(
                                  color: Color(0xFF5A96FF),
                                ),
                              ),
                              const TextSpan(
                                text: '· 미수거 ',
                              ),
                              TextSpan(
                                text: '$_failCount ',
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
                // child: VisibleCard(todolist[0]),
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
                  text: '오늘 수거 일정이 \n',
                  style: const TextStyle(fontSize: 24),
                  children: [
                    TextSpan(
                      text: '${todolist.length}건 ',
                      style: const TextStyle(
                          color: Color(0xFF5A96FF),
                          fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: '있어요.'),
                  ],
                ),
              ), //일정 text
              Text.rich(
                TextSpan(
                  text: '$_totalCount',
                  style: const TextStyle(
                      color: Color(0xFF5A96FF),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: '/${todolist.length}',
                        style: const TextStyle(color: Color(0xFF1C1C1C)))
                  ],
                ),
              ), //개수표시
            ],
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: todolist.length,
            itemBuilder: (context, index) {
              return TodoCardP(index);
            },
          ),
        ),
      ],
    );
  }
}
