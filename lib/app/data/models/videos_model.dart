// To parse this JSON data, do
//
//     final videosModel = videosModelFromJson(jsonString);

import 'dart:convert';

List<VideosModel> videosModelFromJson(String str) => List<VideosModel>.from(
    json.decode(str).map((x) => VideosModel.fromJson(x)));

String videosModelToJson(List<VideosModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VideosModel {
  int? id;
  String? title;
  String? description;
  String? videoType;
  String? videoUrl;

  VideosModel({
    this.id,
    this.title,
    this.description,
    this.videoType,
    this.videoUrl,
  });

  factory VideosModel.fromJson(Map<String, dynamic> json) => VideosModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        videoType: json["video_type"],
        videoUrl: json["video_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "video_type": videoType,
        "video_url": videoUrl,
      };
}
