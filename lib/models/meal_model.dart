// To parse this JSON data, do
//
//     final mealModel = mealModelFromJson(jsonString);

import 'dart:convert';

MealModel mealModelFromJson(String str) => MealModel.fromJson(json.decode(str));

String mealModelToJson(MealModel data) => json.encode(data.toJson());

class MealModel {
  String? id;
  String? name;
  dynamic rating;
  bool? verified;
  String? loadingImage;
  bool? available;
  String? slug;
  String? photo;
  dynamic ratingAmount;
  List<Menu>? menu;
  List<dynamic>? orders;
  Location? location;
  List<dynamic>? category;

  MealModel({
    this.id,
    this.name,
    this.rating,
    this.verified,
    this.loadingImage,
    this.available,
    this.slug,
    this.photo,
    this.ratingAmount,
    this.menu,
    this.orders,
    this.location,
    this.category,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
        id: json["id"],
        name: json["name"],
        rating: json["rating"],
        verified: json["verified"],
        loadingImage: json["loadingImage"],
        available: json["available"],
        slug: json["slug"],
        photo: json["photo"],
        ratingAmount: json["ratingAmount"],
        menu: json["menu"] == null
            ? []
            : List<Menu>.from(json["menu"]!.map((x) => Menu.fromJson(x))),
        orders: json["orders"] == null
            ? []
            : List<dynamic>.from(json["orders"]!.map((x) => x)),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        category: json["category"] == null
            ? []
            : List<dynamic>.from(json["category"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rating": rating,
        "verified": verified,
        "loadingImage": loadingImage,
        "available": available,
        "slug": slug,
        "photo": photo,
        "ratingAmount": ratingAmount,
        "menu": menu == null
            ? []
            : List<dynamic>.from(menu!.map((x) => x.toJson())),
        "orders":
            orders == null ? [] : List<dynamic>.from(orders!.map((x) => x)),
        "location": location?.toJson(),
        "category":
            category == null ? [] : List<dynamic>.from(category!.map((x) => x)),
      };
}

class Location {
  String? latitude;
  String? longitude;

  Location({
    this.latitude,
    this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Menu {
  String? id;
  String? name;
  int? price;
  bool? available;
  dynamic loadingImage;
  String? photo;
  String? restaurantId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Menu({
    this.id,
    this.name,
    this.price,
    this.available,
    this.loadingImage,
    this.photo,
    this.restaurantId,
    this.createdAt,
    this.updatedAt,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        available: json["available"],
        loadingImage: json["loadingImage"],
        photo: json["photo"],
        restaurantId: json["restaurantId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "available": available,
        "loadingImage": loadingImage,
        "photo": photo,
        "restaurantId": restaurantId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
