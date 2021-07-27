// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    this.dob,
    this.email,
    this.gender,
    this.height,
    this.id,
    this.name,
    this.profilepict,
    this.weight,
  });

  String? dob;
  String? email;
  String? gender;
  double? height;
  int? id;
  String? name;
  String? profilepict;
  double? weight;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        dob: json["DOB"],
        email: json["email"],
        gender: json["gender"],
        height: json["height"],
        id: json["id"],
        name: json["name"],
        profilepict: json["profilepict"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "DOB": dob,
        "email": email,
        "gender": gender,
        "height": height,
        "id": id,
        "name": name,
        "profilepict": profilepict,
        "weight": weight,
      };
}
