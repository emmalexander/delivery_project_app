class UserModel {
  final String? email;
  final String? phone;
  final String? name;
  final String? token;
  final bool? verified;
  final String? id;
  final int? otp;
  final String? photoUrl;
  final Map<String, dynamic>? location;
  final String? address;
  final String? lat;
  final String? long;

  final int? balance;
  final List? orders;

  UserModel({
    this.email,
    this.token,
    this.id,
    this.otp,
    this.phone,
    this.name,
    this.verified,
    this.photoUrl,
    this.balance,
    this.orders,
    this.address,
    this.lat,
    this.long,
    this.location,
  });
}
