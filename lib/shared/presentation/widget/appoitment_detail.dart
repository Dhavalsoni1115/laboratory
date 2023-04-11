// import 'package:flutter/material.dart';
// import 'package:laboratory/constants.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../shared/presentation/screens/map_show.dart';
// import 'package:map_launcher/map_launcher.dart' as mapLauncher;

// class AppoitmentDetail extends StatelessWidget {
//   //String name, email, mobile, healthPackage, test, address;
//   // AppoitmentDetail({
//   //   required this.name,
//   //   required this.email,
//   //   required this.mobile,
//   //   required this.healthPackage,
//   //   required this.test,
//   //   required this.address,
//   // });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         title: Text('name'),
//         centerTitle: true,
//         backgroundColor: primaryColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     'Email:',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     email,
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     'Mobile:',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     mobile,
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     'Health Package:',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     healthPackage,
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 children: [
//                   ShowText(),
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: RichText(
//                       text: TextSpan(
//                         text: 'Address: ',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                         children: <TextSpan>[
//                           TextSpan(
//                             text: address,
//                             style: TextStyle(
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 height: 300,
//                 width: double.infinity,
//                 margin: const EdgeInsets.symmetric(vertical: 15),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     width: 0.3,
//                     color: Colors.black,
//                   ),
//                 ),
//                 child: const GoogleMapScreen(),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 30),
//                     child: SizedBox(
//                       height: 40,
//                       width: 150,
//                       child: CommonButton(
//                         buttonName: 'Get Direction',
//                         onPresse: () {
//                           setState(() {
//                             mapLauncher.MapLauncher.showDirections(
//                               mapType: mapLauncher.MapType.google,
//                               origin: mapLauncher.Coords(20.7702, 72.9824),
//                               originTitle: 'Your Locations',
//                               directionsMode:
//                                   mapLauncher.DirectionsMode.driving,
//                               destinationTitle: 'Destination Location',
//                               destination: mapLauncher.Coords(
//                                 20.5992,
//                                 72.9342,
//                               ),
//                             );
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 30),
//                     child: SizedBox(
//                       height: 40,
//                       width: 150,
//                       child: MaterialButton(
//                         color: primaryColor,
//                         shape: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide.none),
//                         onPressed: () async {
//                           Uri phoneno = Uri.parse('tel:8320069125');
//                           if (await launchUrl(phoneno)) {
//                             await launchUrl(phoneno);
//                           } else {
//                             print('No dail');
//                           }
//                         },
//                         child: Text(
//                           'Make Call',
//                           style: TextStyle(color: Colors.white, fontSize: 15),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: DropdownButtonFormField(
//                       decoration: InputDecoration(
//                         // enabledBorder: OutlineInputBorder(
//                         //   borderSide:
//                         //       BorderSide(color: Colors.black, width: 0.5),
//                         // ),
//                         // focusedBorder: OutlineInputBorder(
//                         //   borderSide:
//                         //       BorderSide(color: Colors.black, width: 0.5),
//                         // ),
//                         border: InputBorder.none,
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                       //dropdownColor: Colors.greenAccent,
//                       value: dropdownValue,
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           dropdownValue = newValue!;
//                         });
//                       },
//                       items: <String>['Ongoing', 'Completed']
//                           .map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(
//                             value,
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 50,
//                   ),
//                   SizedBox(
//                     height: 40,
//                     width: 100,
//                     child: MaterialButton(
//                       color: primaryColor,
//                       shape: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide.none),
//                       onPressed: () {},
//                       child: Text(
//                         'Update',
//                         style: TextStyle(color: Colors.white, fontSize: 15),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


