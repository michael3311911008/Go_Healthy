// To parse this JSON data, do
//
//     final exercise = exerciseFromJson(jsonString);

import 'dart:convert';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

List<Exercise> exerciseFromJson(String str) =>
    List<Exercise>.from(json.decode(str).map((x) => Exercise.fromJson(x)));

String exerciseToJson(List<Exercise> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Exercise {
  Exercise({
    this.description,
    this.difficulty,
    this.idExercise,
    this.title,
    this.type,
    this.videoLink,
  });
  String get videoId => videoLink!.contains("youtu.be")
      ? videoLink!.split("/").last
      : videoLink!.split('=')[1];
  String get thumbnail => _getThumbnail(this.videoLink!);
  String _getThumbnail(String url) {
    String quality = ThumbnailQuality.standard;
    return 'https://i3.ytimg.com/vi/$videoId/$quality.jpg';
  }

  String? description;
  String? difficulty;
  int? idExercise;
  String? title;
  int? type;
  String? videoLink;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        description: json["description"],
        difficulty: json["difficulty"],
        idExercise: json["id_exercise"],
        title: json["title"],
        type: json["type"],
        videoLink: json["video_link"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "difficulty": difficulty,
        "id_exercise": idExercise,
        "title": title,
        "type": type,
        "video_link": videoLink,
      };
}
