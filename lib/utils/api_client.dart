import 'package:dio/dio.dart';

class ApiClient {
  const ApiClient._();

  static const _baseUrl = 'http://flutter-intern.cupidknot.com/api/';

  static final dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: 25000,
      receiveTimeout: 25000,
    ),
  );
}
