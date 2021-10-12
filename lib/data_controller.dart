import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctg_delivery_v2/model/waste_location_model.dart';

import 'package:flutter/material.dart';

class DataController with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> getFirebaseData() async {
    var data = await _firestore.collection('waste_location').get();
    print(data);
    for (var element in data.docs) {
      WasteLocationModel.fromJson(element.data(), element.id);
    }

  }
}
