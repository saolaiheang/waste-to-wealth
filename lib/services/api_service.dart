import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:waste_to_wealth/models/user_mdel.dart';
import 'package:waste_to_wealth/services/storage_service.dart';




class ApiService {
  static const String baseUrl = 'https://pay1.jetdev.life';
  final StorageService _storageService = StorageService();

  Future<UserMdel?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/account/login'),
      body: jsonEncode({'username': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final user = UserMdel.fromJson(jsonDecode(response.body));
      if (user.token != null) {
        await _storageService.saveToken(user.token!); // Save token
      }
      return user;
    }
    return null;
  }

  
}
