import 'package:delivery_project_app/models/user_model.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  final ApiServices apiServices;

  UserBloc({required this.apiServices})
      : super(UserStateInitial(
          userToken: '',
          loginLoading: false,
          signupLoading: false,
          email: '',
          phone: '',
          id: '',
          name: '',
          verified: false,
          photoFile: XFile(''),
          photoUrl: '',
          loginObscureText: false,
          signupObscureText: false,
          balance: 0,
        )) {
    on<LoginObscureEvent>((event, emit) {
      emit(UserState(
          userToken: state.userToken,
          loginObscureText: state.loginObscureText == false ? true : false));
    });
    on<SignupObscureEvent>((event, emit) {
      emit(UserState(
          userToken: state.userToken,
          signupObscureText: state.signupObscureText == false ? true : false));
    });

    on<SignUpToVerificationEvent>((event, emit) async {
      emit(UserState(
        userToken: state.userToken,
        signupLoading: true,
      ));
      final user = await apiServices.register(
          event.email, event.password, event.name, event.phone);
      if (user is UserModel) {
        emit(VerificationState(
          verified: user.verified,
          email: user.email,
          userToken: user.token!,
          id: user.id,
          signupLoading: false,
        ));
      } else {
        if (user is! UserModel && user.toString().contains('User_email_key')) {
          emit(ErrorState(
            errorTitle: 'Email',
            error: 'Email already exists',
            userToken: state.userToken,
            loginLoading: false,
            signupLoading: false,
          ));
        } else {
          emit(ErrorState(
            errorTitle: 'Error',
            error: user.toString(),
            userToken: state.userToken,
            loginLoading: false,
            signupLoading: false,
          ));
        }
      }
    });

    on<RemoveUserToken>((event, emit) {
      emit(const UserState(
        userToken: '',
        loginLoading: false,
        signupLoading: false,
      ));
    });
    on<LogToOtpEvent>((event, emit) async {
      emit(UserState(
        userToken: state.userToken,
        loginLoading: true,
        email: event.email,
      ));

      final otpMessage =
          await apiServices.otpLoginPost(event.email, event.password);
      if (otpMessage.toString().contains('Check your email')) {
        emit(OtpState(
          email: event.email,
          userToken: state.userToken,
          loginLoading: false,
        ));
      } else {
        emit(ErrorState(
          errorTitle: 'Error',
          error: otpMessage.toString(),
          userToken: state.userToken,
          loginLoading: false,
          signupLoading: false,
        ));
      }
    });

    on<AddUserTokenEvent>((event, emit) {
      emit(UserState(
        userToken: event.userToken,
      ));
    });

    on<ClearPhotoFileEvent>((event, emit) {
      emit(UserState(userToken: state.userToken, photoUrl: ''));
    });

    on<GetUserEvent>((event, emit) async {
      await apiServices.getUser(state.userToken).then((user) {
        if (user is UserModel) {
          emit(UserState(
            userToken: state.userToken,
            name: user.name,
            email: user.email,
            phone: user.phone,
            id: user.id,
            verified: user.verified,
            photoUrl: user.photoUrl,
            balance: user.balance,
            address: user.address,
            lat: user.lat,
            long: user.long,
            likes: user.likes,
            dislikes: user.dislikes,
          ));
        } else {
          emit(ErrorState(
            error: user.toString(),
            userToken: state.userToken,
            errorTitle: 'No User',
            loginLoading: false,
            signupLoading: false,
          ));
        }
      });
    });
    on<AddPhotoUrlEvent>((event, emit) {
      UserState(
        userToken: state.userToken,
        photoUrl: event.photoUrl,
      );
    });

    on<ChangeProfilePictureEvent>((event, emit) {
      emit(UserState(
        userToken: state.userToken,
        photoFile: event.photoFile,
      ));
    });

    on<AddLocationEvent>((event, emit) {
      emit(UserState(
        userToken: state.userToken,
        lat: event.latitude,
        long: event.longitude,
        address: event.address,
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
