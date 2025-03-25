class Homescreen {
  final int id;
  final String userId;
  final String? user;
  final String totalPoints;
  final String cashEquivalent;

  Homescreen({
    required this.id,
    required this.userId,
    this.user,
    required this.totalPoints,
    required this.cashEquivalent,
  });

  factory Homescreen.fromJson(Map<String, dynamic> json) {
    return Homescreen(
      id: json['id'],
      userId: json['userId'],
      user: json['user'],
      totalPoints: json['totalPoints'],
      cashEquivalent: json['cashEquivalent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'user': user,
      'totalPoints': totalPoints,
      'cashWquivalent': cashEquivalent,
    };
  }
}