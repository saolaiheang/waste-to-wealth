import 'package:waste_to_wealth/models/schedule_model.dart';
import 'package:waste_to_wealth/services/api_service.dart';

class ScheduleController {
  final ApiService _apiService = ApiService();

  Future<List<ScheduleModel>> createNewSchedule({
    required String userId,
    required String date,
    required List<String> wasteTypes,
    required double estimateWeight,
    required bool recurring,
  }) async {
    return await _apiService.createNewSchedule(
      userId: userId,
      date: date,
      wasteTypes: wasteTypes,
      estimateWeight: estimateWeight,
      recurring: recurring,
    );
  }
}