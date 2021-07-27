// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    this.message,
    this.result = false,
    this.data = const {},
  });

  String? message;
  bool result;
  Map data;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        message: json["message"],
        result: (json["result"] ?? 0) == 1,
        data: json["data"] ?? {},
      );

  Map<String, dynamic> toJson() =>
      {"message": message, "result": result, "data": data};
}
