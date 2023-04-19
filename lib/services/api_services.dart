import 'package:delivery_project_app/services/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
      response = await dio.post(
          dotenv.env['SIGNUP_ENDPOINT'] ?? 'API_URL not found',
          data: data);

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
      response = await dio.get(
          dotenv.env['USER_ENDPOINT'] ?? 'API_URL not found',
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
      response = await dio.post(
          dotenv.env['LOGIN_ENDPOINT'] ?? 'API_URL not found',
          data: data);

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
      response = await dio.put(
          dotenv.env['OTP_ENDPOINT'] ?? 'API_URL not found',
          data: {'otp': otp},
          queryParameters: emailQuery);

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

  Future postProfilePic(filePath, filename, token) async {
    FormData data = FormData.fromMap({
      'key': 'photo',
      'image': await MultipartFile.fromFile(filePath, filename: filename),
    });
    print('data: ${data.toString()}');
    final dio = Dio();
    Response response;

    try {
      response = await dio.put(
        dotenv.env['PROFILE_PIC_ENDPOINT'] ?? 'API_URL not found',
        data: data,
        options: Options(headers: {'authorization': 'Bearer $token'}),
        //     onSendProgress: (sent, total) {
        //   print('$sent, $total');
        // }
      );

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

  // Future<bool> logout() async {
  //   SharedPreferences storage = await SharedPreferences.getInstance();
  //   return true;
  // }
}
