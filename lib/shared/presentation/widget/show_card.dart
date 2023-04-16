import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laboratory/shared/presentation/widget/card_detail.dart';
import 'package:skeletons/skeletons.dart';

import '../screens/appoitment_detail_screen.dart';

class ShowCard extends StatelessWidget {
  final String status, staffId;
  const ShowCard({Key? key, required this.staffId, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("appointments")
          .orderBy('date')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot doc = snapshot.data!.docs[index];
              print('docData');
              print(doc);
              // final DateTime now = doc['date'];
              // final DateFormat formatter = DateFormat('dd MMM yyyy');
              // final DateFormat timeformatter = DateFormat('hh:mm a');
              // final String formatted = formatter.format(now);
              // final String timeFormated = timeformatter.format(now);
              return doc['status'] == status && doc['staffId'] == staffId
                  ? CardDetail(
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
                    )
                  : SizedBox();
            },
          );
        } else {
          return Skeleton(
            isLoading: true,
            skeleton: SkeletonListView(),
            child: Container(child: Center(child: ListTile())),
          );
        }
      },
    );
  }
}
