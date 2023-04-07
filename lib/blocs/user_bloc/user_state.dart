part of 'user_bloc.dart';

class UserState extends Equatable {
  final String userToken;
  const UserState({required this.userToken});

  @override
  List<Object> get props => [userToken];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userToken': userToken,
    };
  }

  factory UserState.fromMap(Map<String, dynamic> map) {
    return UserState(
      userToken: map['userToken'] ?? '',
    );
  }
}

class UserStateInitial extends UserState {
  const UserStateInitial({required String userToken})
      : super(userToken: userToken);
}

class AddingUserState extends UserState {
  const AddingUserState({required super.userToken});

  @override
  List<Object> get props => [];
}

class UserAddedState extends UserState {
  final UserModel user;
  const UserAddedState({required this.user, required super.userToken});

  @override
  List<Object> get props => [user];
}

class ErrorState extends UserState {
  final String error;

  const ErrorState({required this.error, required super.userToken});
  @override
  List<Object> get props => [error];
}
