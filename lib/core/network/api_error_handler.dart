import 'package:dio/dio.dart';
import 'api_error_model.dart';

class ErrorHandler implements Exception {
  late ApiErrorModel apiErrorModel;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      apiErrorModel = _handleError(error);
    } else {
      apiErrorModel = ApiErrorModel(message: 'Unknown error', code: -1);
    }
  }
}

ApiErrorModel _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return ApiErrorModel(message: 'Connection timeout', code: -1);
    case DioExceptionType.badResponse:
      return ApiErrorModel(
        message: error.response?.data['message'] ?? 'Server error',
        code: error.response?.statusCode ?? 500,
      );
    case DioExceptionType.cancel:
      return ApiErrorModel(message: 'Request cancelled', code: -2);
    default:
      return ApiErrorModel(message: 'No internet connection', code: -3);
  }
}
