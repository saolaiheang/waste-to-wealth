
import 'package:waste_to_wealth/services/api_service.dart';

class TotalPointsController {
  final ApiService _apiService = ApiService();


  Future<int> fetchHomescreen() {
    return _apiService.fetchTotalPoints();
  }

}