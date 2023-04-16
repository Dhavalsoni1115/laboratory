import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laboratory/constants.dart';
import 'package:laboratory/home/presentation/screens/home_screen.dart';
import 'package:laboratory/shared/data/data_source/call_data.dart';
import 'package:laboratory/open/presentation/screens/open_screen.dart';
import 'package:laboratory/shared/data/data_source/get_appoitment_data.dart';
import 'package:laboratory/shared/presentation/model/appoitment_model.dart';
import 'package:laboratory/shared/presentation/widget/common_button.dart';
import 'package:laboratory/shared/presentation/widget/show_text.dart';
import 'package:skeletons/skeletons.dart';
import 'package:url_launcher/url_launcher.dart';
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
  getSelectedStaff() async {
    var appoitment = Appoitment();
    dynamic appoitmentData =
        await appoitment.getAppoitment(widget.appoitmentId);
    print(appoitmentData);
    selectedAppoitmentData = AppoitmentModel.fromJson(appoitmentData);
    // selectedAppoitmentData!.geoLocation =
    //     GeoLocation.fromJson(appoitmentData?['geoLocation']);

    // selectedAppoitmentData!.healthPackage =
    //     HealthPackage.fromJson(appoitmentData?['healthPackage']);
    // selectedAppoitmentData!.tests = Tests.fromJson(appoitmentData?['tests']);

    //  print(selectedAppoitmentData!.geoLocation!.toJson().toString());

    print(selectedAppoitmentData);
    setState(() {
      selectedAppoitmentData;
    });
  }

  @override
  void initState() {
    super.initState();
    getSelectedStaff();
    //changeStatus();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedAppoitmentData != null) {
      // final DateTime now = selectedAppoitmentData!.date!.toDate();
      // final DateFormat formatter = DateFormat('dd MMM yyyy');
      // final String formatted = formatter.format(now);
      // print(formatted);
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
                      detail: selectedAppoitmentData!.date.toString(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    ShowText(label: 'Slot:', detail: '8:00 to 8:30 AM'),
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
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        var call = Call();
                        await call.makeCall(
                            selectedAppoitmentData!.mobile.toString());
                      },
                      child: ShowText(
                        label: 'Mobile:',
                        detail: selectedAppoitmentData!.mobile.toString(),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        var call = Call();
                        await call.makeCall(
                            selectedAppoitmentData!.mobile.toString());
                      },
                      icon: Icon(
                        Icons.call,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                // Row(
                //   children: [
                //     ShowText(
                //         label: 'Health Package:',
                //         detail: selectedAppoitmentData!.healthPackage!.name
                //             .toString()),
                //   ],
                // ),
                SizedBox(
                  height: 15,
                ),
                // Row(
                //   children: [
                //     ShowText(
                //         label: 'Test:',
                //         detail: selectedAppoitmentData!.tests.toString()),
                //   ],
                // ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    ShowText(
                        label: 'Address:',
                        detail: selectedAppoitmentData!.address.toString()),
                  ],
                ),
                Container(
                  height: 300,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.3,
                      color: Colors.black,
                    ),
                  ),
                  child: const GoogleMapScreen(
                    latitude: 20.5965,
                    longitude: 72.8996,
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
                                onPresse: () {
                                  setState(() {
                                    mapLauncher.MapLauncher.showDirections(
                                      mapType: mapLauncher.MapType.google,
                                      origin:
                                          mapLauncher.Coords(20.7702, 72.9824),
                                      originTitle: 'Your Locations',
                                      directionsMode:
                                          mapLauncher.DirectionsMode.driving,
                                      destinationTitle: 'Destination Location',
                                      destination: mapLauncher.Coords(
                                        20.5992,
                                        72.9342,
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
              ],
            ),
          ),
        ),
      );
    } else {
      return
          // Skeleton(
          //   isLoading: true,
          //   skeleton: SkeletonListView(),
          //   child: Container(child: Center(child: ListTile())),
          // );
          // ProgressIndicator();
          Center(
        child: LoadingAnimationWidget.twistingDots(
          leftDotColor: primaryColor,
          rightDotColor: secondaryColor,
          size: 200,
        ),
      );
    }
  }
}
