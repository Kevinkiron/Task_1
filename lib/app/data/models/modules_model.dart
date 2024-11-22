// To parse this JSON data, do
//
//     final modulesModel = modulesModelFromJson(jsonString);

import 'dart:convert';

List<ModulesModel> modulesModelFromJson(String str) => List<ModulesModel>.from(
    json.decode(str).map((x) => ModulesModel.fromJson(x)));

String modulesModelToJson(List<ModulesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModulesModel {
  int? id;
  String? title;
  String? description;

  ModulesModel({
    this.id,
    this.title,
    this.description,
  });

  factory ModulesModel.fromJson(Map<String, dynamic> json) => ModulesModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
      };
}
