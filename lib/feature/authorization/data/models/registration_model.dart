class RegistrationModel {
  final String? username;
  final String? email;
  final String? password;
  final Profile? profile;
  final String? repeatPassword;
  final Map<String, String>? tokens;

  RegistrationModel({
    this.username,
    this.email,
    this.password,
    this.profile,
    this.repeatPassword,
    this.tokens,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      RegistrationModel(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        profile:
            json["profile"] != null ? Profile.fromJson(json["profile"]) : null,
        repeatPassword: json["repeatPassword"],
        tokens: json["tokens"] != null
            ? Map<String, String>.from(json["tokens"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "repeatPassword": repeatPassword,
        "profile": profile?.toJson(),
      };
}

class Profile {
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final String? phoneNumber;
  final int? region;
  final int? cityOrDistrict;
  final String? positionAtWork;
  final String? workAddress;
  final String? workName;
  final String? image;
  final String? qr_code;

  Profile({
    this.firstName,
    this.lastName,
    this.middleName,
    this.phoneNumber,
    this.region,
    this.cityOrDistrict,
    this.positionAtWork,
    this.workAddress,
    this.workName,
    this.image,
    this.qr_code,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        firstName: json["first_name"],
        lastName: json["last_name"],
        middleName: json["middle_name"],
        phoneNumber: json["phone_number"],
        region: json["region"],
        cityOrDistrict: json["city_or_district"],
        positionAtWork: json["position_at_work"],
        workAddress: json["work_address"],
        workName: json["work_name"],
        image: json["image"],
        qr_code: json["qr_code"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "middle_name": middleName,
        "phone_number": phoneNumber,
        "region": region,
        "city_or_district": cityOrDistrict,
        "position_at_work": positionAtWork,
        "work_address": workAddress,
        "work_name": workName,
        "image": image,
        "qr_code": qr_code,
      };
}
