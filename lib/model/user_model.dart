class UserModel {
  int? userId;
  String? userName;
  String? userPhone;
  String? authenticationNumber;
  String? lastLoginDate;

  UserModel(
      {this.userId,
        this.userName,
      this.userPhone,
      this.authenticationNumber,
      this.lastLoginDate});

  UserModel.fromJson(Map<String, dynamic> json) {
    this.userId = json['user_id'];
    this.userName = json['user_name'];
    this.authenticationNumber = json['authentication_number'];
    this.userPhone = json['user_phone'];
    this.lastLoginDate = json['last_login_date'];
  }
}
