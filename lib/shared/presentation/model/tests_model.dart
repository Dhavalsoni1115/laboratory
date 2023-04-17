import 'package:laboratory/shared/presentation/model/plans_model.dart';

class Tests {
  String? homeCollection, id, name, price;
  List<Plans>? plans;
  bool? outSource, active;
  Tests({
    this.active,
    this.id,
    this.homeCollection,
    this.name,
    this.outSource,
    this.plans,
    this.price,
  });
  Tests.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    id = json['id'].toString();
    homeCollection = json['homeCollection'];
    name = json['name'];
    outSource = json['outSource'];
    plans = [...json['plans']];
    price = json['price'].toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['active'] = active;
    data['id'] = id;
    data['homeCollection'] = homeCollection;
    data['name'] = name;
    data['outSource'] = outSource;
    data['plans'] = plans;
    data['price'] = price;
    return data;
  }
}