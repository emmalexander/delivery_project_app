import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  String? message;
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.connectionError:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.badResponse:
        if (dioError.response!.data != null) {
          message = _handleError(
              dioError.response!.statusCode!, dioError.response!.data);
        } else {
          message =
              _handleError(dioError.response!.statusCode!, dioError.error);
        }

        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioErrorType.unknown:
        //print('Dio: ${dioError.error.toString()}');
        message = dioError.error.toString();
        break;
      case DioErrorType.badCertificate:
        message = "SSL certificate error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String? _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        // List<String> msg = [];
        // if (error['errors'].isNotEmpty || error['errors'] != null) {
        //   for (var e in error['errors']) {
        //     msg.add(e['msg']);
        //   }
        //   return msg.toString();
        // }
        // if (error['errors'].isEmpty || error['errors'] == null) {
        //   return error.toString();
        // }
        // return null;
        return error.toString();

      case 401:
        return error.toString();
      case 500:
        return 'Internal server error';
      default:
        return error.toString();
    }
  }

  @override
  String toString() => message!;
}
