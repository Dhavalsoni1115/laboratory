import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laboratory/shared/presentation/widget/card_detail.dart';
import 'package:skeletons/skeletons.dart';
import 'package:intl/intl.dart';

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
              String id =
                  doc.data().containsKey('staffId') ? doc['staffId'] : '';
              print(id);
              // final DateTime now = doc['date'];
              // final DateFormat formatter = DateFormat('dd MMM yyyy');
              // final String formatted = formatter.format(doc['date']);
              // DateFormat.yMMMd().format(DateTime.now());

              return id.isNotEmpty && id == staffId && doc['status'] == status
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
