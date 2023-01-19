enum EndPoints {
  generateOtp("/generateOtp"),
  verifyOtp("/verifyOtp");

  final String value ;
  const EndPoints(this.value);
}