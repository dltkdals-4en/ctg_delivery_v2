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
  var _selectedValue = '';
  var selectedDate = DateTime.now();
  int selectedDay = 0;
  int lastDay = 0;

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
    for (int i = 0; i < 36; i++) {
      DateList.add(DateFormat('yyyy년MM월')
          .format(DateTime(selectedDate.year, selectedDate.month - i)));
    }
    String formatYearMonth = DateFormat('yyyy년MM월').format(selectedDate);
    setState(() {
      selectedDay = selectedDate.day;
      _selectedValue = formatYearMonth;
      (selectedDate.month < 12)
          ? lastDay = DateTime(selectedDate.year, selectedDate.month + 1, 0).day
          : lastDay = DateTime(selectedDate.year + 1, 1, 0).day;
    });
    print(formatYearMonth);
    print(DateList);
    print(lastDay);
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                      Text('$selectedDay일'),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_forward_ios)),
                    ],
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
