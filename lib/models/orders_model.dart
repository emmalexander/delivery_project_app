// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

OrdersModel ordersModelFromJson(String str) =>
    OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  List<Order>? orders;

  OrdersModel({
    this.orders,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        orders: json["orders"] == null
            ? []
            : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Order {
  String? id;
  String? restaurantId;
  String? userId;
  dynamic riderId;
  String? status;
  int? total;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic rider;

  Order({
    this.id,
    this.restaurantId,
    this.userId,
    this.riderId,
    this.status,
    this.total,
    this.createdAt,
    this.updatedAt,
    this.rider,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        restaurantId: json["restaurantId"],
        userId: json["userId"],
        riderId: json["riderId"],
        status: json["status"],
        total: json["total"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        rider: json["rider"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "restaurantId": restaurantId,
        "userId": userId,
        "riderId": riderId,
        "status": status,
        "total": total,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "rider": rider,
      };
}
