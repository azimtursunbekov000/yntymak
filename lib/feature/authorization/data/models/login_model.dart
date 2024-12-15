import 'package:yntymak/feature/authorization/data/models/registration_model.dart';

class LoginModel {
  final int id;
  final String username;
  final String email;
  final String password;
  final Map<String, String> tokens;
  final Profile? profile;

  LoginModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.tokens,
    this.profile,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['user']['id'],
      username: json['user']['username'] ?? '',
      email: json['user']['email'] ?? '',
      password: '',
      tokens: {
        'refresh': json['tokens']['refresh'] ?? '',
        'access': json['tokens']['access'] ?? '',
      },
      profile: json['user']['profile'] != null
          ? Profile.fromJson(json['user']['profile'])
          : null,
    );
  }

  LoginModel copyWith({
    int? id,
    String? userName,
    String? email,
    String? password,
    Map<String, String>? tokens,
    Profile? profile,
  }) {
    return LoginModel(
      id: id ?? this.id,
      username: userName ?? username,
      email: email ?? this.email,
      password: password ?? this.password,
      tokens: tokens ?? this.tokens,
      profile: profile ?? this.profile,
    );
  }
}
