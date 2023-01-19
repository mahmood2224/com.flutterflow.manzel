class GenerateOtpResponse {
  GenerateOtpResponse({
      this.success, 
      this.message, 
      this.key,});

  GenerateOtpResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    key = json['key'];
  }
  String? success;
  String? message;
  String? key;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['key'] = key;
    return map;
  }

}