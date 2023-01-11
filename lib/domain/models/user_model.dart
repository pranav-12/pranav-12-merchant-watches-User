class UserModel {
  final FieldsForUserModel newUser;

  UserModel({required this.newUser});
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(newUser: json["newUser"]);

  Map<String, dynamic> toJson() => {"newUser": newUser};
}

class FieldsForUserModel {
  String? fullname;
  String? email;
  String? password;

  FieldsForUserModel.create({
    required this.email,
    required this.fullname,
    required this.password,
  });

  FieldsForUserModel({
    this.fullname,
    this.email,
    this.password,
  });

  factory FieldsForUserModel.fromJson(Map<String, dynamic> json) =>
      FieldsForUserModel(
        fullname: json["fullname"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "email": email,
        "password": password,
      };
}