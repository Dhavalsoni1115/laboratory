class Plans {
  String? planId, planName, price;
  Plans({
    required this.planId,
    required this.planName,
    required this.price,
  });
  Plans.fromJson(Map<String, dynamic> json) {
    planId = json['planId'];
    planName = json['planName'];
    price = json['price'].toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['planId'] = planId;
    data['planName'] = planName;
    data['price'] = price;
    return data;
  }
}