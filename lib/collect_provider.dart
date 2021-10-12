 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/collect_data_model.dart';

class CollectProvider with ChangeNotifier {
  TextEditingController t = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<CollectDataModel> list = [];

  double totalVolume = 0.00;
  int id = 0;
  List<TextEditingController> tlist = [];
  List<FocusNode> flist = [];
  int length = 1;
  int count = 0;
  List collectList = [];

  /* numberpicker 용 변수 */
  List numberList = [];
  List unit = ['kg', 'g'];
  List pickerList = [
    [
      0.5,
      1.0,
      1.5,
      2.0,
      2.5,
      3.0,
      3.5,
      4.0,
      4.5,
      5.0,
      5.5,
      6.0,
      6.5,
      7.0,
      7.5,
      8.0,
      8.5,
      9.0,
      9.5,
      10.0,
      10.5,
      11.0,
      11.5,
      12.0,
      12.5,
      13.0,
      13.5,
      14.0,
      14.5,
      15.0,
      15.5,
      16.0,
      16.5,
      17.0,
      17.5,
      18.0,
      18.5,
      19.0,
      19.5,
      20.0
    ],
    ["kg", "g"]
  ];
  static const pickerL = '''[
    [
      0.5,
      1.0,
      1.5,
      2.0,
      2.5,
      3.0,
      3.5,
      4.0,
      4.5,
      5.0,
      5.5,
      6.0,
      6.5,
      7.0,
      7.5,
      8.0,
      8.5,
      9.0,
      9.5,
      10.0,
      10.5,
      11.0,
      11.5,
      12.0,
      12.5,
      13.0,
      13.5,
      14.0,
      14.5,
      15.0,
      15.5,
      16.0,
      16.5,
      17.0,
      17.5,
      18.0,
      18.5,
      19.0,
      19.5,
      20.0
    ],
    ["kg", "g"]
  ]''';

  int nLength = 1;
  List<double> numberPickData = [];
  double sumValue = 0.0;
  List<String> stringNumberList = [];

  void makeNumberPickData() {
    numberPickData.clear();
    for (var i = 1; i <= 40; i++) {
      numberPickData.add(i / 2);
    }
    pickerList[0] = numberPickData;
    print(pickerList);
    print(numberPickData.length);

    notifyListeners();
  }

  void addListData(value) {
    numberList.add(value);
    print(numberList);
    totalNumberList();
    notifyListeners();
  }

  void deleteNumberList(index) {
    numberList.removeAt(index);
    totalNumberList();
    notifyListeners();
  }

  void modifyNumberList(value, index) {
    numberList[index] = value;
    totalNumberList();
    notifyListeners();
  }

  void totalNumberList() {
    sumValue = 0.0;
    stringNumberList =[];
    numberList.forEach((element) {
      stringNumberList.add('$element kg');
      sumValue += element;
    });
    notifyListeners();
  }

  void addlist(context) {
    FocusNode? focusNode = new FocusNode();
    TextEditingController t = new TextEditingController();

    tlist.add(t);
    flist.add(focusNode);
    length++;
    print(focusNode);
    print(focusNode.context);
    FocusScope.of(context).requestFocus(flist.last);
    notifyListeners();
  }

  void deletelist(index) {
    tlist[index].clear();
    tlist.removeAt(index);
    flist.removeAt(index);
    length--;
    notifyListeners();
  }

  void add(text) {
    id++;
    FocusNode? focusNode = new FocusNode();
    TextEditingController t = new TextEditingController();
    if (text.runtimeType == String) {
      text = double.parse(text);
    }
    list.add(CollectDataModel(
      collectId: id,
      volume: text,
      focusNode: focusNode,
      t: t,
    ));
    notifyListeners();
  }

  void delete(i) {
    list[i].t?.clear();
    list.removeAt(i);

    notifyListeners();
  }

  void sumVolume() {}

  void getCount() {
    totalVolume = 0;
    count = 0;
    collectList = [];
    tlist.forEach((element) {
      print(element.text);
      if (element.text != '') {
        var volume = double.parse(element.text);
        collectList.add(volume);
        totalVolume += volume;
      }
    });
    count = tlist.where((element) => element.text != '').length;
    notifyListeners();
  }

  dataUpdate(text) {}

  findFocus(BuildContext context) {
    var node = list.last.focusNode;
    Focus.of(context).requestFocus(node);
  }

  void sendData(
    docId,
    double totalVolume,
    List collectList,
  ) async {
    await _firestore.collection('local_data').doc(docId).update({
      'state': 11,
    });
    await _firestore
        .collection('local_data')
        .doc(docId)
        .collection('waste_info_details')
        .add({
      'pick_details': collectList,
      'pick_total_waste': totalVolume,
      'create_date': DateTime.now(),
    });
  }
}
