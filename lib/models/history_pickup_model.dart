
class HistoryPickupModel {
  final int pickupId;
  final String date;
  final String status;
  final List<String> wasteTypes;

  HistoryPickupModel({
    required this.pickupId,
    required this.date,
    required this.status,
    required this.wasteTypes,
  });
factory HistoryPickupModel.fromJson(Map<String, dynamic> json) {
  return HistoryPickupModel(
    pickupId: json['pickupId'] ?? 0, 
    date: json['date'] ?? "", 
    status: json['status'] ?? "",
    wasteTypes: (json['wasteTypes'] as List?)?.map((e) => e.toString()).toList() ?? [],
  );
}

}
