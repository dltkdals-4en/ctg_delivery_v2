import 'dart:math';

import 'package:ctg_delivery_v2/collect/collect_dialog.dart';
import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:ctg_delivery_v2/database_helper.dart';
import 'package:ctg_delivery_v2/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:provider/provider.dart';

import '../cafe_info.dart';
import 'collect_provider.dart';

class CollectScreen extends StatefulWidget {
  const CollectScreen(this.data, {Key? key}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  _CollectScreenState createState() => _CollectScreenState();
}

class _CollectScreenState extends State<CollectScreen> {
  double totalVolume = 0;
  int totalCount = 0;
  List wasteVolumes = [];
  List volumesToString = [];

  @override
  void initState() {
    checkCollect();

    super.initState();
  }

  void checkCollect() {
    setState(() {
      (widget.data['pick_total_waste'] == null)
          ? totalVolume = 0
          : totalVolume = widget.data['pick_total_waste'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (BuildContext context) => CollectProvider(),
      child: Consumer<CollectProvider>(builder: (context, data, child) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,

            // backgroundColor: Colors.white,
            title: const Center(
              child: Text(
                '수거량 입력',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),

            elevation: 0,
            actions: [
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          '입력하신 수거정보를\n확인해주세요.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        content: Container(
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Text(
                                            '총 수거량 : ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            '${data.sumValue.toStringAsFixed(1)} kg ',
                                            style: const TextStyle(
                                                color: Color(0xFF5A96FF),
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.blue,
                                      height: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Text(
                                            '총 수거 개수 : ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            '${data.numberList.length} 개',
                                            style: const TextStyle(
                                                color: Color(0xFF5A96FF),
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: Colors.blue, width: 1)),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('세부정보'),
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      height: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        data.stringNumberList
                                            .toString()
                                            .substring(
                                                1,
                                                data.stringNumberList
                                                        .toString()
                                                        .toString()
                                                        .length -
                                                    1)
                                            .replaceAll(',', ' / '),
                                        // volumesToString
                                        //     .toString()
                                        //     .substring(
                                        //         1,
                                        //         volumesToString
                                        //                 .toString()
                                        //                 .length -
                                        //             1)
                                        //     .replaceAll(',', ' / '),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: Colors.grey, width: 1)),
                              )
                            ],
                          ),
                        ),
                        actions: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              print('reset');
                            },
                            child: const Text('다시입력'),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                DbHelper().updateSuccess(widget.data['pick_id'],
                                    data.sumValue, data.stringNumberList.toString());
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ));
                              },
                              child: const Text('수거완료')),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  '완료',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Container(
              color: Colors.grey[200],
              child: Stack(
                children: [
                  Column(
                    children: <Widget>[
                      CafeInfo(widget.data),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Total',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      '${data.sumValue.toStringAsFixed(1)} kg / ${data.numberList.length} 개',
                                      style: const TextStyle(
                                          color: Color(0xFF5A96FF),
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey[500],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Wrap(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          '총 수거량',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                        Text(
                                          '${data.sumValue.toStringAsFixed(1)} kg',
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          '총 수거 개수',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                        Text(
                                          '${data.numberList.length} 개',
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: data.numberList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.white,
                              child: ListTile(
                                leading: Text('${index + 1}'),
                                title: TextButton(
                                  onPressed: () {
                                    Picker(
                                        adapter: PickerDataAdapter(
                                            pickerdata: data.numberPickData),
                                        hideHeader: true,
                                        title: Row(
                                          children: const [
                                            Expanded(child: Text("수거량 수정")),
                                            Text(
                                              "(단위 : kg)",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        selecteds: [
                                          data.numberPickData.indexWhere(
                                              (element) =>
                                                  element ==
                                                  data.numberList[index])
                                        ],
                                        selectedTextStyle: const TextStyle(
                                            color: CoColor.coPrimary),
                                        cancelText: '취소',
                                        confirmText: '수정',
                                        onConfirm: (Picker picker, List value) {
                                          data.modifyNumberList(
                                              picker.getSelectedValues()[0],
                                              index);
                                        }).showDialog(context);
                                  },
                                  child: Text(
                                    '${data.numberList[index]} kg',
                                    style: const TextStyle(
                                      color: CoColor.coBlack,
                                    ),
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    data.deleteNumberList(index);
                                  },
                                  icon: Icon(Icons.clear),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    height: 60,
                    width: 60,
                    bottom: 20,
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: () {
                        data.makeNumberPickData();
                        Picker(
                            adapter: PickerDataAdapter(
                                pickerdata: data.numberPickData),
                            hideHeader: true,
                            title: Row(
                              children: const [
                                Expanded(child: Text("수거량 입력 ")),
                                Text(
                                  "(단위 : kg)",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            selectedTextStyle:
                                const TextStyle(color: CoColor.coPrimary),
                            selecteds: [10],
                            cancelText: '취소',
                            confirmText: '입력',
                            onConfirm: (Picker picker, List value) {
                              data.addListData(picker.getSelectedValues()[0]);
                            }).showDialog(context);
                      },
                      child: const Icon(
                        Icons.add,
                        size: 60,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void addVolume() {
    return setState(() {
      double i = Random().nextInt(200) / 10.00;
      // wasteVolumes.add(i);
      volumesToString.add('$i kg');
      totalVolume = 0.0;

      volumesToString.forEach((element) {
        var j = double.parse(element.toString().replaceAll('kg', '').trim());
        print(j);
        totalVolume += j;
      });
      // wasteVolumes.forEach((element) {
      //   totalVolume += element;
      // });
      totalCount = volumesToString.length;
    });
  }

  void removeVolume(int index) {
    return setState(() {
      // wasteVolumes.removeAt(index);
      volumesToString.removeAt(index);
      totalVolume = 0.0;
      volumesToString.forEach((element) {
        var j = double.parse(element.toString().replaceAll('kg', '').trim());
        print(j);
        totalVolume += j;
      });
      // wasteVolumes.forEach((element) {
      //   totalVolume += element;
      // });
      totalCount = volumesToString.length;
    });
  }
}
