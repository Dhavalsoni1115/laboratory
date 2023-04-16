import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laboratory/constants.dart';
import 'package:laboratory/shared/presentation/screens/appoitment_detail_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skeletons/skeletons.dart';

import '../../../shared/presentation/widget/card_detail.dart';
import 'package:intl/intl.dart';

class CompleteScreen extends StatelessWidget {
  const CompleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection("appointments").orderBy('date').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];
                final DateTime now = doc['date'].toDate();
                final DateFormat formatter = DateFormat('dd MMM yyyy');
                final DateFormat timeformatter = DateFormat('hh:mm a');
                final String formatted = formatter.format(now);
                final String timeFormated = timeformatter.format(now);
                print(timeFormated);
                return doc['status'] == 'Completed'
                    ? CardDetail(
                        name: doc['name'],
                        email: doc['email'],
                        mobileNumber: doc['mobile'].toString(),
                        date: formatted.toString(),
                        time: timeFormated.toString(),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppoitmentDetailScreen(
                                appoitmentId: doc.id.toString(),
                              ),
                            ),
                          );
                        },
                      )
                    : SizedBox();
              },
            );
          } else {
            return  Skeleton(
              isLoading: true,
              skeleton: SkeletonListView(),
              child: Container(child: Center(child: ListTile())),
            );
          }
        },
      ),
    );
  }
}
