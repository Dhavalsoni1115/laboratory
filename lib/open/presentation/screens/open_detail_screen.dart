import 'package:flutter/material.dart';
import 'package:laboratory/constants.dart';
import 'package:laboratory/shared/presentation/widget/common_button.dart';
import 'package:laboratory/shared/presentation/widget/show_text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../shared/presentation/screens/map_show.dart';
import 'package:map_launcher/map_launcher.dart' as mapLauncher;

class OpenDetailScreen extends StatefulWidget {
  const OpenDetailScreen({Key? key}) : super(key: key);

  @override
  State<OpenDetailScreen> createState() => _OpenDetailScreenState();
}

class _OpenDetailScreenState extends State<OpenDetailScreen> {
  String dropdownValue = 'Ongoing';

  // List of items in our dropdown menu
  var items = [
    'Ongoing',
    'Completed',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Dhaval Soni'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  ShowText(label: 'Email:', detail: 'Dhaval@gmail.com'),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  ShowText(label: 'Mobile:', detail: '8320069125'),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  ShowText(label: 'Health Package:', detail: 'Normal'),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  ShowText(label: 'Test:', detail: 'heart'),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  ShowText(label: 'Address:', detail: 'Sonivard,Bilimora.'),
                ],
              ),
              Container(
                height: 300,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.3,
                    color: Colors.black,
                  ),
                ),
                child: GoogleMapScreen(),
              ),
              Row(
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
                              origin: mapLauncher.Coords(20.7702, 72.9824),
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
                          Uri phoneno = Uri.parse('tel:8320069125');
                          if (await launchUrl(phoneno)) {
                            await launchUrl(phoneno);
                          } else {
                            print('No dail');
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
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
                      items: <String>['Ongoing', 'Completed']
                          .map<DropdownMenuItem<String>>((String value) {
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
                      onPresse: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
