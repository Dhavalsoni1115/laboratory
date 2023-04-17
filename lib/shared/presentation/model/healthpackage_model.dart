
class HealthPackage {
  bool? active;
  String? description, id, name, parameters, price;
  List<dynamic>? healthTests;
  HealthPackage({
    this.active,
    this.description,
    this.healthTests,
    this.id,
    this.name,
    this.parameters,
    this.price,
  });
  HealthPackage.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    description = json['description'];
    healthTests = [...json['healthTests']];
    id = json['id'].toString();
    name = json['name'];
    parameters = json['parameters'].toString();
    price = json['price'].toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['active'] = active;
    data['description'] = description;
    data['healthTests'] = healthTests;
    data['id'] = id;
    data['name'] = name;
    data['parameters'] = parameters;
    data['price'] = price;

    return data;
  }
}
