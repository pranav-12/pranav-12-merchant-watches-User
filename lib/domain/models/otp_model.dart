class OTPModel {
  final String email;
  final String otp;

  OTPModel({required this.email, required this.otp});
  factory OTPModel.fromJson(Map<String, dynamic> json) =>
      OTPModel(email: json["email"], otp: json["otp"]);

  Map<String, dynamic> toJson() => {"email": email, "otp": otp};
}
