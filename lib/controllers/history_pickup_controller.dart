import 'package:waste_to_wealth/services/api_service.dart';
import 'package:waste_to_wealth/models/history_pickup_model.dart';
class HistoryPickupController {
  final _apiService = ApiService();
  Future<List<HistoryPickupModel>> fetchHistoryPickup(){
    return _apiService.fetchHistoryPickup();
  }

  Future <List<HistoryPickupModel>>deleteHistoryPickup(int pickupId){
    return _apiService.deleteHistoryPickup(pickupId);
  }
}