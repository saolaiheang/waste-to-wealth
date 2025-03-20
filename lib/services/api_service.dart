import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:waste_to_wealth/models/user_mdel.dart';
import 'package:waste_to_wealth/services/storage_service.dart';
import 'package:waste_to_wealth/models/schedule_model.dart';




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
Future<List<ScheduleModel>> createNewSchedule({
  int limit = 20,
  required String userId,
  required String date,
  required List<String> wasteTypes,
  required double estimateWeight,
  required bool recurring,
}) async {
  final token = await _storageService.getToken();
  if (token == null) {
    throw Exception('Token not found');
  }

  // Create the request body
  final requestBody = {
    "userId": userId,
    "date": date,
    "wasteTypes": wasteTypes,
    "estimateWeight": estimateWeight,
    "recurring": recurring,
  };

  final response = await http.post(
    Uri.parse('$baseUrl/api/pickup/schedule?limit=$limit'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(requestBody), // Encode the body to JSON
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => ScheduleModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to create schedule: ${response.body}');
  }
}
}
