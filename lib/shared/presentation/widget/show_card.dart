import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laboratory/shared/presentation/widget/card_detail.dart';
import 'package:skeletons/skeletons.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../data/data_source/get_appoitment_data.dart';
import '../model/appoitment_model.dart';
import '../model/geolocation_model.dart';
import '../model/healthpackage_model.dart';
import '../model/plans_model.dart';
import '../model/staff_model.dart';
import '../model/tests_model.dart';
import '../screens/appoitment_detail_screen.dart';

class ShowCard extends StatefulWidget {
  final String status, staffId;
  const ShowCard({Key? key, required this.staffId, required this.status})
      : super(key: key);

  @override
  State<ShowCard> createState() => _ShowCardState();
}

class _ShowCardState extends State<ShowCard> {
  @override
  Widget build(BuildContext context) {
    var appoitmentData = FirebaseFirestore.instance
        .collection("appointments")
        .where('staffId', isEqualTo: widget.staffId);
    return StreamBuilder(
      stream: appoitmentData.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: primaryColor,
          ));
        }
        if (snapshot.hasData) {
          List<DocumentSnapshot> documents = snapshot.data!.docs;

          documents = documents
              .where((i) => i.data().containsValue(widget.status))
              .toList();

          if (documents.isNotEmpty) {
            documents = documents.where((element) {
              return element.data().containsValue(widget.status);
            }).toList();
          }
          return documents.isNotEmpty
              ? ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshot.data!.docs[index];
                    return CardDetail(
                      name: doc['name'],
                      email: doc['email'],
                      mobileNumber: doc['mobile'].toString(),
                      date: doc['date'].toString(),
                      time: doc['time'],
                      onTap: () {
                        if (doc.id.isEmpty) {
                          return;
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppoitmentDetailScreen(
                                appoitmentId: doc.id,
                              ),
                            ),
                          );
                        }
                      },
                    );
                    // : SizedBox();
                  },
                )
              : Center(
                  child: Text('No Appointment'),
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
      },
    );
  }
}
