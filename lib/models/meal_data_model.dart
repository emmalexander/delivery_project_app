// To parse this JSON data, do
//
//     final mealDataModel = mealDataModelFromJson(jsonString);

import 'dart:convert';

List<MealDataModel> mealDataModelFromJson(String str) =>
    List<MealDataModel>.from(
        json.decode(str).map((x) => MealDataModel.fromJson(x)));

String mealDataModelToJson(List<MealDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MealDataModel {
  int? quantity;
  String? id;

  MealDataModel({
    this.quantity,
    this.id,
  });

  factory MealDataModel.fromJson(Map<String, dynamic> json) => MealDataModel(
        quantity: json["quantity"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "id": id,
      };
}
