import 'package:delivery_project_app/consts/consts.dart';
import 'package:delivery_project_app/services/exceptions.dart';
import 'package:dio/dio.dart';
import '../../models/user_model.dart';

class ApiServices {
  Future register(email, password, name, phone) async {
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

        return UserModel(
            email: body['email'],
            name: body['name'],
            phone: body['phone'],
            id: body['id'],
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

  Future getUser(token) async {
    final dio = Dio();
    Response response;

    try {
      response = await dio.get(userEndpoint,
          options: Options(headers: {'authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        final body = response.data;
        print('Body: $body');

        return UserModel(
            email: body['user']['email'],
            name: body['user']['name'],
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
      return errorMessage;
    }
    return null;
  }

  Future otpLoginPost(email, password) async {
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };
    final dio = Dio();
    Response response;

    try {
      response = await dio.post(loginEndpoint, data: data);

      if (response.statusCode == 200) {
        final body = response.data;
        print('Body: $body');

        return body.toString();
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

  Future getUserFromOtp(otp, email) async {
    Map<String, dynamic> emailQuery = {
      'email': email,
    };
    final dio = Dio();
    Response response;

    try {
      response = await dio.put(otpEndpoint,
          data: {'otp': otp}, queryParameters: emailQuery);

      if (response.statusCode == 200) {
        final body = response.data;
        print('Body: $body');

        return UserModel(
          email: body['email'],
          //name: body['name'],
          phone: body['phone'],
          token: body['token'],
          id: body['id'],
          verified: body['verified'],
        );
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

  // Future<bool> logout() async {
  //   SharedPreferences storage = await SharedPreferences.getInstance();
  //   return true;
  // }
}
