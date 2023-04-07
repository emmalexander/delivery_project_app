class UserModel {
  final String email;
  final String phone;
  final String? name;
  final String? token;
  final bool verified;
  final String? id;
  final int? otp;

  UserModel({
    required this.email,
    this.token,
    this.id,
    this.otp,
    required this.phone,
    this.name,
    required this.verified,
  });
}
