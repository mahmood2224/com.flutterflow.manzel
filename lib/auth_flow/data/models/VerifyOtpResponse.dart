class VerifyOtpResponse {
  VerifyOtpResponse({
      this.success, 
      this.message, 
      this.tokenKey,});

  VerifyOtpResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    tokenKey = json['tokenKey'];
  }
  String? success;
  String? message;
  String? tokenKey;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['tokenKey'] = tokenKey;
    return map;
  }

}