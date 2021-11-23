import 'dart:math';

import 'package:ctg_delivery_v2/collect/collect_dialog.dart';
import 'package:ctg_delivery_v2/contstants/color.dart';
import 'package:ctg_delivery_v2/database_helper.dart';
import 'package:ctg_delivery_v2/main.dart';
import 'package:ctg_delivery_v2/model/map_card_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../cafe_info.dart';
import '../db_provider.dart';
import 'cafe_info_p.dart';
import 'collect_provider.dart';

class CollectScreenP extends StatefulWidget {
  const CollectScreenP(this.index, {Key? key}) : super(key: key);

  final int index;

  @override
  _CollectScreenPState createState() => _CollectScreenPState();
}

class _CollectScreenPState extends State<CollectScreenP> {
  double totalVolume = 0;
  int totalCount = 0;
  List wasteVolumes = [];
  List volumesToString = [];
  FToast? fToast;

  @override
  void initState() {
    // checkCollect();
    fToast = FToast();
    fToast!.init(context);
    super.initState();
  }

  // void checkCollect() {
  //   setState(() {
  //     (widget.data['pick_total_waste'] == null)
  //         ? totalVolume = 0
  //         : totalVolume = widget.data['pick_total_waste'];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DbProvider>(context);
    MapCardModel cardData = provider.mapList[provider.mapCardIndex];

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
                  (data.numberList.length == 0)
                      ? customToast(size)
                      : showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              insetPadding: EdgeInsets.all(20),
                              contentPadding: EdgeInsets.all(20),
                              actionsPadding: EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              title: const Text(
                                '입력하신 수거정보를\n확인해주세요.',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              content: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  '총 수거량 : ',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Text(
                                                  '${data.sumValue.toStringAsFixed(1)} kg ',
                                                  style: const TextStyle(
                                                      color: CoColor.coPrimary,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            color: CoColor.coPrimary,
                                            height: 1,
                                            thickness: 1,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  '총 수거 개수 : ',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Text(
                                                  '${data.numberList.length} 개',
                                                  style: const TextStyle(
                                                      color: CoColor.coPrimary,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          color: CoColor.coPrimary2,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: CoColor.coPrimary,
                                              width: 1)),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      '세부정보',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 70,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
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
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: Colors.grey, width: 1)),
                                    )
                                  ],
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: CoColor.coGrey4,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7.0))),
                                  ),
                                  child: Container(
                                    width: size.width / 2 - 90,
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        '취소',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    DbHelper().updateSuccess(
                                        cardData.pickId,
                                        data.sumValue,
                                        data.stringNumberList.toString());
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) => MyApp(),
                                        ),
                                        (route) => false);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: CoColor.coPrimary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7.0))),
                                  ),
                                  child: Container(
                                    width: size.width / 2 - 90,
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        '수거 완료',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
                      CafeInfoP(cardData),
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
                                leading: Image.asset(
                                  'assets/images/collectItems.png',
                                ),
                                title: TextButton(
                                  onPressed: () {
                                    collectPicker(
                                        data, context, 'modify', index, size);
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
                        collectPicker(data, context, 'add', 0, size);
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

  void collectPicker(CollectProvider data, BuildContext context, String useCase,
      int index, Size size) {
    Picker collectPicker = Picker(
        adapter: PickerDataAdapter(pickerdata: data.numberPickData),
        hideHeader: true,
        selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
          background: CoColor.coPrimary.withOpacity(0.1),
        ),
        textStyle: TextStyle(
            fontSize: 18, color: CoColor.coBlack, fontWeight: FontWeight.bold),
        selectedTextStyle: const TextStyle(color: CoColor.coPrimary),
        selecteds: [10],
        onConfirm: (Picker picker, List value) {
          switch (useCase) {
            case 'add':
              data.addListData(picker.getSelectedValues()[0]);
              break;
            case 'modify':
              data.modifyNumberList(picker.getSelectedValues()[0], index);
              break;
          }
          ;
        });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(20),
          contentPadding: EdgeInsets.all(20),
          actionsPadding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          title: Row(
            children: const [
              Expanded(
                  child: Center(
                child: Text(
                  "수거량을 입력해주세요.",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              )),
              // Text(
              //   "(단위 : kg)",
              //   style: TextStyle(fontSize: 14),
              // ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: CoColor.coGrey4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0))),
              ),
              child: Container(
                width: size.width / 2 - 90,
                height: 50,
                child: Center(
                  child: Text(
                    '취소',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                collectPicker.onConfirm!(
                    collectPicker, collectPicker.selecteds);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: CoColor.coPrimary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0))),
              ),
              child: Container(
                width: size.width / 2 - 90,
                height: 50,
                child: Center(
                  child: Text(
                    '저장',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
          content: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: collectPicker.makePicker()),
                Container(
                    width: 100,
                    child: Text(
                      'kg',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        );
      },
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

  void customToast(size) {
    Widget toast = Container(
      width: size.width - 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CoColor.coGrey2,
      ),
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            '수거 정보를 입력해주세요.',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
    fToast!.showToast(
      child: toast,
      positionedToastBuilder: (context, child) {
        return Positioned(
          child: child,
          bottom: 120,
          left: 20,
        );
      },
    );
  }
}
