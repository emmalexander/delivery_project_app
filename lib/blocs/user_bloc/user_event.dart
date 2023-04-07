part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateUser extends UserEvent {
  final String name;
  final String email;
  final String phone;
  final String password;

  CreateUser(
      {required this.name,
      required this.email,
      required this.phone,
      required this.password});

  @override
  List<Object> get props => [name, email, phone, password];
}

class AddUserToken extends UserEvent {
  final String userToken;
  AddUserToken({required this.userToken});

  @override
  List<Object> get props => [userToken];
}

class RemoveUserToken extends UserEvent {
  final String userToken;
  RemoveUserToken({required this.userToken});

  @override
  List<Object> get props => [userToken];
}
