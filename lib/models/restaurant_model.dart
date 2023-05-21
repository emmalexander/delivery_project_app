class RestaurantModel {
  String? id;
  String? name;
  bool? verified;
  String? loadingImage;
  bool? available;
  String? slug;
  String? photoUrl;
  Map<String, dynamic>? location;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.verified,
    this.loadingImage,
    required this.available,
    this.slug,
    required this.photoUrl,
    required this.location,
  });
  RestaurantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    verified = json['verified'] ?? false;
    loadingImage = json['loadingImage'] ?? '';
    available = json['available'] ?? false;
    slug = json['slug'] ?? '';
    photoUrl = json['photo'] ?? '';
    location = json['location'] ?? {};
  }

  static List<RestaurantModel> restaurantsFromSnapshot(
      List restaurantSnapshot) {
    return restaurantSnapshot.map((json) {
      return RestaurantModel.fromJson(json);
    }).toList();
  }
}
