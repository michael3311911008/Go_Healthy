// To parse this JSON data, do
//
//     final historyBmi = historyBmiFromJson(jsonString);

import 'dart:convert';

import 'dart:io';

List<HistoryBmi> historyBmiFromJson(String str) =>
    List<HistoryBmi>.from(json.decode(str).map((x) => HistoryBmi.fromJson(x)));

String historyBmiToJson(List<HistoryBmi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryBmi {
  HistoryBmi({
    this.bmi = 0,
    this.date,
    this.id = 0,
  });

  double bmi;
  String? date;
  int id;
  String get className => _classify();
  String _classify() {
    if (bmi < 18.5) {
      return "underweight";
    } else if (bmi < 25) {
      return "normal";
    } else if (bmi < 30) {
      return "overweight";
    } else {
      return "obese";
    }
  }

  DateTime get dateAsDateTime => HttpDate.parse(date!);
  factory HistoryBmi.fromJson(Map<String, dynamic> json) => HistoryBmi(
        bmi: json["bmi"].toDouble(),
        date: json["date"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "bmi": bmi,
        "date": date,
        "id": id,
      };
}
