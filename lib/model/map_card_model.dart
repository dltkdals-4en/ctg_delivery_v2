import 'package:cloud_firestore/cloud_firestore.dart';

class MapCardModel {
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

  MapCardModel(
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
        this.gps_lng});

  Map<String, dynamic> toMap() {
    return {
      'pick_id': this.pickOrder,
      'user_id': this.userName,
      'location_name': this.locationName,
      'state': this.state,
      'address': this.address,
      'postal': this.postal,
      'tel': this.tel,
      'gps_lng': this.gps_lng,
      'gps_lat': this.gps_lat
    };
  }

  MapCardModel.fromJson(Map<String, dynamic> json) {
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
  }
}
