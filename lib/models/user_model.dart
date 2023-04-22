class UserModel {
  final String? email;
  final String? phone;
  final String? name;
  final String? token;
  final bool? verified;
  final String? id;
  final int? otp;
  final String? photoUrl;

  UserModel({
    this.email,
    this.token,
    this.id,
    this.otp,
    this.phone,
    this.name,
    this.verified,
    this.photoUrl,
  });
}
