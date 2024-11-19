import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:general/interceptor/dio_interceptor.dart';
import 'package:general/models/user.dart';

class DioHttp {
  late Dio dio;
  late String baseUrl;

  DioHttp() {
    dio = Dio()..interceptors.add(DioInterceptor());
    baseUrl = dotenv.env['BASE_URL']!;
  }

  Future<List<User>> fetchUser() async {
    try {
      final response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        final List<dynamic> userJson = response.data['users'];
        return userJson
            .map((json) => User.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<bool> addUser(User user) async {
    final url = '$baseUrl/add';
    try {
      final response = await dio.post(
        url,
        data: user.toJson(),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to add user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding user: $e');
    }
  }

  Future<bool> updateUser(User user) async {
    final url = '$baseUrl/update/${user.id}';
    try {
      final response = await dio.post(
        url,
        data: user.toJson(),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }
}
