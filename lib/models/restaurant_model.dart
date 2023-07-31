// To parse this JSON data, do
//
//     final restaurantModel = restaurantModelFromJson(jsonString);

import 'dart:convert';

RestaurantModel restaurantModelFromJson(String str) =>
    RestaurantModel.fromJson(json.decode(str));

String restaurantModelToJson(RestaurantModel data) =>
    json.encode(data.toJson());

class RestaurantModel {
  List<Restaurant>? restaurant;

  RestaurantModel({
    this.restaurant,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        restaurant: json["restaurant"] == null
            ? []
            : List<Restaurant>.from(
                json["restaurant"]!.map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "restaurant": restaurant == null
            ? []
            : List<dynamic>.from(restaurant!.map((x) => x.toJson())),
      };
}

class Restaurant {
  String? id;
  String? name;
  bool? verified;
  String? loadingImage;
  bool? available;
  String? slug;
  String? photo;
  String? rating;
  String? ratingAmount;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? locationId;
  RestaurantAdminId? restaurantAdminId;
  Location? location;
  List<Menu>? menu;

  Restaurant({
    this.id,
    this.name,
    this.verified,
    this.loadingImage,
    this.available,
    this.slug,
    this.photo,
    this.rating,
    this.ratingAmount,
    this.createdAt,
    this.updatedAt,
    this.locationId,
    this.restaurantAdminId,
    this.location,
    this.menu,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        verified: json["verified"],
        loadingImage: json["loadingImage"],
        available: json["available"],
        slug: json["slug"],
        photo: json["photo"],
        rating: json["rating"],
        ratingAmount: json["ratingAmount"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        locationId: json["locationId"],
        restaurantAdminId:
            restaurantAdminIdValues.map[json["restaurantAdminId"]]!,
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        menu: json["menu"] == null
            ? []
            : List<Menu>.from(json["menu"]!.map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "verified": verified,
        "loadingImage": loadingImage,
        "available": available,
        "slug": slug,
        "photo": photo,
        "rating": rating,
        "ratingAmount": ratingAmount,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "locationId": locationId,
        "restaurantAdminId": restaurantAdminIdValues.reverse[restaurantAdminId],
        "location": location?.toJson(),
        "menu": menu == null
            ? []
            : List<dynamic>.from(menu!.map((x) => x.toJson())),
      };
}

class Location {
  String? id;
  String? latitude;
  String? longitude;
  String? address;
  DateTime? createdAt;

  Location({
    this.id,
    this.latitude,
    this.longitude,
    this.address,
    this.createdAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        address: json["address"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "createdAt": createdAt?.toIso8601String(),
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

enum RestaurantAdminId { THE_645_A569983029_D2726_CDC152 }

final restaurantAdminIdValues = EnumValues({
  "645a569983029d2726cdc152": RestaurantAdminId.THE_645_A569983029_D2726_CDC152
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
