import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = Dio();
  dio.options.baseUrl = 'https://tasks.mosh-group.com/api/v1/';
  dio.options.headers['Accept'] = 'application/json';
  return dio;
}
