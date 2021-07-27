// To parse this JSON data, do
//
//     final responseUpdatePp = responseUpdatePpFromJson(jsonString);

import 'dart:convert';

ResponseUpdatePp responseUpdatePpFromJson(String str) =>
    ResponseUpdatePp.fromJson(json.decode(str));

String responseUpdatePpToJson(ResponseUpdatePp data) =>
    json.encode(data.toJson());

class ResponseUpdatePp {
  ResponseUpdatePp({
    this.data,
    this.message,
    this.result = false,
  });

  String? data;
  String? message;
  bool result = false;

  factory ResponseUpdatePp.fromJson(Map<String, dynamic> json) =>
      ResponseUpdatePp(
        data: json["data"],
        message: json["message"],
        result: json["result"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "message": message,
        "result": result,
      };
}
