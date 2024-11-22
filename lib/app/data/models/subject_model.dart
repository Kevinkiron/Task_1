// To parse this JSON data, do
//
//     final subjectModel = subjectModelFromJson(jsonString);

import 'dart:convert';

List<SubjectModel> subjectModelFromJson(String str) => List<SubjectModel>.from(
    json.decode(str).map((x) => SubjectModel.fromJson(x)));

String subjectModelToJson(List<SubjectModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubjectModel {
  int? id;
  String? title;
  String? description;
  String? image;

  SubjectModel({
    this.id,
    this.title,
    this.description,
    this.image,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
      };
}
