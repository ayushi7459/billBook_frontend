import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:general/models/user.dart';

class UserService {
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<List<User>> fetchUser() async {
    final url = Uri.parse(baseUrl);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> userJson = jsonDecode(response.body)['users'];
        return userJson
            .map((json) => User.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data $e');
    }
  }

  Future<bool> addUser(User user) async {
    final url = Uri.parse('$baseUrl/add');
    try {
      final response = await http.post(
        url,
        body: jsonEncode(user.toJson()),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to add user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
