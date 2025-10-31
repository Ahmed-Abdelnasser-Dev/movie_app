import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_constants.dart';

class DioFactory {
  static Dio? _dio;

  static Dio getDio() {
    if (_dio == null) {
      _dio = Dio(BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ));

      _dio!.options.headers = {
        'Authorization': 'Bearer ${dotenv.env['TMDB_ACCESS_TOKEN']}',
        'accept': 'application/json',
      };

      _dio!.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
      ));
    }
    return _dio!;
  }
}
