import 'package:ctg_delivery_v2/main.dart';
import 'package:ctg_delivery_v2/todo_provider.dart';
import 'package:ctg_delivery_v2/todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'map_screen.dart';

class TabPage extends StatefulWidget {
  const TabPage(
    this.tab,
    this.todoList,
    this.mapList,
    this.finalCard, {
    Key? key,
  }) : super(key: key);

  final TabController tab;
  final List todoList;
  final List mapList;
  final List finalCard;

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int mapIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(controller: widget.tab, children: [
      TodoScreen(
        widget.todoList,
        widget.tab,
        widget.finalCard,
      ),
      MapScreen(widget.mapList, mapIndex),
    ]);
  }
}
