import 'package:cupid_knot_assessment_test/models/user.dart';
import 'package:cupid_knot_assessment_test/utils/api_client.dart';
import 'package:cupid_knot_assessment_test/utils/globals.dart';
import 'package:cupid_knot_assessment_test/utils/helpers.dart';
import 'package:dio/dio.dart';

class UserRepository {
  const UserRepository._();

  static const _id = 'UserRepository';

  static final _dio = ApiClient.dio;

  static Future<User?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );

      if (res.data is Map) {
        final msg = res.data?['message'];
        showSnackBar(msg);

        if (res.data.containsKey('success') && !res.data['success']) {
          return null;
        }

        if (res.statusCode! >= 200 && res.statusCode! < 300) {
          Globals.accessToken = res.data['data']['token'];
          return User.fromJson(res.data['data']['user_details']);
        }
      }
    } on DioError catch (e) {
      final data = e.response?.data;
      String? msg = data?['message'];

      if (msg == 'Validation Error.') {
        final errors = [for (final err in data?['data'].values) ...err];
        if (errors.isNotEmpty) msg = errors.first;
      }

      showSnackBar(msg ?? 'Something went wrong!');
      log(_id, error: e.response);
    }
    return null;
  }

  static Future<User?> registerUser(Map<String, dynamic> data) async {
    try {
      final res = await _dio.post('/register', data: data);

      if (res.data is Map) {
        final msg = res.data?['message'];
        showSnackBar(msg);

        if (res.data.containsKey('success') && !res.data['success']) {
          return null;
        }

        if (res.statusCode! >= 200 && res.statusCode! < 300) {
          Globals.accessToken = res.data['data']['token'];
          return User.fromJson(res.data['data']['user_details']);
        }
      }
    } on DioError catch (e) {
      final data = e.response?.data;
      String? msg = data?['message'];

      if (msg == 'Validation Error.') {
        final errors = [for (final err in data?['data'].values) ...err];
        if (errors.isNotEmpty) msg = errors.first;
      }

      showSnackBar(msg ?? 'Something went wrong!');
      log(_id, error: e.response);
    }
    return null;
  }
}
