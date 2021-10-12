import 'package:ctg_delivery_v2/todo_card.dart';
import 'package:ctg_delivery_v2/visible_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen(this.todoList, this.tab, this.finalCard, {Key? key})
      : super(key: key);

  final List todoList;
  final List finalCard;
  final TabController tab;

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  bool _visible = false;
  int _totalCount = 0;
  int _successCount = 0;
  int _failCount = 0;

  @override
  void initState() {
    visibleCheck();
    super.initState();
  }

  void visibleCheck() {
    print('run visibleCheck');
    int i = widget.todoList
        .where((element) => element['pick_state'] != 0)
        .toList()
        .length;
    int j = widget.todoList
        .where((element) => element['pick_state'] == 10)
        .toList()
        .length;
    int k = widget.todoList
        .where((element) => element['pick_state'] == 11)
        .toList()
        .length;
    setState(() {
      _totalCount = i;
      _failCount = j;
      _successCount = k;
      if (i == widget.todoList.length) {
        _visible = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                child: VisibleCard(widget.finalCard),
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
                      text: '${widget.todoList.length}건 ',
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
                        text: '/${widget.todoList.length}',
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
            itemCount: widget.todoList.length,
            itemBuilder: (context, index) {
              return TodoCard(
                index,
                widget.todoList,
                widget.tab,
              );
            },
          ),
        ),
      ],
    );
  }
}
