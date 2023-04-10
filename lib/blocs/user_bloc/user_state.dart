part of 'user_bloc.dart';

class UserState extends Equatable {
  final String userToken;
  final bool loginLoading;
  final bool signupLoading;
  final bool otpLoading;
  final String? email;
  final String? phone;
  final String? name;
  final String? id;
  final bool? verified;

  const UserState({
    required this.userToken,
    required this.loginLoading,
    required this.signupLoading,
    required this.otpLoading,
    this.email,
    this.phone,
    this.name,
    this.id,
    this.verified,
  });

  @override
  List<Object> get props => [
        userToken,
        loginLoading,
        signupLoading,
        otpLoading,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userToken': userToken,
    };
  }

  factory UserState.fromMap(Map<String, dynamic> map) {
    return UserState(
      userToken: map['userToken'] ?? '',
      loginLoading: map['loginLoading'] ?? false,
      signupLoading: map['signupLoading'] ?? false,
      otpLoading: map['otpLoading'] ?? false,
    );
  }
}

class UserStateInitial extends UserState {
  const UserStateInitial({
    required String userToken,
    required bool loginLoading,
    required bool signupLoading,
    required bool otpLoading,
    required String email,
    required String phone,
    required String name,
    required String id,
    required bool verified,
  }) : super(
          userToken: userToken,
          loginLoading: loginLoading,
          signupLoading: signupLoading,
          otpLoading: otpLoading,
          email: email,
          phone: phone,
          name: name,
          id: id,
          verified: verified,
        );
}

class AddingUserState extends UserState {
  const AddingUserState({
    required super.userToken,
    required super.loginLoading,
    required super.signupLoading,
    required super.otpLoading,
  });

  @override
  List<Object> get props => [];
}

class UserAddedState extends UserState {
  final UserModel user;
  const UserAddedState({
    required this.user,
    required super.userToken,
    required super.loginLoading,
    required super.signupLoading,
    required super.otpLoading,
  });

  @override
  List<Object> get props => [user];
}

class VerificationState extends UserState {
  //final String email;
  const VerificationState({
    required super.verified,
    required super.email,
    required super.userToken,
    required super.loginLoading,
    required super.signupLoading,
    required super.otpLoading,
  });

  @override
  List<Object> get props => [];
}

class OtpState extends UserState {
  // final String otp;
  //final String email;
  const OtpState({
    //required this.otp,
    required super.email,
    required super.userToken,
    required super.loginLoading,
    required super.signupLoading,
    required super.otpLoading,
  });

  @override
  List<Object> get props => [];
}

class LoggedInUserState extends UserState {
  const LoggedInUserState({
    required super.userToken,
    required super.loginLoading,
    required super.signupLoading,
    required super.otpLoading,
  });

  @override
  List<Object> get props => [];
}

class LoggingInState extends UserState {
  const LoggingInState({
    required super.userToken,
    required super.loginLoading,
    required super.signupLoading,
    required super.otpLoading,
  });

  @override
  List<Object> get props => [];
}

class ErrorState extends UserState {
  final String errorTitle;
  final String error;

  const ErrorState({
    required this.error,
    required this.errorTitle,
    required super.userToken,
    required super.loginLoading,
    required super.signupLoading,
    required super.otpLoading,
  });
  @override
  List<Object> get props => [error, errorTitle];
}
