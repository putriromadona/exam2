import 'dart:convert';

import 'package:exam/models/user.dart';
import 'package:http/http.dart' as http;

class UserService{
static const String baseUrl = 'https://jsonplaceholder.typicode.com/albums';
static Future<List<User>> fetchUsers() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/1/photos'));

    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(response.body);
      
      List<User> users = 
      result.map((userjson) => User.fromJson(userjson)).toList();

      return users;
    }else {
      throw Exception('failed to load users');
    }
  }catch (e) {
    throw Exception(e.toString());
  }
}
}