import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  /// Calls the https://jsonplaceholder.typicode.com/users endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<UserModel>> getUsers();
}

class ServerException implements Exception {
  final String message;
  const ServerException({this.message = 'Server error occurred'});

  @override
  String toString() => 'ServerException: $message';
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;
      return jsonList
          .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw const ServerException(message: 'Failed to load users');
    }
  }
}
