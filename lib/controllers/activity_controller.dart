
import 'package:waste_to_wealth/models/activity_model.dart';
import 'package:waste_to_wealth/services/api_service.dart';

class ActivityController {
  final ApiService _apiService = ApiService();

  Future<List<Activity>> fetchActivities() {
    return _apiService.fetchActivities();
  }
}