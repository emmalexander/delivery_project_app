part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpToVerificationEvent extends UserEvent {
  final String name;
  final String email;
  final String phone;
  final String password;

  SignUpToVerificationEvent(
      {required this.name,
      required this.email,
      required this.phone,
      required this.password});

  @override
  List<Object> get props => [name, email, phone, password];
}

class VerificationToHomePageEvent extends UserEvent {}

class GetUserEvent extends UserEvent {}

class RemoveUserToken extends UserEvent {}

class LogToOtpEvent extends UserEvent {
  final String email;
  final String password;
  LogToOtpEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class OtpToHomePageEvent extends UserEvent {
  final String email;
  final String otp;
  OtpToHomePageEvent({required this.email, required this.otp});

  @override
  List<Object> get props => [email, otp];
}
