import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:waste_to_wealth/models/homescreen_model.dart';
import 'package:waste_to_wealth/models/user_mdel.dart';
import 'package:waste_to_wealth/services/storage_service.dart';
import 'package:waste_to_wealth/models/schedule_model.dart';
import 'package:waste_to_wealth/models/activity_model.dart';

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
      "wasteTypes": wasteTypes.isNotEmpty ? wasteTypes : [],
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
      final decodedData = jsonDecode(response.body);

      if (decodedData is List) {
        return decodedData.map((json) => ScheduleModel.fromJson(json)).toList();
      } else if (decodedData is Map<String, dynamic>) {
        return [ScheduleModel.fromJson(decodedData)];
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to create schedule');
    }
  }


  Future<List<Activity>> fetchActivities({int limit = 20}) async {
    final token = await _storageService.getToken(); // Retrieve token
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/account/activity?limit=$limit'),
      headers: {'Authorization': 'Bearer $token'}, // Use token
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Activity.fromJson(json)).toList();
    }
    return [];
  }
  


  
  Future<int> fetchTotalPoints() async {
  final token = await _storageService.getToken();
  if (token == null) {
    throw Exception('Token not found');
  }

  final response = await http.get(
    Uri.parse('$baseUrl/api/account/points'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print(data); // Debugging to check API response

    if (data.containsKey('totalPoints') && data['totalPoints'] is int) {
      return data['totalPoints']; // Return the integer value directly
    } else {
      throw Exception('Invalid response format: totalPoints is missing or not an integer');
    }
  }

  throw Exception('Failed to fetch points');
}

}






