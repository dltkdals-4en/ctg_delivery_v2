class WasteLocationModel {
  int? locationId;
  String? locAdminUserid;
  String? locationName;
  String? locationPostal;
  String? locationAddress;
  double? locationGPS_Lat;
  double? locationGPS_Long;
  String? docId;
  String? locationTel;
  int? callStatue;
  DateTime? lastCallDate;
  DateTime? delayPickDate;

  WasteLocationModel(
      {this.locationId,
      this.locAdminUserid,
      this.locationName,
      this.locationPostal,
      this.locationAddress,
      this.locationGPS_Lat,
      this.locationGPS_Long,
      this.locationTel,
      this.callStatue,
      this.lastCallDate,
      this.delayPickDate,
      this.docId});

  Map<String, dynamic> toMap() {
    return {
      'location_id': this.locationId,
      'loc_admin_userid': this.locAdminUserid,
      'location_name': this.locationName,
      'location_postal': this.locationPostal,
      'location_address': this.locationAddress,
      'location_gps_lat': this.locationGPS_Lat,
      'location_gps_long': this.locationGPS_Long,
      'location_tel': this.locationTel,
      'call_statue': this.callStatue,
      'last_call_date': this.lastCallDate,
      'delay_pick_date': this.delayPickDate
    };
  }

  WasteLocationModel.fromJson(Map<String, dynamic> json, String docId)
      : locationId = json['userid'],
        locAdminUserid = json['loc_admin_userid'],
        locationName = json['location_name'],
        locationPostal = json['location_postal'],
        locationAddress = json['location_address'],
        locationGPS_Lat = json['location_gps_lat'],
        locationGPS_Long = json['location_gps_long'],
        locationTel = json['location_tel'],
        callStatue = json['call_statue'],
        lastCallDate = json['last_call_date'].toDate(),
        delayPickDate = json['delay_pick_date'].toDate(),
        docId = docId;
}

final wastelocationmodel = [
  WasteLocationModel(
    locationId: 1,
    locAdminUserid: '7',
    locationName: '포이엔',
    locationTel: '023912576',
    locationPostal: 'https://picsum.photos/id/1/200/200',
    locationAddress: '서울특별시 성동구 성수2가3동 279-28',
    locationGPS_Lat: 37.5450340188235,
    locationGPS_Long: 127.06390016463332,
    callStatue: 0,
    lastCallDate: DateTime.now(),
    delayPickDate: DateTime.now(),
  ),
  WasteLocationModel(
    locationId: 2,
    locAdminUserid: '7',
    locationName: '스타벅스 성수낙낙',
    locationTel: '01099544115',
    locationPostal: 'https://picsum.photos/id/444/200/200',
    locationAddress: '101-107호 성수 SKV1 2동 1층 KR 서울특별시 성동구 성수동2가 281-18번지',
    locationGPS_Lat: 37.54729300680503,
    locationGPS_Long: 127.06633597463622,
    callStatue: 0,
    lastCallDate: DateTime.now(),
    delayPickDate: DateTime.now(),
  ),
  WasteLocationModel(
    locationId: 3,
    locAdminUserid: '7',
    locationName: '카페코튼',
    locationTel: '01099544115',
    locationPostal: 'https://picsum.photos/id/133/200/200',
    locationAddress: '서울특별시 성동구 성수동2가 279-39',
    locationGPS_Lat: 37.54509693000572,
    locationGPS_Long: 127.06516755180469,
    callStatue: 0,
    lastCallDate: DateTime.now(),
    delayPickDate: DateTime.now(),
  ),
  WasteLocationModel(
    locationId: 4,
    locAdminUserid: '7',
    locationName: '카페마빈',
    locationTel: '01099544115',
    locationPostal: 'https://picsum.photos/id/89/200/200',
    locationAddress: '화양동 42-16번지 화양동 2층 광진구 서울특별시 KR',
    locationGPS_Lat: 37.54280010873582,
    locationGPS_Long: 127.06465256768635,
    callStatue: 0,
    lastCallDate: DateTime.now(),
    delayPickDate: DateTime.now(),
  ),
  WasteLocationModel(
    locationId: 5,
    locAdminUserid: '7',
    locationName: '카페봇봇봇',
    locationTel: '01099544115',
    locationPostal: 'https://picsum.photos/id/24/200/200',
    locationAddress: '서울특별시 성동구 성수2가3동 아차산로9길 8',
    locationGPS_Lat: 37.544807704554394,
    locationGPS_Long: 127.05830109687848,
    callStatue: 0,
    lastCallDate: DateTime.now(),
    delayPickDate: DateTime.now(),
  ),
  WasteLocationModel(
    locationId: 6,
    locAdminUserid: '7',
    locationName: '컨딩커피',
    locationTel: '01099544115',
    locationPostal: 'https://picsum.photos/id/8/200/200',
    locationAddress: '서울특별시 광진구 화양동 아차산로21길 64',
    locationGPS_Lat: 37.54479919790651,
    locationGPS_Long: 127.0664013679064,
    callStatue: 0,
    lastCallDate: DateTime.now(),
    delayPickDate: DateTime.now(),
  ),
];
