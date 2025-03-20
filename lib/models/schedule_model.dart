
class ScheduleModel {
  final int id;
  final String userId;
  final DateTime date;
  final List<String> wasteTypes;
  final int estimateWeight;
  final bool recurring;

  ScheduleModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.wasteTypes,
    required this.estimateWeight,
    required this.recurring,

  });

  factory ScheduleModel.fromJson(Map<String,dynamic>json){
    return ScheduleModel(
      id: json['id'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      wasteTypes: List<String>.from(json['wasteTypes']),
      estimateWeight: json['estimateWeight'],
      recurring: json['recurring'],

    );


  }
  Map<String,dynamic>toJson(){
    return {
      'id':id,
      'userId':userId,
      'date':date.toIso8601String(),
      'wasteTypes':wasteTypes,
      'estimateWeight':estimateWeight,
      'recurring':recurring,
    
    };
  }

}