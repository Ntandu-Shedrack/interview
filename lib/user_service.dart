import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

class UserService {
  final String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$_baseUrl/users'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;
      return jsonList.map((json) => User.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
