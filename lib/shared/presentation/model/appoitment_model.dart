import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class GeoLocation {
  double? lat, long;
  GeoLocation({required this.lat, required this.long});
  GeoLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}

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
    plans = json['plans'];
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
    healthTests = json['healthTests'];
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

class AppoitmentModel {
  int? mobile;
  String? address,
      date,
      discountAmt,
      distance,
      dob,
      email,
      gender,
      grandTotal,
      image,
      name,
      pickupCharge,
      staffId,
      status,
      time,
      uId;
  dynamic geoLocation;
  dynamic healthPackage;
  dynamic tests;
  AppoitmentModel({
    required this.date,
    required this.discountAmt,
    required this.distance,
    required this.dob,
    required this.email,
    required this.gender,
    required this.geoLocation,
    required this.grandTotal,
    required this.healthPackage,
    required this.image,
    required this.mobile,
    required this.name,
    required this.pickupCharge,
    required this.staffId,
    required this.status,
    required this.tests,
    required this.time,
    required this.uId,
  });
  AppoitmentModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    discountAmt = json['discountAmt'].toString();
    distance = json['distance'].toString();
    dob = json['dob'];
    email = json['email'];
    gender = json['gender'];
    geoLocation = json['geoLocation'];
    grandTotal = json['grandTotal'].toString();
    healthPackage = json['healthPackage'];
    image = json['image'].toString();
    mobile = json['mobile'];
    name = json['name'];
    pickupCharge = json['pickupCharge'].toString();
    staffId = json['staffId'];
    status = json['status'];
    tests = json['tests'];
    time = json['time'];
    uId = json['uId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['discountAmt'] = discountAmt;
    data['distance'] = distance;
    data['dob'] = dob;
    data['email'] = email;
    data['gender'] = gender;
    data['geoLocation'] = geoLocation;
    data['grandTotal'] = grandTotal;
    data['healthPackage'] = healthPackage;
    data['image'] = image;
    data['mobile'] = mobile;
    data['name'] = name;
    data['pickupCharge'] = pickupCharge;
    data['staffId'] = staffId;
    data['status'] = status;
    data['tests'] = tests;
    data['time'] = time;
    data['uId'] = uId;
    return data;
  }
}
