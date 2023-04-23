import 'dart:convert';

import 'package:accurate_laboratry/shared/presentation/model/image_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';

import 'package:skeletons/skeletons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants.dart';
import '../../data/data_source/call_data.dart';
import '../../data/data_source/get_appoitment_data.dart';
import '../../data/data_source/get_current_location.dart';
import '../model/appoitment_model.dart';
import '../model/geolocation_model.dart';
import '../model/healthpackage_model.dart';
import '../model/plans_model.dart';
import '../model/staff_model.dart';
import '../model/tests_model.dart';
import '../widget/common_button.dart';
import '../widget/show_text.dart';
import 'map_show.dart';
import 'package:map_launcher/map_launcher.dart' as mapLauncher;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:intl/intl.dart';

import '../../data/data_source/change_status_data.dart';

class AppoitmentDetailScreen extends StatefulWidget {
  // final String name, date, slot, email, mobile, healthPackage, address, status;
  // final List<dynamic> test;
  final String appoitmentId;
  const AppoitmentDetailScreen({
    Key? key,
    required this.appoitmentId,
  }) : super(key: key);

  @override
  State<AppoitmentDetailScreen> createState() => _AppoitmentDetailScreenState();
}

class _AppoitmentDetailScreenState extends State<AppoitmentDetailScreen> {
  String dropdownValue = 'Ongoing';

  List<String> dropdownItems = [
    'Ongoing',
    'Completed',
  ];
  AppoitmentModel? selectedAppoitmentData;
  getSelectedAppotment() async {
    var appoitment = Appoitment();
    Map<String, dynamic> appoitmentData =
        await appoitment.getAppoitment(widget.appoitmentId);

    appoitmentData['geoLocation'] =
        GeoLocationModel.fromJson(appoitmentData['geoLocation']);
    appoitmentData['healthPackage'] =
        HealthPackageModel.fromJson(appoitmentData['healthPackage']);
    appoitmentData['staff'] = StaffModel.fromJson(appoitmentData['staff']);

    List<dynamic>? tests = appoitmentData['tests'] as List;
    // List<dynamic>? images = appoitmentData['images'] as List;

    List<TestsModel> selectedTests = [];
    for (var item in appoitmentData['tests']) {
      var plans = item?['plans']!.map((i) => PlansModel.fromJson(i)).toList();
      item['plans'] = plans;
      selectedTests.add(TestsModel.fromJson(item));
    }
    //List<ImageModel> selectedImages = [];

    //   print(appoitmentData['images']);
    // for (var item in appoitmentData['images']) {
    //   print(item);
    //   var image =
    //       appoitmentData['images']!.map((i) => ImageModel.fromJson(i)).toList();
    //   print('=======');
    //   print(image);
    //   selectedImages.add(image);
    //   print(selectedImages);
    // }
    // //   print(selectedImages);
    //appoitmentData['images'] = selectedImages;
    appoitmentData['tests'] = selectedTests;
    selectedAppoitmentData = AppoitmentModel.fromJson(appoitmentData);
    print('11111111111111111111111111111111111111111');
    print(selectedAppoitmentData);
  }

  double? currentLattitude, currentLongitude;
  getCurrentLocarion() async {
    var location = CurrentLocation();
    var newLocation =  await location.getCurrentLocation();

    setState(() {
      currentLattitude = location.latitude??newLocation.latitude;
      currentLongitude = location.longitude??newLocation.longitude;
    });
    print('======Current Location=====');
    print(currentLattitude);
    print(currentLongitude);
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocarion();
    getSelectedAppotment();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedAppoitmentData != null) {
      final DateTime now =
          DateTime.parse(selectedAppoitmentData!.date.toString());
      final DateFormat formatter = DateFormat('dd-MMM-yyyy');
      final String formatted = formatter.format(now);
      print(formatted);
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: selectedAppoitmentData == null
              ? Text('')
              : Text(selectedAppoitmentData != null
                  ? selectedAppoitmentData!.name.toString()
                  : ''),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ShowText(
                      label: 'Date:',
                      detail: formatted.toString(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    ShowText(
                        label: 'Slot:',
                        detail: selectedAppoitmentData!.time.toString()),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    ShowText(
                      label: 'Email:',
                      detail: selectedAppoitmentData!.email.toString(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShowText(
                      label: 'Mobile:',
                      detail: selectedAppoitmentData!.mobile.toString(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    selectedAppoitmentData!.healthPackage!.active == true
                        ? ShowText(
                            label: 'Health Package:',
                            detail: selectedAppoitmentData!.healthPackage!.name
                                .toString())
                        : ShowText(
                            label: 'Health Package:',
                            detail: 'No Package'.toString(),
                          ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    ShowText(
                      label: 'Test:',
                      detail: selectedAppoitmentData!.tests!
                          .map((e) => e.name)
                          .toString(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    ShowText(
                      label: 'Address:',
                      detail: selectedAppoitmentData!.address.toString(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                selectedAppoitmentData!.images?[0]['url'] == null
                    ? SizedBox()
                    : Container(
                        height: 100,
                        width: 100,
                        color: backgroundColor,
                        child: FullScreenWidget(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              selectedAppoitmentData!.images[0]['url']
                                  .toString(),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                Container(
                  height: 300,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    border: Border.all(
                      width: 0.4,
                      color: Colors.black,
                    ),
                  ),
                  child: GoogleMapScreen(
                    latitude:
                        selectedAppoitmentData!.geoLocation!.lat!.toDouble(),
                    longitude:
                        selectedAppoitmentData!.geoLocation!.long!.toDouble(),
                  ),
                ),
                selectedAppoitmentData!.status == 'Completed'
                    ? SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: SizedBox(
                              height: 40,
                              width: 150,
                              child: CommonButton(
                                buttonName: 'Get Direction',
                                onPresse: () async {
                                  setState(() {
                                    mapLauncher.MapLauncher.showDirections(
                                      mapType: mapLauncher.MapType.google,
                                      origin: mapLauncher.Coords(
                                        currentLattitude!,
                                        currentLongitude!,
                                      ),
                                      originTitle: 'Your Locations',
                                      directionsMode:
                                          mapLauncher.DirectionsMode.driving,
                                      destinationTitle: 'Destination Location',
                                      destination: mapLauncher.Coords(
                                        selectedAppoitmentData!
                                            .geoLocation!.lat!
                                            .toDouble(),
                                        selectedAppoitmentData!
                                            .geoLocation!.long!
                                            .toDouble(),
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: SizedBox(
                              height: 40,
                              width: 150,
                              child: CommonButton(
                                buttonName: 'Make Call',
                                onPresse: () async {
                                  var call = Call();
                                  await call.makeCall(selectedAppoitmentData!
                                      .mobile
                                      .toString());
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                selectedAppoitmentData!.status == 'Completed'
                    ? SizedBox()
                    : Text(
                        'Select Your Status:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                SizedBox(
                  height: 10,
                ),
                selectedAppoitmentData!.status == 'Completed'
                    ? SizedBox()
                    : Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              //dropdownColor: Colors.greenAccent,
                              value: dropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: dropdownItems
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            height: 40,
                            width: 100,
                            child: CommonButton(
                              buttonName: 'Update',
                              onPresse: () {
                                setState(() {
                                  changeStatus(
                                      dropdownValue, widget.appoitmentId);
                                  print(dropdownValue);
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: Container(
              color: backgroundColor,
              child: Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
