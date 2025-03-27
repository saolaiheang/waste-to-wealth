class Redeem {
  final String title;
  final String description;
  final int exchangePoint;


  Redeem({
    required this.title,
    required this.description,
    required this.exchangePoint,

  });

  factory Redeem.fromJson(Map<String, dynamic> json) {
    return Redeem(
      title: json['title'],
      description: json['description'],
      exchangePoint: json['exchangePoint']

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'exchangePoint': exchangePoint
    };
  }
}