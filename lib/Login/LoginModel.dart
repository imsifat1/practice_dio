// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.status,
    required this.message,
    required this.user,
  });

  String status;
  String message;
  User user;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.mobileNo,
    required this.email,
    required this.address,
    required this.cityId,
    required this.image,
    required this.status,
    required this.apiToken,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String mobileNo;
  String email;
  dynamic address;
  dynamic cityId;
  dynamic image;
  int status;
  String apiToken;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        mobileNo: json["mobile_no"],
        email: json["email"],
        address: json["address"],
        cityId: json["city_id"],
        image: json["image"],
        status: json["status"],
        apiToken: json["api_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile_no": mobileNo,
        "email": email,
        "address": address,
        "city_id": cityId,
        "image": image,
        "status": status,
        "api_token": apiToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
