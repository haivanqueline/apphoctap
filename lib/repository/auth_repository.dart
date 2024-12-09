import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constant/apilist.dart';
import '../models/user.dart';

class AuthRepository {
  final String apiUrl = api_register; 

  Future<void> register(User user) async {
    print(apiUrl);
    print(user.toJson());
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    print('Response ');
    print(response.body);
    if (response.statusCode == 200) {
      
    } else {
      throw Exception("Failed to register");
    }
  }
}
