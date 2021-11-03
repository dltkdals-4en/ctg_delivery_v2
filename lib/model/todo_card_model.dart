import 'package:cloud_firestore/cloud_firestore.dart';

class TodoCardModel {
  int? pickOrder;
  String? userName;
  String? locationName;
  int? state;
  String? address;
  String? postal;
  String? tel;
  String? lastCallDate;
  String? pickUpDate;
  double? gps_lat;
  double? gps_lng;
  String? failReason;
  int? failCode;
  double? totalWaste;
  String? pickDetails;

  TodoCardModel(
      {this.pickOrder,
      this.userName,
      this.locationName,
      this.state,
      this.address,
      this.postal,
      this.tel,
      this.lastCallDate,
      this.pickUpDate,
      this.gps_lat,
      this.gps_lng,
      this.failReason,
      this.failCode,
      this.pickDetails,
      this.totalWaste});

  Map<String, dynamic> toMap() {
    return {
      'pick_id': this.pickOrder,
      'user_id': this.userName,
      'location_name': this.locationName,
      'pick_state': this.state,
      'location_address': this.address,
      'location_postal': this.postal,
      'location_tel': this.tel,
      'location_gps_lng': this.gps_lng,
      'location_gps_lat': this.gps_lat,
      'pick_fail_reason' : this.failReason,
      'pick_fail_code' : this.failCode,
      'pick_details' : this.pickDetails,
      'pick_total_waste' : this.totalWaste,
    };
  }

  TodoCardModel.fromJson(Map<String, dynamic> json) {
    pickOrder = json['pick_order'];
    userName = json['user_name'];
    locationName = json['location_name'];
    state = json['pick_state'];
    address = json['location_address'];
    postal = json['location_postal'];
    tel = json['location_tel'];
    gps_lat = json['location_gps_lat'];
    gps_lng = json['location_gps_long'];
    lastCallDate = json['last_call_date'];
    pickUpDate = json['pick_up_date'];
    failReason = json['pick_fail_reason'];
    failCode = json['pick_fail_code'];
    totalWaste = json['pick_total_waste'];
    pickDetails= json['pick_details'];
  }
}
