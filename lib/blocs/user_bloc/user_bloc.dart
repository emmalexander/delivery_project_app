import 'package:delivery_project_app/models/user_model.dart';
import 'package:delivery_project_app/services/exceptions.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  final ApiServices apiServices;
  final BuildContext context;
  UserBloc({required this.apiServices, required this.context})
      : super(const UserStateInitial(userToken: '')) {
    on<CreateUser>((event, emit) async {
      emit(AddingUserState(userToken: state.userToken));
      await Future.delayed(const Duration(seconds: 1));
      // try {
      final user = await apiServices.register(
          event.email, event.password, event.name, event.phone);
      if (user == UserModel) {
        emit(UserAddedState(user: user!, userToken: user.token));
        emit(UserState(userToken: user.userToken));
      } else if (user.toString().contains('User_email_key')) {
        emit(ErrorState(
            error: 'Email already exists', userToken: state.userToken));
        // showCustomDialog(context, 'Email', 'Email already exists',
        //     () => Navigator.of(context).pushNamed(VerificationPage.id));
        // emit(ErrorState(user));
      } else {
        emit(ErrorState(error: user.toString(), userToken: state.userToken));
      }
      // } on DioError catch (e) {
      //   final errorMessage = DioExceptions.fromDioError(e).toString();
      //
      //   emit(ErrorState(error: errorMessage, userToken: state.userToken));
      // }
    });

    on<AddUserToken>((event, emit) {
      emit(UserState(userToken: event.userToken));
    });
    on<RemoveUserToken>((event, emit) {
      emit(const UserState(userToken: ''));
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
