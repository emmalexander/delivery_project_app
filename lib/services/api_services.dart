import 'package:delivery_project_app/models/meal_model.dart';
import 'package:delivery_project_app/models/restaurant_model.dart';
import 'package:delivery_project_app/services/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/user_model.dart';
import 'package:http_parser/http_parser.dart';

class ApiServices {
  final _dio = Dio();
  Future register(email, password, name, phone) async {
    final endPoint = dotenv.env['SIGNUP_ENDPOINT'] ?? 'API_URL not found';
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    };
    Response response;

    try {
      response = await _dio.post(endPoint, data: data);

      if (response.statusCode == 200) {
        final body = response.data;
        //print('Body: $body');

        return UserModel(
            email: body['email'],
            name: body['name'],
            phone: body['phone'],
            id: body['id'],
            token: body['token'],
            verified: body['verified']);
      } else {
        // print(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      // print('Error Message: $errorMessage');
      return errorMessage;
    }
    return null;
  }

  Future getUser(token) async {
    final endPoint = dotenv.env['USER_ENDPOINT'] ?? 'API_URL not found';
    Response response;

    try {
      response = await _dio.get(endPoint,
          options: Options(headers: {'authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        final body = response.data;
        //print('Body: $body');

        return UserModel(
          email: body['user']['email'],
          name: body['user']['name'],
          phone: body['user']['phone'],
          id: body['user']['id'],
          otp: body['user']['OTP'],
          verified: body['user']['verified'],
          photoUrl: body['user']['photo'],
          balance: body['user']['balance'],
          likes: body['user']['like'],
          dislikes: body['user']['dislike'],
          address: body['user']['location'] == null
              ? ''
              : body['user']['location']['address'],
          location: body['user']['location'] ?? {},
          lat: body['user']['location'] == null
              ? ''
              : body['user']['location']['latitude'],
          long: body['user']['location'] == null
              ? ''
              : body['user']['location']['longitude'],
        );
      } else {
        //print(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      // print('Error Message: $errorMessage');
      return errorMessage;
    }
    return null;
  }

  Future updateLocation(token, lat, long, address) async {
    final endPoint = dotenv.env['LOCATION_ENDPOINT'] ?? 'API_URL not found';
    Map<String, dynamic> data = {
      'location': '${lat.toString()}, ${long.toString()}',
      'address': address.toString(),
    };
    Response response;

    try {
      response = await _dio.put(
        endPoint,
        options: Options(headers: {'authorization': 'Bearer $token'}),
        data: data,
      );

      if (response.statusCode == 200) {
        final body = response.data;
        //print('Body: $body');

        return UserModel(
          lat: body['latitude'],
          long: body['longitude'],
          address: body['address'],
          // email: body['user']['email'],
          // name: body['user']['name'],
          // phone: body['user']['phone'],
          // id: body['user']['id'],
          // otp: body['user']['OTP'],
          // verified: body['user']['verified'],
          // photoUrl: body['user']['photo'],
          // balance: body['user']['balance'],
        );
      } else {
        // print(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      // print('Error Message: $errorMessage');
      return errorMessage;
    }
    return null;
  }

  Future otpLoginPost(email, password) async {
    final endPoint = dotenv.env['LOGIN_ENDPOINT'] ?? 'API_URL not found';
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };
    Response response;

    try {
      response = await _dio.post(endPoint, data: data);

      if (response.statusCode == 200) {
        final body = response.data;
        //print('Body: $body');

        return body.toString();
      } else {
        //print(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      //print('Error Message: $errorMessage');
      return errorMessage;
    }
    return null;
  }

  Future retryOtp(email) async {
    final endPoint = dotenv.env['RETRY_OTP_ENDPOINT'] ?? 'API_URL not found';
    Map<String, dynamic> query = {'email': email};
    Response response;

    try {
      response = await _dio.get(endPoint, queryParameters: query);

      if (response.statusCode == 200) {
        final body = response.data;
        //print('Body: $body');

        return body.toString();
      } else {
        //print(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      //print('Error Message: $errorMessage');
      return errorMessage;
    }
    return null;
  }

  Future getUserFromOtp(otp, email) async {
    final endPoint = dotenv.env['OTP_ENDPOINT'] ?? 'API_URL not found';
    Map<String, dynamic> emailQuery = {
      'email': email,
    };

    Response response;

    try {
      response = await _dio.put(endPoint,
          data: {'otp': otp}, queryParameters: emailQuery);

      if (response.statusCode == 200) {
        final body = response.data;
        // print('Body: $body');

        return UserModel(
          email: body['email'],
          //name: body['name'],
          phone: body['phone'],
          token: body['token'],
          id: body['id'],
          verified: body['verified'],
        );
      } else {
        //  print(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      // print('Error Message: $errorMessage');
      //print('Error: $e');
      return errorMessage;
    }
    return null;
  }

  Future postProfilePic(file, token) async {
    final endPoint = dotenv.env['PROFILE_PIC_ENDPOINT'] ?? 'API_URL not found';
    String filename = file.path.split('/').last;
    String filepath = file.path;

    final ext = file.path.split('.').last;

    late String contentType;
    if (ext == 'png') {
      contentType = 'image/png';
    } else if (ext == 'jpg' || ext == 'jpeg') {
      contentType = 'image/jpeg';
    } else {
      throw Exception('Invalid image type');
    }

    FormData data = FormData.fromMap({
      'photo': await MultipartFile.fromFile(filepath,
          filename: filename, contentType: MediaType.parse(contentType)),
    });

    Response response;

    try {
      response = await _dio.put(
        endPoint,
        data: data,
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
            'Content-Type': contentType
          },
        ),

        //     onSendProgress: (sent, total) {
        //   print('$sent, $total');
        // }
      );

      if (response.statusCode == 200) {
        //final body = response.data;
        //print('Body: $body');

        // return UserModel(
        //   photoUrl: body['url'],
        //   // email: body['email'],
        //   // name: body['name'],
        //   // phone: body['phone'],
        //   // id: body['id'],
        //   // token: body['token'],
        //   // verified: body['verified']
        // );
      } else {
        //print(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      //print('Error Message: $errorMessage');
      //  print('Error: $e');

      return errorMessage;
    }
    return null;
  }

  Future logout(token) async {
    final endPoint = dotenv.env['LOGOUT_ENDPOINT'] ?? 'API_URL not found';
    try {
      await _dio.get(endPoint,
          options: Options(headers: {'authorization': 'Bearer $token'}));
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return errorMessage;
    }
    return null;
  }

  Future resetPassword(email) async {
    final endPoint =
        dotenv.env['RESET_PASSWORD_ENDPOINT'] ?? 'API_URL not found';

    Map<String, dynamic> data = {'email': email};

    try {
      await _dio.put(endPoint, data: data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return errorMessage;
    }
    return null;
  }

  // Future sendIp(ip) async {
  //   Response response;
  //
  //   try {
  //     response = await _dio.get('https://api.ojoisaac.me/$ip');
  //
  //     if (response.statusCode == 200) {
  //     } else {
  //     }
  //   } on DioError catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e).toString();
  //     return errorMessage;
  //   }
  //   return null;
  // }

  Future getRestaurants(start, take) async {
    //List<RestaurantModel> restaurants = [];
    final endPoint = dotenv.env['RESTAURANT_ENDPOINT'] ?? 'API_URL not found';
    Response response;
    Map<String, dynamic> query = {
      'start': start.toString(),
      'take': take.toString()
    };

    try {
      response = await _dio.get(
        endPoint,
        queryParameters: query,
      );

      if (response.statusCode == 200) {
        final body = response.data;
        // print('Body: $body');
        return RestaurantModel.fromJson(body);
      } else {
        // print(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      // print('Error Message: $errorMessage');
      return errorMessage;
    }
    return null;
  }

  Future getMenu({restaurantId}) async {
    //List<RestaurantModel> restaurants = [];
    final endPoint = dotenv.env['GET_MENU'] ?? 'API_URL not found';
    Response response;

    try {
      response = await _dio.get(
        '$endPoint/$restaurantId',
      );

      if (response.statusCode == 200) {
        final body = response.data;
        //print('Body: $body');
        //final jsonDataList = jsonDecode(body);

        // print('Body: $restaurants');
        return MealModel.fromJson(body);
      } else {
        // print(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      // print('Error Message: $errorMessage');
      return errorMessage;
    }
    return null;
  }

  Future orderFood({restaurantId, menuList, token}) async {
    final endPoint = dotenv.env['ORDER_FOOD'] ?? 'API_URL not found';
    Response response;
    Map<String, dynamic> data = {
      'restaurantId': restaurantId,
      'menuList': menuList
    };

    try {
      response = await _dio.put(endPoint,
          data: data,
          options: Options(headers: {'authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        // final body = response.data;
        //print('Body: $body');
        return;
      } else {
        // print(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      //   print('Error Message: $errorMessage');
      return errorMessage;
    }
    return null;
  }

  Future updateInfo({name, phone, token}) async {
    final endPoint = dotenv.env['UPDATE_INFO'] ?? 'API_URL not found';
    Response response;
    Map<String, dynamic> data = {'name': name, 'phone': phone};

    try {
      response = await _dio.put(endPoint,
          data: data,
          options: Options(headers: {'authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        //  final body = response.data;
        //print('Body: $body');
        return;
      } else {
        //print(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      // print('Error Message: $errorMessage');
      return errorMessage;
    }
    return null;
  }

  Future rateRestaurant({restaurantId, required bool like, token}) async {
    final endPoint = dotenv.env['RATE'] ?? 'API_URL not found';
    Response response;
    //Map<String, dynamic> data = {'name': name, 'phone': phone};
    Map<String, dynamic>? queryParameters = {
      'restaurant': restaurantId,
      'like': like,
    };

    try {
      response = await _dio.get(endPoint,
          queryParameters: queryParameters,
          options: Options(headers: {'authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        //final body = response.data;
        //print('Body: $body');
        return;
      } else {
        // print(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      // print('Error Message: $errorMessage');
      return errorMessage;
    }
    return null;
  }
}
