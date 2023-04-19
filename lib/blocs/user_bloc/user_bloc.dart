import 'package:delivery_project_app/models/user_model.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  final ApiServices apiServices;
  final BuildContext context;
  UserBloc({required this.apiServices, required this.context})
      : super(UserStateInitial(
          userToken: '',
          loginLoading: false,
          signupLoading: false,
          otpLoading: false,
          email: '',
          phone: '',
          id: '',
          name: '',
          verified: false,
          photoFile: XFile(''),
        )) {
    on<SignUpToVerificationEvent>((event, emit) async {
      emit(UserState(
        userToken: state.userToken,
        loginLoading: false,
        signupLoading: true,
        otpLoading: false,
      ));
      final user = await apiServices.register(
          event.email, event.password, event.name, event.phone);
      if (user is UserModel) {
        emit(VerificationState(
          verified: user.verified,
          email: user.email,
          userToken: user.token!,
          id: user.id,
          loginLoading: false,
          signupLoading: false,
          otpLoading: false,
        ));
        print('User ID: ${user.id.toString()}');
      } else {
        if (user is! UserModel && user.toString().contains('User_email_key')) {
          emit(ErrorState(
            errorTitle: 'Email',
            error: 'Email already exists',
            userToken: state.userToken,
            loginLoading: false,
            signupLoading: false,
            otpLoading: state.otpLoading,
          ));
        } else {
          emit(ErrorState(
            errorTitle: 'Error',
            error: user.toString(),
            userToken: state.userToken,
            otpLoading: state.otpLoading,
            loginLoading: false,
            signupLoading: false,
          ));
        }
      }
    });
    on<VerificationToHomePageEvent>((event, emit) async {
      emit(UserState(
        userToken: state.userToken,
        loginLoading: false,
        signupLoading: false,
        otpLoading: false,
      ));
      final user = await apiServices.getUser(state.userToken);
      if (user!.verified == true) {
        emit(UserAddedState(
            user: user,
            userToken: state.userToken,
            loginLoading: false,
            signupLoading: false,
            otpLoading: false));
      } else {
        emit(ErrorState(
            error: 'Please verify your email',
            userToken: state.userToken,
            errorTitle: 'Not Verified',
            loginLoading: false,
            signupLoading: false,
            otpLoading: false));
      }
    });

    on<RemoveUserToken>((event, emit) {
      emit(const UserState(
        userToken: '',
        loginLoading: false,
        signupLoading: false,
        otpLoading: false,
      ));
    });
    on<LogToOtpEvent>((event, emit) async {
      emit(UserState(
        userToken: state.userToken,
        loginLoading: true,
        signupLoading: state.signupLoading,
        otpLoading: state.otpLoading,
        email: event.email,
      ));
      //await Future.delayed(const Duration(seconds: 1));
      final otpMessage =
          await apiServices.otpLoginPost(event.email, event.password);
      if (otpMessage.toString().contains('Check your email')) {
        emit(OtpState(
          email: event.email,
          userToken: state.userToken,
          loginLoading: false,
          signupLoading: false,
          otpLoading: false,
        ));
      } else {
        emit(ErrorState(
          errorTitle: 'Error',
          error: otpMessage.toString(),
          userToken: state.userToken,
          otpLoading: false,
          loginLoading: false,
          signupLoading: false,
        ));
      }
    });
    on<OtpToHomePageEvent>((event, emit) async {
      emit(UserState(
        userToken: 'please wait...',
        loginLoading: false,
        signupLoading: false,
        email: event.email,
        otpLoading: true,
      ));
      final user = await apiServices.getUserFromOtp(event.otp, event.email);
      if (user is UserModel) {
        emit(LoggedInUserState(
          userToken: user.token!,
          loginLoading: state.loginLoading,
          signupLoading: state.signupLoading,
          otpLoading: false,
        ));
      } else {
        emit(ErrorState(
          errorTitle: 'OTP',
          error: user.toString(),
          userToken: state.userToken,
          otpLoading: false,
          loginLoading: false,
          signupLoading: false,
        ));
      }
    });

    on<GetUserEvent>((event, emit) async {
      final user = await apiServices.getUser(state.userToken);
      if (user! is UserModel) {
        emit(UserState(
          userToken: state.userToken,
          loginLoading: false,
          signupLoading: false,
          otpLoading: false,
          name: user.name,
          email: user.email,
          phone: user.phone,
          id: user.id,
          verified: user.verified,
        ));
      } else {
        emit(ErrorState(
            error: user.toString(),
            userToken: state.userToken,
            errorTitle: 'No User',
            loginLoading: false,
            signupLoading: false,
            otpLoading: false));
      }
    });

    on<ChangeProfilePictureEvent>((event, emit) {
      emit(UserState(
        userToken: state.userToken,
        loginLoading: state.loginLoading,
        signupLoading: state.signupLoading,
        otpLoading: state.otpLoading,
        photoFile: event.photoFile,
      ));
    });
  }

  @override
  UserState fromJson(Map<String, dynamic> json) {
    return UserState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return state.toMap();
  }
}
