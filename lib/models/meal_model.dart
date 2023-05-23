class MealModel {
  String? id;
  String? name;
  int? quantity;
  double? price;
  //bool? verified;
  String? loadingImage;
  bool? available;
  //String? slug;
  String? photoUrl;
  //Map<String, dynamic>? location;

  MealModel({
    required this.id,
    required this.name,
    //required this.verified,
    this.loadingImage,
    required this.available,
    //this.slug,
    required this.photoUrl,
    this.quantity = 0,
    required this.price,
    //required this.location,
  });
  MealModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    //verified = json['verified'] ?? false;
    loadingImage = json['loadingImage'] ?? '';
    available = json['available'] ?? false;
    //slug = json['slug'] ?? '';
    photoUrl = json['photo'] ?? '';
    //location = json['location'] ?? {};
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'photoUrl': photoUrl,
      'available': available,
      'loadingImage': loadingImage,
    };
  }

  static List<MealModel> mealsFromSnapshot(List mealSnapshot) {
    return mealSnapshot.map((json) {
      return MealModel.fromJson(json);
    }).toList();
  }
}
