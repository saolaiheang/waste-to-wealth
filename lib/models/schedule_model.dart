class ScheduleModel {
  final int id;
  final String userId;
  final String date;
  final List<String> wasteTypes;
  final double estimateWeight;
  final bool recurring;

  ScheduleModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.wasteTypes,
    required this.estimateWeight,
    required this.recurring,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'] ?? 0, // Provide a default value if null
      userId: json['userId'] ?? '',
      date: json['date'] ?? '',
      wasteTypes: (json['wasteTypes'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      estimateWeight: (json['estimateWeight'] as num?)?.toDouble() ?? 0.0, // Convert safely
      recurring: json['recurring'] ?? false,
    );
  }
}
