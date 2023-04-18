import 'package:laboratory/shared/presentation/model/geolocation_model.dart';
import 'package:laboratory/shared/presentation/model/healthpackage_model.dart';
import 'package:laboratory/shared/presentation/model/staff_model.dart';
import 'package:laboratory/shared/presentation/model/tests_model.dart';

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
  GeoLocationModel? geoLocation;
  HealthPackageModel? healthPackage;
  List<TestsModel>? tests;
  dynamic staff;
  AppoitmentModel({
    required this.staff,
    required this.address,
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
    staff = json['staff'];
    address = json['address'];
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
    tests = [...json['tests']];
    time = json['time'];
    uId = json['uId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['staff'] = staff;
    data['address'] = address;
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
