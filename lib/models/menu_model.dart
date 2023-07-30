import 'package:delivery_project_app/models/meal_model.dart';

class MenuModel {
  final String? restaurantId;
  final int? quantity;
  final Menu menu;

  const MenuModel({this.restaurantId, this.quantity, required this.menu});

  // factory MenuModel.fromJson(Map<String, dynamic> json) =>MenuModel(
  //   restaurantId: json['restaurantId'],
  //   quantity: json['quantity'],
  //   menu:
  // );
}
