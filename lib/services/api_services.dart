import 'package:delivery_project_app/consts/consts.dart';
import 'package:delivery_project_app/services/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';

class ApiServices {
  Future register(email, password, name, phone) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    };
    final dio = Dio();
    Response response;

    try {
      response = await dio.post(signUpEndpoint, data: data);

      if (response.statusCode == 200) {
        final body = response.data;
        print('Body: $body');

        storage.setString('TOKEN', body['token']);
        return UserModel(
            email: email,
            name: name,
            phone: phone,
            token: body['token'],
            verified: body['verified']);
      } else {
        print(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('Error Message: $errorMessage');
      return errorMessage;
    }
    return null;
  }

  Future<UserModel?> getUser(token) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    //final token = storage.getString('TOKEN');
    //final email = storage.getString('EMAIL');
    final dio = Dio();
    Response response;

    try {
      response = await dio.get(signInEndpoint,
          options: Options(headers: {'authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        final body = response.data;
        print('Body: $body');

        return UserModel(
            email: body['user']['email'],
            //name: body['user']['name'],
            phone: body['user']['phone'],
            // token: body['user']['token'],
            id: body['user']['id'],
            otp: body['user']['OTP'],
            verified: body['user']['verified']);
      } else {
        print(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('Error Message: $errorMessage');
    }
    return null;
  }

  // Future<bool> logout() async {
  //   SharedPreferences storage = await SharedPreferences.getInstance();
  //   return true;
  // }
}
