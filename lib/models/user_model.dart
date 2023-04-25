class UserModel {
  final String? email;
  final String? phone;
  final String? name;
  final String? token;
  final bool? verified;
  final String? id;
  final int? otp;
  final String? photoUrl;

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
  });
}
