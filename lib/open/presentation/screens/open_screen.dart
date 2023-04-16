import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laboratory/constants.dart';
import 'package:laboratory/shared/data/data_source/get_appoitment_data.dart';
import 'package:laboratory/shared/presentation/model/appoitment_model.dart';
import 'package:laboratory/shared/presentation/screens/appoitment_detail_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skeletons/skeletons.dart';

import '../../../shared/presentation/widget/card_detail.dart';
import 'package:intl/intl.dart';

class OpenScreen extends StatefulWidget {
  final String staffId;
  const OpenScreen({Key? key, required this.staffId}) : super(key: key);

  @override
  State<OpenScreen> createState() => _OpenScreenState();
}

class _OpenScreenState extends State<OpenScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('====Id====');
    print(widget.staffId);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: StreamBuilder<QuerySnapshot>(
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
                return doc['status'] == 'Open' &&
                        doc['staffId'] == widget.staffId.toString()
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
      ),
    );
  }
}
