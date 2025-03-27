
import 'package:waste_to_wealth/models/redeem_model.dart';
import 'package:waste_to_wealth/services/api_service.dart';

class RedeemController {
  final ApiService _apiService = ApiService();

  Future<List<Redeem>> fetchRedeems() {
    return _apiService.fetchRedeems();
  }
}