import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:waste_to_wealth/models/user_mdel.dart';
import 'package:waste_to_wealth/services/storage_service.dart';
import 'package:waste_to_wealth/models/schedule_model.dart';
import 'package:waste_to_wealth/models/activity_model.dart';
import 'package:waste_to_wealth/models/history_pickup_model.dart';

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

  Future<List<HistoryPickupModel>> fetchHistoryPickup() async {
    final token = await _storageService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/pickup/history'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<HistoryPickupModel> historyList =
            data.map((item) => HistoryPickupModel.fromJson(item)).toList();

        return historyList;
      } else {
        print("Error fetching data: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print("API Error: $e");
      }
      return [];
    }
  }

  Future<List<HistoryPickupModel>> deleteHistoryPickup(int pickupId) async {
    final token = await _storageService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/pickup/cancel/$pickupId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final jsonData = json.decode(response.body);

          if (jsonData is Map<String, dynamic>) {
            print("API Response: $jsonData"); // Debugging

            if (jsonData.containsKey("message")) {
              print("Pickup canceled: ${jsonData["message"]}");
            }

            return [];
          }

          if (jsonData is List) {
            return jsonData
                .map((item) => HistoryPickupModel.fromJson(item))
                .toList();
          }
        }
        return [];
      } else {
        print("Error fetching data: ${response.statusCode}");
        throw Exception('Failed to delete pickup: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print("API Error: $e");
      }
      throw Exception('Failed to delete pickup: $e');
    }
  }
}
