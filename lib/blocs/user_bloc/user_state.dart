part of 'user_bloc.dart';

class UserState extends Equatable {
  final String userToken;
  final bool? loginLoading;
  final bool? signupLoading;

  final String? email;
  final String? phone;
  final String? name;
  final String? id;
  final String? photoUrl;
  final bool? verified;
  final XFile? photoFile;

  const UserState({
    required this.userToken,
    this.loginLoading,
    this.signupLoading,
    this.email,
    this.phone,
    this.name,
    this.id,
    this.photoUrl,
    this.verified,
    this.photoFile,
  });

  @override
  List<Object> get props => [
        userToken,
        loginLoading ?? false,
        signupLoading ?? false,
        photoFile ?? XFile('')
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
    );
  }
}

class UserStateInitial extends UserState {
  const UserStateInitial({
    required String userToken,
    required bool loginLoading,
    required bool signupLoading,
    required String email,
    required String phone,
    required String name,
    required String id,
    required String photoUrl,
    required bool verified,
    XFile? photoFile,
  }) : super(
            userToken: userToken,
            loginLoading: loginLoading,
            signupLoading: signupLoading,
            email: email,
            phone: phone,
            name: name,
            id: id,
            photoUrl: photoUrl,
            verified: verified,
            photoFile: photoFile);
}

class UserAddedState extends UserState {
  final UserModel user;
  const UserAddedState({
    required this.user,
    required super.userToken,
    required super.loginLoading,
    required super.signupLoading,
  });

  @override
  List<Object> get props => [user];
}

class VerificationState extends UserState {
  //final String email;
  const VerificationState({
    required super.verified,
    required super.email,
    required super.id,
    required super.userToken,
    required super.signupLoading,
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
    super.loginLoading,
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
  });
  @override
  List<Object> get props => [error, errorTitle];
}
