import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'contstants/color.dart';

class PreviousHistory extends StatefulWidget {
  const PreviousHistory({Key? key}) : super(key: key);

  @override
  State<PreviousHistory> createState() => _PreviousHistoryState();
}

class _PreviousHistoryState extends State<PreviousHistory> {
  List DateList = [];
  var _selectedValue = DateFormat('yyyy년MM월').format(DateTime.now());

  @override
  void initState() {
    setDateList();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void setDateList() {
    var now = DateTime.now();
    for (int i = 0; i < 36; i++) {
      DateList.add(
          DateFormat('yyyy년MM월').format(DateTime(now.year, now.month - i)));
    }
    String formatYearMonth = DateFormat('yyyy년MM월').format(now);
    String formatDay = DateFormat('dd일').format(now);
    print(now);
    print(formatYearMonth);
    print(DateList);
    print(formatDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '수거 내역',
          style: TextStyle(
            color: CoColor.coBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: CoColor.coBlack),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  DropdownButton(
                    value: _selectedValue,
                    focusColor: CoColor.coPrimary,
                    items: DateList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text('$value'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value.toString();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
